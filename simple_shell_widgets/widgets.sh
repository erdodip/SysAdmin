#!/bin/bash
. ./mem.sh
. ./proc.sh
. ./user.sh
. ./disk.sh
. ./cpu.sh

# Add WIDGET_CONTROL=cpu,disk,mem,proc,user to .bashrc for default setting
# Set default values if WIDGET_CONTROL is empty
WIDGET_CONTROL=${WIDGET_CONTROL:-mem,proc}

# Dashboard
echo -e $green
printf "
$cyan              :: ::::: ::
$blue              :: ::::: ::
$blue              :: ::::: ::
$magenta              :: ::::: ::
$magenta              :: ::::: ::
$red             .:: ::::: ::.
$red            .::: ::::: :::.
$yellow           .:::' ::::: ':::.
$yellow          .::::' ::::: '::::.
$lyellow         .::::'  :::::  '::::.
$lgreen       .:::::'   :::::   ':::::.
$lgreen     .::::::'    :::::    '::::::.
$green...:::::::'      :::::      ':::::::...
$green:::::::''        :::::        '':::::::
$green::::''           :::::           ''::::
"
echo -e $none
[ $(echo $WIDGET_CONTROL | grep -w "user") ] && echo -e $user_out
[ $(echo $WIDGET_CONTROL | grep -w "proc") ] && echo -e $proc_out
[ $(echo $WIDGET_CONTROL | grep -w "disk") ] && echo -e $disk_out
[ $(echo $WIDGET_CONTROL | grep -w "cpu") ] && echo -e $cpu_out
[ $(echo $WIDGET_CONTROL | grep -w "mem") ] && echo -e $mem_out