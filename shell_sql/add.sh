#!/bin/bash
#
# add.sh add-user <user>
# add.sh add-todo <user> <todo>
#
# Usage:
#    add.sh add-user John
#    add.sh add-user Paul
#    add.sh add-todo John Meeting
#    add.sh add-todo Paul "Make breakfast"
#

error_flag="-v ON_ERROR_STOP=1"

function zero_row_check_user () {
  number_of_rows=$(psql -qtA $error_flag tododb 2> /dev/null << EOF
SELECT COUNT(*) FROM "user" WHERE name = '$1';
EOF
)

  if [[ "$number_of_rows" == 0 ]]
  then
    echo "User doesn't exist: $1"
    exit 1
  fi
}

function add_user() {
  psql -q $error_flag tododb 2> /dev/null << EOF
INSERT INTO "user"(name) VALUES('$1');
EOF

  if [[ $? == 0 ]]
  then
    echo "User added"
  else
    echo "User exists: $1"
    exit 1
  fi
}

function add_todo() {
zero_row_check_user "$1"
# Without subquery
#   user_id=$(psql -qtA $error_flag tododb 2> /dev/null << EOF
# SELECT id FROM "user" WHERE name = '$1';
# EOF
# )

#   psql -q $error_flag tododb 2> /dev/null << EOF
# INSERT INTO todo(task, user_id) VALUES('$2', '$user_id');
# EOF

# With subquery
  psql -q $error_flag tododb 2> /dev/null << EOF
INSERT INTO todo(task, user_id) VALUES('$2', (SELECT id FROM "user" WHERE name = '$1'));
EOF

  if [[ $? == 0 ]]
  then
    echo "Todo added"
  fi
}

function main() {
  if [[ "$1" == "add-user" ]]
  then
    add_user "$2"
  elif [[ "$1" == "add-todo" ]]
  then
    add_todo "$2" "$3"
  fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  main "$@"
fi  