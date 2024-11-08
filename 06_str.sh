#!/bin/bash

var="hello i am devendra singh and my department is networking"
echo "Length of the variable is ${#var}"

echo "change the upper case ${var^^}"
echo "change the lower case ${var,,}"

echo "replace the latter ${var/hello/hey}"

echo "slice the variable ${var:4:15}"
