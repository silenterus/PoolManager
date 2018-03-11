#!/bin/bash 


### GET SETTINGS

path="/root/wordlistFramework"

airmonactiv="/media/root/DUMPER1/genpmk/unzipped"
sshpassfile="/root/connect"
scanactiv="/media/root/DUMPER1/genpmk/unzipped"
autoattackactiv="/media/root/DUMPER1/genpmk/unzipped"

waiter=2

echo 1 > /root/onoff
echo "------------------------------------------------"
#echo "" > oftenNetworks

### MERGE ALL INTO ONE HCCAP FILE
SAVEIFS=$IFS
IFS=$'\n'
sqlhits=($sqlhits)
IFS=$SAVEIFS
num=1
for (( i=0; i<$num; i++ ))
do
    onoff=$(cat "/root/onoff")

    if [ "$onoff" = "1" ]
    then
        echo "STARTING"  
        echo 0 > /root/onoff  
    elif [ "$onoff" = "2" ]
    then
        echo "STOPPING"
        echo 0 > /root/onoff      
    elif [ "$onoff" = "3" ]
    then
        echo "DOING SOMETHING"
        echo 0 > /root/onoff      
    fi
    echo "$num";
    num=$(($num + 1));
    sleep $waiter
done


