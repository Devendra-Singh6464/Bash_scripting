#!/bin/bash

while read line 
do 
	echo $line
done < file.txt

echo "More text." >> file.txt

