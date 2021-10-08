#!/bin/sh

# mysql_run is used to run a query in mysql and return its result
function mysql_run(){
  # $1 Query to execute
  query_output=$(mysql --host "${VT_HOST}" --port "${VT_PORT}" --user "${VT_USERNAME}" "-p${VT_PASSWORD}" "${VT_DATABASE}" -rsNe "$1")
  echo $query_output
}

# Add sequence table
function add_sequence_table(){
  # $1 is the name of the table
 
    mysql_run "create table unsharded.\`${1}_seq\`(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence'"
    mysql_run "insert into unsharded.\`${1}_seq\`(id, next_id, cache) values(0, 1, 3)"
    mysql_run "alter vschema add sequence unsharded.\`${1}_seq\`"
    mysql_run "alter vschema on test.\`${1}\` add auto_increment id using unsharded.\`${1}_seq\`"
 
}

# Running for basic vindex and sequence addition
function add_sequence_and_vindex(){
  
    add_binary_vindex "$1" "id"
    add_sequence_table "$1"
  }


# Adds a binary vindex for a given table
function add_binary_vindex(){
  # $1 is the name of the table
  # $2 is the name of the column to use
  
    mysql_run "alter vschema on test.\`${1}\` add vindex \`binary\`(${2}) using \`binary\`;"
  
}