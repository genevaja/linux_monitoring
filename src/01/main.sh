#!/bin/bash

if [[ "$#" < 1 || "$#" > 1 ]]; then
    >&2 echo There must be one argument.
    exit 1
fi

if [[ "$1" =~ ^[+-]?[0-9]*[.,]?[0-9]+$ ]]; then
    echo Wrong parameters. Required string
else
    echo $1
fi
exit 0
