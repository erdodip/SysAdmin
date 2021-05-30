#!/bin/bash
#
# mark.sh mark-todo <todo-id>
# mark.sh unmark-todo <todo-id>
#
# Usage:
#    mark.sh mark-todo 32
#    mark.sh unmark-todo 32
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

function mark_todo() {
  zero_row_check_todo $1

  psql -q $error_flag tododb 2> /dev/null << EOF
UPDATE todo SET done = true WHERE id='$1';
EOF

  if (( $? == 0 ))
  then
    echo "Marked as done"
  else
    echo "Wrong todo_id: $1"
    exit 1
  fi
}

function unmark_todo() {
  zero_row_check_todo $1

  psql -q $error_flag tododb 2> /dev/null << EOF
UPDATE todo SET done = false WHERE id='$1';
EOF

  if (( $? == 0 ))
  then
    echo "Marked as not done"
  else
    echo "Wrong todo_id: $1"
    exit 1
  fi
}

function main() {
  if [[ "$1" == "mark-todo" ]]
  then
    mark_todo "$2"
  elif [[ "$1" == "unmark-todo" ]]
  then
    unmark_todo "$2"
  fi
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  main "$@"
fi