#!/bin/bash

function getting_presets2 {
    # Check existence of main.conf
    if [ ! -f main.conf ]; then
        default_color
        return
    fi

    # Check parameters string by string

    # Getting presets from file
    ab_setting=$(grep column1_background main.conf | awk -F= '{print $2}')
    af_setting=$(grep column1_font_color main.conf | awk -F= '{print $2}')
    vb_setting=$(grep column2_background main.conf | awk -F= '{print $2}')
    vf_setting=$(grep column2_font_color main.conf | awk -F= '{print $2}')



    # CHECK PARAMETERS FOR COLUMN 1
    # Check font
    if [[ $af_setting -lt 1 || $af_setting -gt 6 || $af_setting -eq $ab_setting ]]; then
        AF_SET=${font_colors[0]}
        column_1_font="Column 1 font color = default (white)"
    else
        AF_SET=${font_colors[${af_setting} - 1]}  # Set alias font color from file
        column_1_font="Column 1 font color = $af_setting ${color_names[$af_setting - 1]}"
    fi

    # Check background
    if [[ $ab_setting -lt 1 || $ab_setting -gt 6 || $af_setting -eq $ab_setting ]]; then
        AB_SET=${bground_colors[5]}
        column_1_bground="Column 1 background = default (black)"
    else
        AB_SET=${bground_colors[${ab_setting} - 1]}  # Set alias font color from file
        column_1_bground="Column 1 background = $ab_setting ${color_names[$ab_setting - 1]}"
    fi
    A_SET="${AF_SET}${AB_SET}"



    # CHECK PARAMETERS FOR COLUMN 2
    # Check font
    if [[ $vf_setting -lt 1 || $vf_setting -gt 6 || $vf_setting -eq $vb_setting ]]; then
        VF_SET=${font_colors[0]}
        column_2_font="Column 2 font color = default (white)"
    else
        VF_SET=${font_colors[${vf_setting} - 1]}  # Set alias font color from file
        column_2_font="Column 2 font color = $vf_setting ${color_names[$vf_setting - 1]}"
    fi

    # Check background
    if [[ $vb_setting -lt 1 || $vb_setting -gt 6 || $vf_setting -eq $vb_setting ]]; then
        VB_SET=${bground_colors[5]}
        column_2_bground="Column 2 background = default (black)"
    else
        VB_SET=${bground_colors[${vb_setting} - 1]}  # Set alias font color from file
        column_2_bground="Column 2 background = $vb_setting ${color_names[$vb_setting - 1]}"
    fi
    V_SET="${VF_SET}${VB_SET}"
}
