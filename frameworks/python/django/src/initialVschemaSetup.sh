#!/bin/sh -ex
source helper.sh

add_sequence_and_vindex "django_migrations"
add_sequence_and_vindex "django_content_type" 
add_sequence_and_vindex "auth_permission"
add_sequence_and_vindex "testApp_event"
add_sequence_and_vindex "testApp_server"
add_sequence_and_vindex "polls_question"
add_sequence_and_vindex "polls_choice"
add_sequence_and_vindex "django_admin_log" 
add_sequence_and_vindex "auth_group"
add_sequence_and_vindex "auth_user"
add_sequence_and_vindex "django_session"
add_sequence_and_vindex "testApp_author"
add_sequence_and_vindex "testApp_chef"
add_sequence_and_vindex "testApp_hqaddress"
add_sequence_and_vindex "testApp_person"
add_sequence_and_vindex "testApp_place"
add_sequence_and_vindex "testApp_post"
add_sequence_and_vindex "testApp_reporter"
add_sequence_and_vindex "testApp_review"
add_sequence_and_vindex "testApp_student"
add_sequence_and_vindex "testApp_worker"
add_sequence_and_vindex "testApp_productreview"
add_sequence_and_vindex "testApp_link"
add_sequence_and_vindex "testApp_company"
add_sequence_and_vindex "testApp_comment"
add_sequence_and_vindex "testApp_book"
add_sequence_and_vindex "testApp_article"
add_sequence_and_vindex "testApp_myperson"
add_sequence_and_vindex "testApp_orderedperson"
add_sequence_and_vindex "testApp_restaurant"

add_binary_vindex "my_restaurant" "place_ptr_id"
add_binary_vindex "testApp_book_authors" "author_id"
add_sequence_table "testApp_book_authors"