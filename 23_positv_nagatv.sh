#!/bin/bash

echo "Please enter the number: "
read num

if [ $num -gt 0 ]; then
	echo "$num is positive number"
elif [ $num -lt 0 ]; then 
	echo "$num is negative number"
else
echo "$num is zero"
fi
