#!/bin/bash

function top_five_output {
    $(du $1 --exclude=/proc | sort -rn > du_output.txt) 
    max=$(($(wc -l du_output.txt | awk '{print $1}') - 1))
    if [[ $max -gt 5 ]]; then
        max=5
    fi
    for (( i=1; i <= $max; i++ ))
    do
        size=$(awk 'NR == '$(($i + 1))'{print $1}' du_output.txt)
        path=$(awk 'NR == '$(($i + 1))'{print $2}' du_output.txt)
        kb_mb_gb=" KB"
        if [ "$size" -gt 1000 ];then
            size=$(( $size/1024 ))
            kb_mb_gb=" MB"
            if [ "$size" -gt 1000 ]; then
                size=$(( $size/1024 ))
                kb_mb_gb=" GB"
            fi
        fi
        printf "\t%d - %s, %d %s\n" $i $path $size $kb_mb_gb
    done
    rm -f du_output.txt
}
