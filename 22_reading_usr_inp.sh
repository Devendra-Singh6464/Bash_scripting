#!/bin/bash

echo -e "Hey, who are you: \c"
read word

echo "you are: $word"
echo "Your current and parmanent address: "
read cur par
echo "ok nice state \"$cur\" and \"$par\""
echo "How do you feel about bash scripting: "
# default build-in variable $REPLY
read
if [ $REPLY == "good" ]; then
	echo "OK you said $REPLY, that's nice"
elif [ $REPLY == "exclent" ]; then
	echo "OK you said $REPLY, that's is vary nice"
else
	echo "you said $REPLY, i'm sorry for that"
fi
