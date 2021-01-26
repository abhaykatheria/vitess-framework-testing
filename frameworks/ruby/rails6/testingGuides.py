import os
import sys
import subprocess
import re
import mysql.connector
from mysql.connector import Error

# Rails Guide on Active Records
# https://guides.rubyonrails.org/active_record_migrations.html

# commamd is used to run bash commands and check that they succeeded
def command(cmd):
    sp = subprocess.run(cmd.split(" "))
    if sp.returncode != 0 :
        sys.exit(sp.returncode)

# commamd_with_ouput is used to run bash commands and return their outputs
def command_with_ouput(cmd):
    sp = subprocess.run(cmd.split(" "), capture_output=True, text = True)
    
    if sp.returncode != 0:
        print(sp.stderr)
        sys.exit(sp.returncode)
    return sp.stdout

# rake_migrate runs the db:migrate command from rake
def rake_migrate():
    command("rake db:migrate")

# rails_generate_model  is used to generate a model file with the given name
def rails_generate_model(model_name):
    command("rails generate model "+model_name)

# rails_generate_migration  is used to generate a migration file with the given name and return its name
def rails_generate_migration(migration_name):
    railsOutput = command_with_ouput("rails generate migration "+migration_name)
    
    isPresent = re.search('(db/migrate/.*)',railsOutput)
    if isPresent:
        return isPresent.group(1)
    else:
        sys.exit("Did not find filename in rails output:"+railsOutput)

# rails_command_with_timestamp  is used to run a rails command and return its timestamp
def rails_command_with_timestamp(command):
    railsOutput = command_with_ouput(command)
    
    isPresent = re.search('db/migrate/([0-9]*)',railsOutput)
    if isPresent:
        return isPresent.group(1)
    else:
        sys.exit("Did not find filename in rails output:"+railsOutput)

# revert_to_timestamp reverts the state of database to the given timestamp and it also deletes all the migration files after that timestamp
def revert_to_timestamp(revert_timestamp):
    command("rake db:migrate VERSION="+revert_timestamp)
    ls_output = command_with_ouput("ls db/migrate")
    files = ls_output.split('\n')
    for filename in files:
        timestamp = get_timestamp_from_filename(filename)
        if timestamp == "" or timestamp <= revert_timestamp:
            continue
        command("rm db/migrate/"+filename)

# revert_before_timestamp reverts the state of database to before the given timestamp and it also deletes all the migration files equal to or after that timestamp
def revert_before_timestamp(revert_timestamp):
    command("rake db:migrate VERSION="+revert_timestamp)
    command("rake db:rollback")
    ls_output = command_with_ouput("ls db/migrate")
    files = ls_output.split('\n')
    for filename in files:
        timestamp = get_timestamp_from_filename(filename)
        if timestamp == "" or timestamp < revert_timestamp:
            continue
        command("rm db/migrate/"+filename)

# get_timestamp_from_filename gives the timestamp from the filename
def get_timestamp_from_filename(filename):
    if len(filename) < 14:
        return ""
    return filename[0:14]

# write_to_file writes to a file
def write_to_file(fileName, textToWrite):
    with open(fileName,"w") as f:
        f.write(textToWrite)

# connect_to_mysql is used to connect to mysql
def connect_to_mysql():
    try:
        conn = mysql.connector.connect( host=os.environ['VT_HOST'],
                                        database=os.environ['VT_DATABASE'],
                                        user=os.environ['VT_USERNAME'],
                                        password=os.environ['VT_PASSWORD'],
                                        port=os.environ['VT_PORT'])
        if conn.is_connected():
            return conn
    except Error as e:
        sys.exit(e)

# select_mysql is used to run a select statement in mysql and return its result
def select_mysql(query):
    try:
        conn = connect_to_mysql()
        cursor = conn.cursor()
        cursor.execute(query)
        rows = cursor.fetchall()
    except Error as e:
        sys.exit(e)
    finally:
        cursor.close()
        conn.close()
        return rows

