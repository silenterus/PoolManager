#!/bin/bash

#client-mac
#client-manuf
#channel
#carrier
#max-rate
#last_signal_dbm

dir="/root/msf_stuff"




#clientmac=$(cat "$dir/stats/airodump_stream-01.kismet.netxml" | grep -oP '(?<=<client-mac>).*(?=<\/client-mac>)')

essid=$(cat "$dir/stats/airodump_stream-01.kismet.netxml" | grep -oP '(?<=<essid cloaked=").*(?=<\/essid>)' | sed 's/false">//g')
clientmac=$(cat "$dir/stats/airodump_stream-01.kismet.netxml" | grep -oP '(?<=<client-mac>).*(?=<\/client-mac>)')
clientmanuf=$(cat "$dir/stats/airodump_stream-01.kismet.netxml" | grep -oP '(?<=<client-manuf>).*(?=<\/client-manuf>)')
channel=$(cat "$dir/stats/airodump_stream-01.kismet.netxml" | grep -oP '(?<=<channel>).*(?=<\/channel>)')
carrier=$(cat "$dir/stats/airodump_stream-01.kismet.netxml" | grep -oP '(?<=<carrier>).*(?=<\/carrier>)')
last_signal_dbm=$(cat "$dir/stats/airodump_stream-01.kismet.netxml" | grep -oP '(?<=<last_signal_dbm>).*(?=<\/last_signal_dbm>)')
maxrate=$(cat "$dir/stats/airodump_stream-01.kismet.netxml" | grep -oP '(?<=<max-rate>).*(?=<\/max-rate>)')


SAVEIFS=$IFS
IFS=$'\n'
clientmac=($clientmac)
essid=($essid)
clientmanuf=($clientmanuf)
channel=($channel)
carrier=($carrier)
last_signal_dbm=($last_signal_dbm)
maxrate=($maxrate)
IFS=$SAVEIFS
for (( i=1; i<20; i++ ))
do


    echo
    if  [ "${essid[$i]}" = 'true">' ]
    then
        unset "${essid[$i]}"
    fi

    echo "essid       : ${essid[$i]}      db : ${last_signal_dbm[$i]}"
    echo "manufacture : ${clientmanuf[$i]}"
    echo "bssid       : ${clientmac[$i]}  ch : ${channel[$i]}"
    echo
    echo

done



