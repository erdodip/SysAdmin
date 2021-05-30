#!/bin/bash
# Colors
none="\e[0m"
red="\e[31m"
green="\e[32m"
lgreen="\e[92m"
yellow="\e[33m"
lyellow="\e[93m"
blue="\e[34m"
magenta="\e[35m"
cyan="\e[36m"
invert="\e[7m"
uline="\e[4m"

# Extract data
user_num=$(w -h | tr -s " " | cut -d" " -f1 | wc -l)
user_name=$(users)
(( user_num > 1 )) && user_name=$(echo $user_name | sed "s/ /, /g") # Nicer looking if more than 1 user
my_login_tty=$(tty)
my_public_ip=$(dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | sed 's/"//g')

# Add text
welcome="Hello $uline$USER$none, your logged in $uline$HOSTNAME$none at $( date )"
user_num="User(s) on server ($user_num): $user_name"
my_login_tty="Terminal ($TERM): $my_login_tty"
my_public_ip="Public IP: $my_public_ip"

# Display on dashboard
user_out="$welcome\n\n$user_num\n$my_login_tty\n$my_login_time\n$my_public_ip\n"