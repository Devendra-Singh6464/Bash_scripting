#!/bin/bash

choose=4

echo "1. Bash scripting"
echo "2. Shell scripting"
echo "3. Scripting"
echo -n "Please choose 1 value 1 to 3: "
read 
echo "You choose $REPLY"

if [ $choose -eq 1 ];then
	echo "You have chose word: Bash"
else
	echo ""
