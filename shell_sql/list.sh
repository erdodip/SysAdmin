#!/bin/bash
#
# list.sh list-users
# list.sh list-todos
# list.sh list-user-todos
#
# Usage:
#    list.sh list-users
#    list.sh list-todos Paul
#    list.sh list-user-todos John
#    list.sh list-user-todos "John Doe"
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
  if [[ "$1" == "list-users" ]]
  then
    list_users
  elif [[ "$1" == "list-todos" ]]
  then
    list_todos
  elif [[ "$1" == "list-user-todos" ]]
  then
    list_user_todos "$2"
  fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  main "$@"
fi