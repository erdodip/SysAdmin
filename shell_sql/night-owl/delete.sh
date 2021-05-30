#!/bin/bash
#: Title        : delete.sh
#: Date         : 2020-12-01
#: Author       : "I D. Know" <idknow@fakemail.net>
#: Version      : 1.0
#: Description  : It can handle removing todos from the database.
#
#: Option       : delete.sh delete-todo <todo-id>
#                 delete.sh delete-done
#
#: Usage        : delete.sh delete-todo 99
#                 delete.sh delete-done
#

P_ERR="-v ON_ERROR_STOP=1"

function zero_row_check_todo () {
  num=$(psql -qtA $P_ERR tododb 2> /dev/null << EOF
SELECT COUNT(*) FROM todo WHERE id = '$1';
EOF
)
  [[ "$num" == 0 ]] && echo "Does not exist todo_id: $1" && exit 1
}

function delete_todo() {
  zero_row_check_todo $1
  psql -q $P_ERR tododb 2> /dev/null << EOF
DELETE FROM todo WHERE id='$1';
EOF
  [[ $? == 0 ]]  && echo "Todo removed" || echo "Wrong todo_id: $1" && exit 1
}

function delete_done() {
  psql -q $P_ERR tododb 2> /dev/null << EOF
DELETE FROM todo WHERE done = true;
EOF
  [[ $? == 0 ]]  && echo "Done todos removed"
}

function main() {
  [[ "$1" == "delete-todo" ]] && delete_todo "$2"
  [[ "$1" == "delete-done" ]] && delete_done
}

[[ "${BASH_SOURCE[0]}" == "$0" ]] && main "$@"
