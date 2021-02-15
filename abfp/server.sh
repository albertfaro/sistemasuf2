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

PREFIX=`echo $FILE_NAME | cut -d " " -f 1`
NAME=`echo $FILE_NAME | cut -d " " -f 2`

echo "TESTING CLIENT FILE"

if [ "$PREFIX" != "FILE_NAME" ]; then
	echo "ERROR in FILE_NAME"
	
	sleep 1
	echo "KO_FILE_NAME" | nc -q l $IP_CLIENT $PORT
	
	exit 3
fi

echo "(12) FILE_NAME($NAME) RESPONSE..."

sleep 1
echo "OK_FILE_NAME" | nc -q l $IP_CLIENT $PORT

echo "(13) LISTENING.."

DATA=`nc -l -p $PORT`

echo "###FILE_MD5=`md5sum input_file.vaca`####"
nc -l -p $PORT > input_file.vaca
echo "###md5sum####"


FILE_NAME=`nc -l -p $PORT`
MD5_NAME2=`echo $FILE_DATA | cut -d " " -f 3`

echo "(16) RESPONSE"
MD5_CHECK=`md5sum $NAME`
if [ "$MD5_CHECH" != "$MD5_NAME2" ]; then
	echo "ERROR"
	sleep 1
	echo "KO_DATA" | nc -q 1 $IP_CLIENTE $PORT
	exit 3
fi
sleep 1
echo "OK_DATA" | nc -q 1 $IP_CLIENTE $PORT


exit 0
