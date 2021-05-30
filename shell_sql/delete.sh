#!/bin/bash
#
# delete.sh delete-todo <todo-id>
# delete.sh delete-done
#
# Usage:
#    delete.sh delete-todo 99
#    delete.sh delete-done
#

error_flag="-v ON_ERROR_STOP=1"

function zero_row_check_todo() {
  number_of_rows=$(psql -qtA $error_flag tododb 2> /dev/null << EOF
SELECT COUNT(*) FROM todo WHERE id = '$1';
EOF
)

  if [[ "$number_of_rows" == 0 ]]
  then
    echo "Does not exist todo_id: $1"
    exit 1
  fi
}

function delete_todo() {
  zero_row_check_todo $1

  psql -q $error_flag tododb 2> /dev/null << EOF
DELETE FROM todo WHERE id='$1';
EOF

  if [[ $? == 0 ]]
  then
    echo "Todo removed"
  else
    echo "Wrong todo_id: $1"
    exit 1
  fi
}

function delete_done() {
  psql -q $error_flag tododb 2> /dev/null << EOF
DELETE FROM todo WHERE done = true;
EOF

  if [[ $? == 0 ]]
  then
    echo "Done todos removed"
  fi
}

function main() {
  if [[ "$1" == "delete-todo" ]]
  then
    delete_todo "$2"
  elif [[ "$1" == "delete-done" ]]
  then
    delete_done
  fi
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]
then
  main "$@"
fi