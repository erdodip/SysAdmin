#!/bin/bash
#: Title        : mark.sh
#: Date         : 2020-12-01
#: Author       : "I D. Know" <idknow@fakemail.net>
#: Version      : 1.0
#: Description  : It can handle changing a todo's status using functions.
#
#: Option       : mark.sh mark-todo <todo-id>
#                 mark.sh unmark-todo <todo-id>
#
#: Usage        : mark.sh mark-todo 32
#                 mark.sh unmark-todo 32
#

P_ERR="-v ON_ERROR_STOP=1"

function zero_row_check_todo () {
  num=$(psql -qtA $P_ERR tododb 2> /dev/null << EOF
SELECT COUNT(*) FROM todo WHERE id = '$1';
EOF
)
  [[ "$num" == 0 ]] && echo "Does not exist todo_id: $1" && exit 1
}

function mark_todo() {
  zero_row_check $1
  psql -q $P_ERR tododb 2> /dev/null << EOF
UPDATE todo SET done = true WHERE id='$1';
EOF
  [[ $? == 0 ]]  && echo "Marked as done" || echo "Wrong todo_id: $1" && exit 1
}

function unmark_todo() {
  zero_row_check $1
  psql -q $P_ERR tododb 2> /dev/null << EOF
UPDATE todo SET done = false WHERE id='$1';
EOF
  [[ $? == 0 ]]  && echo "Marked as not done" || echo "Wrong todo_id: $1" && exit 1
}

function main() {

    [[ "$1" == "mark-todo" ]] && mark_todo "$2"
    [[ "$1" == "unmark-todo" ]] && unmark_todo "$2"
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"
