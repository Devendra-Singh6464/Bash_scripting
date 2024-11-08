#!/bin/bash

server_name=$(hostname)
echo $server_name

function memory_check(){
	echo "my system $server_name have free memory"
	free -h
}

function cpu_time(){
	echo "Your CPU load on  $server_name  is: "
        uptime
}

function kernel_check(){
	echo "Your Kernel version on $server_name is: "
	uname -r
}

function allfunc(){
	memory_check
	cpu_time
	kernel_check
}
allfunc
