#!/bin/bash

str="hello there'"
echo "${str:6:11}"

str1="/home/users/devendra.singh/" 
echo "${str1%.sh}"
