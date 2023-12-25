#!/bin/bash

if [[ "$OSTYPE" == "darwin"* ]]; then
    if [[ -t 0 ]]; then
        pbpaste
    else
        pbcopy
    fi
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [[ -t 0 ]]; then
        xclip -selection clipboard -o
    else
        xclip -selection clipboard
    fi
else
    echo "Your OS is not supported for this clipboard command."
    exit 1
fi
