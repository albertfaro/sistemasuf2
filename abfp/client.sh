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

exit 0
