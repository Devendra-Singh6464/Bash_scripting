#!/bin/bash

#Defining
declare -A sounds

sounds[dog]="dark"
sounds[cow]="moo"
sounds[bird]="tweet"
sounds[wolf]="howl"

#Working with dictionaries
echo "This is dog sound ${sounds[dog]}"
echo "This is all values ${sounds[@]}"
echo "This is all key ${!sounds[@]}"
echo "This is all number of elements ${#sounds[@]}"
unset sound0[dog]
echo "This is dog sound ${sounds[dog]}"

#iteration
for val in "${sounds[@]}"; do
	echo "$val"
done

for key in "${!sounds[@]}"; do
        echo "$key"
done

