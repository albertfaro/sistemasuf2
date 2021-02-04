#!/bin/bash

PORT = 2021

echo "(0) Server ABFP"

echo "(1) Listening $PORT"

HEADER = `nc -l -p $PORT`

echo "ABFP TESTING $HEADER"

PREFIX = `echo $HEADER | cut -d " " -f 1`
IP_CLIENT = `echo $HEADER | cut -d " " -f 2`

echo "(4) RESPONSE"

if ["$PREFIX" != "ABFP"]; then

echo "ERROR IN HEADER!"

sleep 1

echo "KO_CONN" | nc -q 1 $IP_CLIENT $PORT

exit 1

fi

sleep 1
echo "OK_CONN" | nc -q 1 $IP_CLIENT $PORT

echo "(5) LISTEN"

HANDSHAKE = `nc -l -p $PORT`

echo"TESTING HANDSHAKE"

if ["$HANDSHAKE" != "THIS_IS_MY_CLASSROOM"]; then

	echo "ERROR: HANDSHAKE"
	sleep 1 
	echo "KO_HANDSHAKE" | nc -q 1 $IP_CLIENT $PORT
fi

echo "(8) Response:"
sleep 1
echo "YES_IT_IS" | nc -q 1 $IP_CLIENT $PORT

echo "(9) LISTEN"
FILE_NAME = `nc -l -p $PORT`

exit 0
