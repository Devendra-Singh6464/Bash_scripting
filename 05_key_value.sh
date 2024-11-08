#!/bin/bash

declare -A arr

arr=( [name]=dev [dpart]=networking )

echo "my name is ${arr[name]} and my age is ${arr[dpart]}."