# dml_mysql is used to run a insert, delete or update statement in mysql
def dml_mysql(query):
    try:
        conn = connect_to_mysql()
        cursor = conn.cursor()
        cursor.execute(query)
        conn.commit()
    except Error as e:
        sys.exit(e)
    finally:
        cursor.close()
        conn.close()

# assert_select_output asserts that the output of the given query is exactly the same as the expected output, if not then it exits
def assert_select_ouput(query,expected_output):
    rows = select_mysql(query)
    if rows != expected_output:
        sys.exit("For Query("+query+"), expected output:"+str(expected_output)+" but got:"+str(rows))

# check_create_products_migration checks that the create product migration works correctly
def check_create_products_migration():
    # create the migration file
    filename = rails_generate_migration("CreateProduct1s")
    # update the migration file as in the guide
    write_to_file(filename,"""class CreateProduct1s < ActiveRecord::Migration[6.0]
    def change
        create_table :product1s do |t|
            t.string :name
            t.text :description

            t.timestamps
        end
    end
end""")
    rake_migrate()
    # insert into the table a row
    dml_mysql("insert into product1s(name,description,created_at,updated_at) values ('RGT','Rails Guide Testing Migration Overview',NOW(),NOW())")
    # read from the table and assert that the output matches the expected output
    assert_select_ouput("select id,name,description from product1s",[(1, 'RGT', 'Rails Guide Testing Migration Overview')])

# check_create_products_migration checks that the changing price type migration works correctly
def check_change_product_price_type():
    # Implicit in the guide - creating a price column with integer type
    command("rails generate migration add_price_to_product1 price:integer")
    rake_migrate()
    # update one row and set prices to 100
    dml_mysql("update product1s set price = 100 where id = 1")
    # assert the output, more specifically the price is an integer
    assert_select_ouput("select id,name,description,price from product1s",[(1, 'RGT', 'Rails Guide Testing Migration Overview',100)])
    # Change Product Size
    filename = rails_generate_migration("ChangeProduct1sPrice")
    write_to_file(filename,"""class ChangeProduct1sPrice < ActiveRecord::Migration[6.0]
      def change
        reversible do |dir|
          change_table :product1s do |t|
            dir.up   { t.change :price, :string }
            dir.down { t.change :price, :integer }
          end
        end
      end
    end""")
    rake_migrate()
    # assert that the price is now a string
    assert_select_ouput("select id,name,description,price from product1s",[(1, 'RGT', 'Rails Guide Testing Migration Overview','100')])

# 1. Migration Overview
# https://guides.rubyonrails.org/active_record_migrations.html#migration-overview
check_create_products_migration()
check_change_product_price_type()

# 2. Creating a Migration
# https://guides.rubyonrails.org/active_record_migrations.html#creating-a-migration
# 2.1 Creating a Standalone Migration
# https://guides.rubyonrails.org/active_record_migrations.html#creating-a-standalone-migration
initial_timestamp = rails_command_with_timestamp("rails generate migration CreateProducts name:string description:text")
command("rails generate migration AddPartNumberToProducts part_number:string")
rake_migrate()
command("rails generate migration RemovePartNumberFromProducts part_number:string")
rake_migrate()
# Revert to initial timestamp to add a migration with the same filename as before
revert_to_timestamp(initial_timestamp)
command("rails generate migration AddPartNumberToProducts part_number:string:index")
rake_migrate()
# Revert to initial timestamp to add a column that we have already added
revert_to_timestamp(initial_timestamp)
rake_migrate()
command("rails generate migration AddDetailsToProducts part_number:string price:decimal")
rake_migrate()
# revert before the initial timestamp to remove the products table and create it again
revert_before_timestamp(initial_timestamp)
initial_timestamp = rails_command_with_timestamp("rails generate migration CreateProducts name:string part_number:string")
rake_migrate()
command("rails generate migration AddUserRefToProducts user:references")
rake_migrate()
command("rails generate migration CreateJoinTableCustomerProduct customer product")
rake_migrate()
# 2.2 Model Generators
# https://guides.rubyonrails.org/active_record_migrations.html#model-generators
# Revert the previous creation of migration for product, since it is going to be done now
revert_before_timestamp(initial_timestamp)
command("rails generate model Product name:string description:text")