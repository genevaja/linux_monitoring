#!/bin/bash

. ./check_arg.sh
. ./print_output.sh

time=$(date +%s%N)
zero=""

# Check arg
check_arg $1
check_result=$?
if [[ $check_result -eq 1 ]]; then
    >&2 echo The argument must end with \"/\"
    exit 1
fi

if [[ ! -d $1 ]]; then
    >&2 echo Path doesn\'t exist
    exit 1
fi

print_output $1
exec_time=$(date +%s%N)
diff=$(( $exec_time - $time ))
diff=$(bc<<<"scale=3;$diff/1000000000")
if [[ $(( ($exec_time - $time)/1000000000)) -lt 1 ]]; then
    zero="0"
fi
printf "* Script execution time (in seconds) = %s%s\n" $zero $diff
exit 0
