#!/bin/bash

# Check arg. Must be / in end of line
function check_arg {
if [[ "$1" =~ .*[/]$ ]]; then
    return 0
else
    return 1
fi
}
