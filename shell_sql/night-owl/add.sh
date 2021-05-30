#!/bin/bash
#: Title        : add.sh
#: Date         : 2020-12-01
#: Author       : "I D. Know" <idknow@fakemail.net>
#: Version      : 1.0
#: Description  : It that can handle adding a new user 
#                 or a new task to the database using functions.
#
#: Option       : add.sh add-user <user>
#                 add.sh add-todo <user> <todo>
#
#: Usage        : add.sh add-user John
#                 add.sh add-user Paul
#                 add.sh add-todo John Meeting
#                 add.sh add-todo Paul "Make breakfast"
#

P_ERR="-v ON_ERROR_STOP=1"

function zero_row_check_user () {
  num=$(psql -qtA $P_ERR tododb 2> /dev/null << EOF
SELECT COUNT(*) FROM "user" WHERE name = '$1';
EOF
)
  [[ "$num" == 0 ]] && "User doesn't exist: $1" && exit 1
}

function add_user() {
  psql -q $P_ERR tododb 2> /dev/null << EOF
INSERT INTO "user"(name) VALUES('$1');
EOF
  [[ $? == 0 ]]  && echo "User added" || echo "User exists: $1" && exit 1
}

function add_todo() {
zero_row_check_user "$1"
  psql -q $P_ERR tododb 2> /dev/null << EOF
INSERT INTO todo(task, user_id) VALUES('$2', (SELECT id FROM "user" WHERE name = '$1'));
EOF
  [[ $? == 0 ]]  && echo "Todo added"
}

function main() {
  [[ "$1" == "add-user" ]] && add_user "$2"
  [[ "$1" == "add-todo" ]] && add_todo "$2" "$3"
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] &&  main "$@"
