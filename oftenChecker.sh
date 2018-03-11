#!/bin/bash 


### GET SETTINGS

path="/root/wordlistFramework"

listpath="/media/root/DUMPER1/genpmk/unzipped"


verified="1"
row="2"
mode="1"
johncount=0
start=4
charsets_id="$1"
wordlists_id="$1"

echo "$charset"


sqlhits=$(sqlite3 "$path/data/pot.db" "select distinct essid from pots")
echo "------------------------------------------------"
#echo "" > oftenNetworks

### MERGE ALL INTO ONE HCCAP FILE
SAVEIFS=$IFS
IFS=$'\n'
sqlhits=($sqlhits)
IFS=$SAVEIFS

for (( i=0; i<${#sqlhits[@]}; i++ ))
do

    num=$(sqlite3 "$path/data/pot.db" "select rowid from pots where essid='${sqlhits[$i]}'" | wc -l );
    #echo "$num";
    #echo "${sqlhits[$i]}"
    #echo "$num"
    if [ $num -gt $start ]
    then
        sqlite3 "/root/wordlistFramework/data/pot.db" "update pots set status=2 where essid='${sqlhits[$i]}'"
        checker=$(sqlite3 "/root/wordlistFramework/data/pot.db" "select rainbows_id from rainbows where essid='${sqlhits[$i]}'")
        if [ ! "$checker" ]
        then        
            sqlite3 "/root/wordlistFramework/data/pot.db" "insert into rainbows(essid) values('${sqlhits[$i]}')"
            echo "NOT IN RAINBOW"
            echo "${sqlhits[$i]}" 
        else
            echo "${sqlhits[$i]}"
            echo "ALREADY RAINBOW"
        fi
    fi
done


