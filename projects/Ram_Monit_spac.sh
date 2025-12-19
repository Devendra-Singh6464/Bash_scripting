#!/bin/bash

FREE_SPACE=$(free -mt | grep Total | awk '{print $4}')
MINI_RAM=20000

if [[ FREE_SPACE -lt MINI_RAM ]]
	then
		echo "WARNING, RAM is runing low"
	else
		echo "RAM space is sufficient - $FREE_SPACE M"
fi
