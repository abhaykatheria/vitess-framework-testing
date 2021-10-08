#!/bin/sh -ex
source helper.sh

mysql_run "alter vschema on test.django_migrations add vindex \`binary\`(id) using \`binary\`"
mysql_run "alter vschema on test.django_content_type add vindex \`binary\`(id) using \`binary\`"
mysql_run "alter vschema on test.auth_permission add vindex \`binary\`(id) using \`binary\`"
mysql_run "alter vschema on test.testApp_event add vindex \`binary\`(id) using \`binary\`"
mysql_run "alter vschema on test.testApp_server add vindex \`binary\`(id) using \`binary\`"
mysql_run "alter vschema on test.polls_question add vindex \`binary\`(id) using \`binary\`"
mysql_run "alter vschema on test.polls_choice add vindex \`binary\`(id) using \`binary\`"
mysql_run "alter vschema on test.django_admin_log add vindex \`binary\`(id) using \`binary\`"
mysql_run "alter vschema on test.auth_group add vindex \`binary\`(id) using \`binary\`"
mysql_run "alter vschema on test.auth_user add vindex \`binary\`(id) using \`binary\`"
mysql_run "alter vschema on test.django_session add vindex \`binary\`(id) using \`binary\`"



mysql_run_unsharded "create table django_migrations_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into django_migrations_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.django_migrations_seq;"
mysql_run_unsharded  "alter vschema on test.django_migrations add auto_increment id using unsharded.django_migrations_seq;"

mysql_run_unsharded "create table django_content_type_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into django_content_type_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.django_content_type_seq;"
mysql_run_unsharded  "alter vschema on test.django_content_type add auto_increment id using unsharded.django_content_type_seq;"

mysql_run_unsharded "create table auth_permission_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into auth_permission_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.auth_permission_seq;"
mysql_run_unsharded  "alter vschema on test.auth_permission add auto_increment id using unsharded.auth_permission_seq;"

mysql_run_unsharded "create table testApp_event_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_event_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_event_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_event  add auto_increment id using unsharded.testApp_event_seq;"

mysql_run_unsharded "create table testApp_server_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_server_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_server_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_server add auto_increment id using unsharded.testApp_server_seq;"

mysql_run_unsharded "create table polls_question_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into polls_question_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.polls_question_seq;"
mysql_run_unsharded  "alter vschema on test.polls_question add auto_increment id using unsharded.polls_question_seq;"

mysql_run_unsharded "create table polls_choice_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into polls_choice_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.polls_choice_seq;"
mysql_run_unsharded  "alter vschema on test.polls_choice add auto_increment id using unsharded.polls_choice_seq;"

mysql_run_unsharded "create table django_admin_log_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into django_admin_log_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.django_admin_log_seq;"
mysql_run_unsharded  "alter vschema on test.django_admin_log add auto_increment id using unsharded.django_admin_log_seq;"

mysql_run_unsharded "create table auth_group_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into auth_group_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.auth_group_seq;"
mysql_run_unsharded  "alter vschema on test.auth_group add auto_increment id using unsharded.auth_group_seq;"

mysql_run_unsharded "create table auth_user_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into auth_user_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.auth_user_seq;"
mysql_run_unsharded  "alter vschema on test.auth_user add auto_increment id using unsharded.auth_user_seq;"

mysql_run_unsharded "create table django_session_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into django_session_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.django_session_seq;"
mysql_run_unsharded  "alter vschema on test.django_session add auto_increment id using unsharded.django_session_seq;"

mysql_run "alter vschema on test.testApp_author add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_author_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_author_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_author_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_author add auto_increment id using unsharded.testApp_author_seq;"


mysql_run "alter vschema on test.testApp_chef add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_chef_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_chef_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_chef_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_chef add auto_increment id using unsharded.testApp_chef_seq;"


mysql_run "alter vschema on test.testApp_hqaddress add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_hqaddress_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_hqaddress_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_hqaddress_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_hqaddress add auto_increment id using unsharded.testApp_hqaddress_seq;"


mysql_run "alter vschema on test.testApp_person add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_person_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_person_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_person_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_person add auto_increment id using unsharded.testApp_person_seq;"


mysql_run "alter vschema on test.testApp_place add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_place_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_place_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_place_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_place add auto_increment id using unsharded.testApp_place_seq;"


mysql_run "alter vschema on test.testApp_post add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_post_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_post_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_post_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_post add auto_increment id using unsharded.testApp_post_seq;"


mysql_run "alter vschema on test.testApp_reporter add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_reporter_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_reporter_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_reporter_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_reporter add auto_increment id using unsharded.testApp_reporter_seq;"


mysql_run "alter vschema on test.testApp_review add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_review_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_review_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_review_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_review add auto_increment id using unsharded.testApp_review_seq;"


mysql_run "alter vschema on test.testApp_student add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_student_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_student_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_student_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_student add auto_increment id using unsharded.testApp_student_seq;"


mysql_run "alter vschema on test.testApp_worker add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_worker_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_worker_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_worker_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_worker add auto_increment id using unsharded.testApp_worker_seq;"


mysql_run "alter vschema on test.testApp_productreview add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_productreview_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_productreview_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_productreview_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_productreview add auto_increment id using unsharded.testApp_productreview_seq;"


mysql_run "alter vschema on test.testApp_link add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_link_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_link_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_link_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_link add auto_increment id using unsharded.testApp_link_seq;"


mysql_run "alter vschema on test.testApp_company add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_company_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_company_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_company_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_company add auto_increment id using unsharded.testApp_company_seq;"


mysql_run "alter vschema on test.testApp_comment add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_comment_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_comment_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_comment_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_comment add auto_increment id using unsharded.testApp_comment_seq;"


mysql_run "alter vschema on test.testApp_book add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_book_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_book_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_book_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_book add auto_increment id using unsharded.testApp_book_seq;"


mysql_run "alter vschema on test.testApp_article add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_article_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_article_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_article_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_article add auto_increment id using unsharded.testApp_article_seq;"


mysql_run "alter vschema on test.testApp_myperson add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_myperson_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_myperson_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_myperson_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_myperson add auto_increment id using unsharded.testApp_myperson_seq;"


mysql_run "alter vschema on test.testApp_orderedperson add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_orderedperson_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_orderedperson_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_orderedperson_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_orderedperson add auto_increment id using unsharded.testApp_orderedperson_seq;"


mysql_run "alter vschema on test.testApp_restaurant add vindex \`binary\`(id) using \`binary\`"
mysql_run_unsharded "create table testApp_restaurant_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_restaurant_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_restaurant_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_restaurant add auto_increment id using unsharded.testApp_restaurant_seq;"

mysql_run "alter vschema on test.my_restaurant add vindex \`binary\`(place_ptr_id) using \`binary\`"


mysql_run "alter vschema on test.testApp_book_authors add vindex \`binary\`(author_id) using \`binary\`"
mysql_run_unsharded "create table testApp_book_authors_seq(id bigint, next_id bigint, cache bigint, primary key(id)) comment 'vitess_sequence';"
mysql_run_unsharded "insert into testApp_book_authors_seq(id, next_id, cache) values(0, 1, 3);"
mysql_run_unsharded  "alter vschema add sequence unsharded.testApp_book_authors_seq;"
mysql_run_unsharded  "alter vschema on test.testApp_book_authors add auto_increment id using unsharded.testApp_book_authors_seq;"