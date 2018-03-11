#!/bin/bash


path="/root/wordlistFramework"
####DUMP JOHN LINES INTO SQL DATABASE
johnlines=$(cat "/root/wordlistFramework/alljonsOLD.john")
echo "------------------------------------------------"
count=0;
unixtime=$(date +%s) 
johncount=0;
newverified=0;
oldverified=0;
SAVEIFS=$IFS
IFS=$'\n'
johnlines=($johnlines)
IFS=$SAVEIFS
for (( i=5; i<${#johnlines[@]}; i++ ))
do
    count=$(($count + 1))
    johnsingle="${johnlines[$i]}";
    echo "$i/${#johnlines[@]}"
    SAVEIFS=$IFS
    IFS=$':'
    echo "$count"
    johnsingle=($johnsingle)
    IFS=$SAVEIFS
    bssid=$(echo "${johnsingle[3]}" | sed "s/-//g");

   
    netcheck=$(sqlite3 "$path/data/pot.db" "select ssid,lastlat,lastlon,bestlat,bestlon from network where frequency<3000 and capabilities like '%WPA%' and bssid='$bssid' and ssid='${johnsingle[0]}'");

    if [ -n "$netcheck" ]
    then
        echo "FOUN NETWORK IN DB"


        johnid=$(sqlite3 "$path/data/pot.db" "select johns_id from johns where hash='${johnsingle[1]}'");
        if [ ! "$johnid"  ]
        then
                essidjohn=$(echo "${johnsingle[0]}" | sed "s/'/GANSE/g")
                johncount=$(($johncount + 1))
                hit=$(whoismac -m "${johnsingle[4]}");
                SAVEIFS=$IFS
                IFS=$'	'
                hit=($hit)
                IFS=$SAVEIFS
                vendor="${hit[1]}";
                if [ "$vendor" == "HUAWEI TECHNOLOGIES CO.,LTD" ] || [ "$vendor" == "Apple, Inc." ] || [ "$vendor" == "SAMSUNG ELECTRO-MECHANICS(THAILAND)" ] || [ "$vendor" == "SAMSUNG ELECTRO MECHANICS CO., LTD." ] || [ "$vendor" == "Samsung Electronics Co.,Ltd" ]
                then
                        hotspot=$(($hotspot + 1))
                        echo ""
                else
                        sqlite3 "$path/data/pot.db" "insert into johns(essid,hash,station,bssid_convert,bssid,type,status,source,created) values('$essidjohn','${johnsingle[1]}','${johnsingle[2]}','${johnsingle[3]}','${johnsingle[4]}','${johnsingle[6]}','${johnsingle[7]}','${johnsingle[8]}',$unixtime)";
                        if [ "${johnsingle[7]}" == "verfified" ]
                        then
                                newverified=$(($newverified + 1))
                        fi 
                fi

        else
                status=$(sqlite3 "$path/data/pot.db" "select status from johns where hash='${johnsingle[1]}'");
                if [ "$status" == "not verfified" ] || [ "$status" == "forced" ]
                then
                        if [ "${johnsingle[7]}" == "verfified" ]
                        then
                                sqlite3 "$path/data/pot.db" "update johns set status='${johnsingle[7]}' where hash='${johnsingle[1]}'";
                                oldverified=$(($oldverified + 1))
                        fi
                fi
        fi
    fi
done

echo "$count JOHNS | $oldverified status changed = VERIFIED"
echo "$johncount NEW JOHNS | $newverified status = VERIFIED"

echo "$hotspot HOTSPOTS --- DELETED"


