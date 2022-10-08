#!/bin/bash

. ./top_five_output.sh
. ./top_ten_output.sh
. ./top_ten_exe_output.sh

function print_output {
    echo "* Total number of folders (including all nested ones) = $(find $1 -type d -not \
        -path "/proc/*" -not -path "$1" | wc -l)"
    echo "* TOP 5 folders of maximum size arranged in descending order \
(path and size):"
    top_five_output $1
    echo "* Total number of files = $(find $1 -type f -not -path "/proc/*" -not -path "$1" \
| wc -l)"
    echo "* Number of:"
    echo -e "\tConfiguration files (with the .conf extension) = $(find $1 -type f \
        -not -path "/proc/*" -not -path "$1" -name "*.conf" | wc -l)"
    echo -e "\tText files = $(find $1 -type f \
        -not -path "/proc/*" -not -path "$1" -name "*.txt" | wc -l)"
    # Думаю, тут надо пользоваться флагом -executable
    echo -e "\tExecutable files = $(find $1 -type f -executable \
        -not -path "/proc/*" -not -path "$1" | wc -l)"
    echo -e "\tLog files (with the extension .log) = $(find $1 -type f \
        -not -path "/proc/*" -not -path "$1" -name "*.log" | wc -l)"
    echo -e "\tArchive files = $(find $1 -type f \
        -not -path "/proc/*" -not -path "$1" -name "*.tar" -o -name "*.zip" -o -name \
        "*.tar.gz" | wc -l)"
    echo -e "\tSymbolic links = $(find $1 -type l \
        -not -path "/proc/*" -not -path "$1" | wc -l)"
    echo "* TOP 10 files of maximum size arranged in descending \
 order (path, size and type):"
    top_ten_output $1
    echo "* TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)"
    top_ten_exe_output $1
}
