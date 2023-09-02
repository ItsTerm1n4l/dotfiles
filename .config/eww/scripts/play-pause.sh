#!/bin/bash
while true
do
if [ "$(playerctl --player=mpv,%any status)" == "Playing" ]
then
echo -e "󰏦" #
else
echo "󰐍" # 
fi
done
