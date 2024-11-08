#!/bin/bash

echo "Please enter the directory name: "
read dir

if [ -d $dir ]; then
	echo "Directory exists"
else 
	echo "Directory does not exists"
fi
