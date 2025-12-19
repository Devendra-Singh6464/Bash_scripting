#!/bin/bash

echo "Taking mysql all databases backup using mysql dump"

mysqldump -u root -p --all-databases > mysql_ackup.sql
