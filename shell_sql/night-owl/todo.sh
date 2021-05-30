#!/bin/bash
#: Title        : todo.sh
#: Date         : 2020-12-01
#: Author       : "I D. Know" <idknow@fakemail.net>
#: Version      : 1.0
#: Description  : It that is able to run every function 
#                 from other scripts like add.sh, list.sh, etc.
#
#: Option       : list.sh list-users
#                 list.sh list-todos
#                 list.sh list-user-todos <user>
#                 add.sh add-user <user>
#                 add.sh add-todo <user> <todo>
#                 mark.sh mark-todo <todo-id>
#                 mark.sh unmark-todo <todo-id>
#                 delete.sh delete-todo <todo-id>
#                 delete.sh delete-done
#
#: Usage        : todo.sh add-user Jack
#                 todo.sh list-users
#                 todo.sh add-todo Jack "Driving lesson"
#                 todo.sh list-todos
#

. list.sh
. add.sh
. mark.sh
. delete.sh

[[ "$1" == "list-users" ]] && list_users
[[ "$1" == "list-todos" ]] && list_todos
[[ "$1" == "list-user-todos" ]] && list_user_todos "$2"
[[ "$1" == "add-user" ]] && add_user "$2"
[[ "$1" == "add-todo" ]] && add_todo "$2" "$3"
[[ "$1" == "mark-todo" ]] && mark_todo "$2"
[[ "$1" == "unmark-todo" ]] && unmark_todo "$2"
[[ "$1" == "delete-todo" ]] && delete_todo "$2"
[[ "$1" == "delete-done" ]] && delete_done