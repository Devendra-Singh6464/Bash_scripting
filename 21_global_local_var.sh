#!/bin/bash

gvar="global var"

function my_func {
	lvar="local variable"
	echo $lvar
#	echo $gvar
}

#echo $lvar
my_func

echo $gvar
