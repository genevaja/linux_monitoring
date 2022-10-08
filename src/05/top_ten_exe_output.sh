#!/bin/bash

function top_ten_exe_output {
    $(find $1 -type f -executable -printf '%s %p\n' | sort -rn > top_ten_exe_output.txt)
    max=$(wc -l top_ten_exe_output.txt | awk '{print $1}')
    if [[ $max -gt 10 ]]; then
        max=10
    fi
    for (( i=1; i <= $max; i++ ))
    do
        size=$(awk 'NR == '$i'{print $1}' top_ten_exe_output.txt)
        path=$(awk 'NR == '$i'{print $2}' top_ten_exe_output.txt)
        # if [ ! -e "$path" ]; then
        #     break
        # fi
        kb_mb_gb=" B"
        if [[ "$size" -gt 1000 ]]; then
            size=$(( $size/1024 ))
            kb_mb_gb=" KB"
            if [ "$size" -gt 1000 ]; then
                size=$(( $size/1024 ))
                kb_mb_gb=" MB"
                if [ "$size" -gt 1000 ]; then
                    size=$(( $size/1024 ))
                    kb_mb_gb=" GB"
                fi
            fi
        fi
        md5sum_res=$(md5sum $path | awk '{print $1}')
        printf "\t%d - %s, %d %s %s\n" $i $path $size $kb_mb_gb $md5sum_res
    done
    rm -f top_ten_exe_output.txt 
}
