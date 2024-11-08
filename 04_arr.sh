#!/bin/bash
# when working with array always user [@] to refer to all elements. 
#array

arr=( 4 6 4.6 "hey bro" hello 5 )

#all values----
echo "value is ${arr[*]}"

#single values-------
#echo "value is ${arr[3]}"

#all values
echo "value is ${#arr[*]}"

#find no of values in array
echo "value is ${arr[*]:2}"
echo "value is ${arr[*]:1:3}"

#updating the array with new value
arr+=( 23 46 16 hi )
echo "after updated array is ${arr[*]}"

#extract form index 3 to the end
echo "${arr:3}"

#print a range 
echo "${arr[@]:1:3}"

