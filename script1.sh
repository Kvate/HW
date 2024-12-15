#!/bin/bash

echo "Enter -u or -l"
read reg
echo "Enter your word"
read word

if [ "$reg" = "-u" ]; then
    echo "${word^^}"
elif [ "$reg" = "-l" ]; then
    echo "${word,,}"
else
    echo "Invalid argument!"
    exit 1
fi

