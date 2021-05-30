#!/bin/bash
#: Title        : list.sh
#: Date         : 2020-12-01
#: Author       : "I D. Know" <idknow@fakemail.net>
#: Version      : 1.0
#: Description  : It can handle listing users and their tasks
#                 from the database using functions
#
#: Option       : list.sh list-users
#                 list.sh list-todos
#                 list.sh list-user-todos <user>
#
#: Usage        : list.sh list-users
#                 list.sh list-todos Paul
#                 list.sh list-user-todos John
#                 list.sh list-user-todos "John Doe"
#

function list_users() {
  psql tododb << EOF
SELECT * FROM "user";
EOF
}

function list_todos() {
  psql tododb << EOF
SELECT * FROM todo;
EOF
}

function list_user_todos() {
  psql tododb << EOF
SELECT name, task FROM "user" u
JOIN todo ON u.id = user_id
WHERE name = '$1'
EOF
}

function main() {
  [[ "$1" == "list-users" ]] && list_users
  [[ "$1" == "list-todos" ]] && list_todos
  [[ "$1" == "list-user-todos" ]] && list_user_todos "$2"
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"