#!/bin/bash

path="/root/wordlistFramework"

listpath="/media/root/DUMPER1/genpmk/unzipped"


find "$path/cap/" -name "*.cap*" > capfind

caplist=$(cat capfind)
echo "------------------------------------------------"

### MERGE ALL INTO ONE HCCAP FILE
SAVEIFS=$IFS
IFS=$'\n'
caplist=($caplist)
IFS=$SAVEIFS
#rm -r "$path/temp/caps";
#mkdir "$path/temp/caps";
for (( i=0; i<${#caplist[@]}; i++ ))
do
    hcxpcaptool -o "$path/temp/hccapx/hcx.big.hccapx" ${caplist[$i]}
    wlancap2hcx -D -o "$path/temp/hccapx/dump.big.hccapx" ${caplist[$i]}
    hcxpcaptool -o "$path/temp/hccapx/$i.hcx.hccapx" ${caplist[$i]}
    wlancap2hcx -D -o "$path/temp/hccapx/$i.dump.hccapx" ${caplist[$i]}
    echo "${caplist[$i]}"
done
echo
echo RDY
sleep 10000000
exit

wlan=$(echo "$wlandump" | sed -e "s/ /\\ /g")
dumppath=$(echo "$dumperpath" | sed -e "s/ /\\\ /g")
echo "$dumppath";
wlancap2hcx -D -o $path/hccap/$filename.hccap $path/temp/caps/*.*
rm capfind;
### GET ALL INFO IN MERGED HCCAP
#wlanhcxinfo -i  $dumperpath/rawcap/combined.hccap -S -s -a -e > "$dumperpath/rawcap/combined_info"



#wlanhashhcx -i $dumperpath/rawcap/combined.hccap -S $dumperpath/rawcap/combined_info
wlanhcx2john -o $path/johns/$filename.john $path/hccap/$filename.hccap


### DUMP JOHN LINES INTO SQL DATABASE
johnlines=$(cat "$path/johns/$filename.john")
echo "------------------------------------------------"
count=0;
johncount=0;
newverified=0;
oldverified=0;
SAVEIFS=$IFS
IFS=$'\n'
johnlines=($johnlines)
IFS=$SAVEIFS
for (( i=0; i<${#johnlines[@]}; i++ ))
do
    count=$(($count + 1))
    johnsingle="${johnlines[$i]}";
 
    SAVEIFS=$IFS
    IFS=$':'
    echo "$count"
    johnsingle=($johnsingle)
    IFS=$SAVEIFS
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
            sqlite3 "$path/data/pot.db" "insert into johns(essid,hash,station,bssid_convert,bssid,type,status,source,router_model) values('$essidjohn','${johnsingle[1]}','${johnsingle[2]}','${johnsingle[3]}','${johnsingle[4]}','${johnsingle[6]}','${johnsingle[7]}','${johnsingle[8]}','$vendor')";
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
done

echo "$count JOHNS | $oldverified status changed = VERIFIED"
echo "$johncount NEW JOHNS | $newverified status = VERIFIED"

echo "$hotspot HOTSPOTS --- DELETED"


