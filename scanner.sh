#!/bin/bash 


card=$1

path="/root/wordlistFramework"



lat=$2
unixtime=$(date +%s) 
lon=$3


iwlist $card scan > /root/scan.temp

sqlhits=$(cat /root/scan.temp | sed "s/Cell /µ/g"  | sed 's/)/"/g' ) 
SAVEIFS=$IFS
IFS=$'µ'
sqlhits=($sqlhits)
IFS=$SAVEIFS
num=1
for (( i=0; i<${#sqlhits[@]}; i++ ))
do
    echo ""
    echo $i
    cell="${sqlhits[$i]}"
    type="W"
    essid=$(echo "$cell" | grep -oP '(?<=ESSID:").*(?=")')
    channel=$(echo "$cell" | grep -oP '(?<=Channel ).*(?=")')
    bssid=$(echo "$cell"  | sed "s/ //g" | sed "s/://g" | sed ':a;N;$!ba;s/\n/@/g' | grep -oP '(?<=Address).*(?=@Channel)' | tr '[:upper:]' '[:lower:]')
    frequncy=$(echo "$cell" | grep -oP '(?<=Frequency:).*(?= GHz)')
    signal=$(echo "$cell" | grep -oP '(?<=Signal level=).*(?= dBm)')
    encrypt=$(echo "$cell" | grep -oP '(?<=IEEE 802).*(?= )' | sed "s/\.11i\///g" | sed "s/ Version//g")

    checker=$(sqlite3 "$path/data/network.db" "select bestlevel from network where bssid='$bssid'")
    echo "-------------"
    echo $checker
    echo "----------"
    if [ -n "$checker" ]
    then
        if [ $signal -lt $checker ]
        then
            echo "BETTER SIGNAL"
            sqlite3 "$path/data/network.db" "update network set bestlevel=$signal, bestlat=$lat, bestlon=$lon, lastlat=$lat, lastlon=$lon, lasttime=$unixtime where bssid='$bssid'"
        else
            echo "WIFI ALREAD IN DATABASE"
            sqlite3 "$path/data/network.db" "update network set lastlat=$lat, lastlon=$lon, lasttime=$unixtime where bssid='$bssid'"
        fi
        checker=$(sqlite3 "$path/data/network.db" "select bestlevel from network where bssid='$bssid'")
    else 
        sqlite3 "$path/data/network.db" "insert into network(bssid,ssid,frequency,capabilities,lasttime,lastlat,lastlon,type,bestlevel,bestlat,bestlon,channel) values('$bssid','$essid',$frequncy,'$encrypt',$unixtime,$lat,$lon,'$type',$signal,$lat,$lon,$channel)"
        echo "NEW WIFI"
    fi
    echo "$essid"
  #  echo "$bssid"
   # echo "$frequncy"
    #echo "$signal"
    #echo "$encrypt"
    #echo "$channel"
    #echo "$essid"
done


