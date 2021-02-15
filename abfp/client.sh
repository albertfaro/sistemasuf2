#!/bin/bash
IP_LOCAL="127.0.0.1"

IP_SERVER="127.0.0.1"
PORT=2021

echo "Cliente de ABFP"

echo "(2) Sending Headers"

echo "ABFP $IP_LOCAL" | nc -q 1 $IP_SERVER $PORT

echo "(3)Listening $PORT"



RESPONSE = `nc -l -p $PORT`

if ["$RESPONSE" != "OK_CONN"]; then
	echo "Server offline"
	exit 1
fi

echo "(6) HANDSHAKE"

sleep 1

echo "THIS_IS_MY_CLASSROOM" | nc -q 1 $IP_SERVER $PORT

echo "(7) Listen:"

RESPONSE= `nc -l -p $PORT`

echo "HANDSHAKE RESPPNSE"

if ["$RESPONSE" != "YES_IT_IS"]; then
	echo "Error"
	exit 2
fi

echo "(10) Sending FILE_NAME"

sleep 1
echo "FILE_NAME $FILE_NAME" | nc -q l $IP_SERVER $PORT

echo "(11) Listening FILE_NAME RESPONSE"
FILE_NAME =`nc -l -p $PORT`

echo "TEST FILE_NAME RESPONSE"

if["$FILE_NAME" != "OK_FILE_NAME""]; then
	echo "ERROR"
	exit 3
fi

echo "(14) SENDING DATA"

sleep 1
echo $FILE_NAME | nc -q l $IP_SERVER $PORT

exit 0
