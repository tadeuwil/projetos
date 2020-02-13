#!/bin/bash
(echo "open localhost 9211"
sleep 1
echo "status\r"
sleep 1
echo "exit\r") | telnet > output.txt 2>&1
IP=$(grep -R ",$1" output.txt | cut -d',' -f 1)
echo $1" -> IP = "$IP
rm output.txt
