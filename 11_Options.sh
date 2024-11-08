#!/bin/bash

#Options

# overlay files (echo "hi" > foo)
set +o noclobber 
echo "hey" > file.txt

# Avoid overlay files (echo "hi" > foo)
#set -o noclobber
#echo "hello" > file1.txt


# if any command in the script fails (produces an error), the script will stop running immediately. 
set -o errexit
echo "start"
mkdir abc/xyz
echo "end"

