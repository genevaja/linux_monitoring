#!/bin/bash

function top_ten_output {
    $(find $1 -path /proc -prune -o -type f -printf '%s %p\n' | sort -rn > top_ten_output.txt)
    max=$(wc -l top_ten_output.txt | awk '{print $1}')
    if [[ $max -gt 10 ]]; then
        max=10
    fi
    for (( i=1; i <= $max; i++ ))
    do
        size=$(awk 'NR == '$i'{print $1}' top_ten_output.txt)
        path=$(awk 'NR == '$i'{print $2}' top_ten_output.txt)
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
        if [ -x "$path" ];then
            file_type="executable"
        elif [[ "$(find $path -type l | wc -l)" -eq 1 ]]; then
            file_type="link"
        elif [[ "$(find $path | grep -E '[.]+(txt|doc|pdf|bash_history|bash_logout)$' | wc -l)" -eq 1 ]]; then
            file_type="text"
        elif [[ "$(find $path | grep -E '[.]+(log)$' | wc -l)" -eq 1 ]]; then
            file_type="log"
        elif [[ "$(find $path | grep -E '[.]+(conf|viminfo|bashrc|profile)$' | wc -l)" -eq 1 ]]; then
            file_type="configuration"
        elif [[ "$(find $path | grep -E '[.]+(tar|gz|zip|rar|deb)$' | wc -l)" -eq 1 ]]; then
            file_type="archive"
        elif [[ "$(find $path | grep -E '[.]+(mp3|aac|wav|flac)$' | wc -l)" -eq 1 ]]; then
            file_type="audio"
        elif [[ "$(find $path | grep -E '[.]+(mkv|avi|mp4)$' | wc -l)" -eq 1 ]]; then
            file_type="video"
        fi
        printf "\t%d - %s, %d %s, %s\n" $i $path $size $kb_mb_gb $file_type
    done
    rm -f top_ten_output.txt 
}
