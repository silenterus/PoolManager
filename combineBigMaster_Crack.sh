#!/bin/bash 


### GET SETTINGS

path="/root/wordlistFramework"

listpath="/media/root/DUMPER1/genpmk/unzipped"

nonce=64
search="0"
searchtype="0"
verified="2"
row="2"
mode="3"
count=0
allcount=0
start=0
lists_id="1508"
echo "$charset"
query="null"
if [ -d "$path/temp/johns" ]
then
    rm -r "$path/temp/johns" 
fi
if [ -d "$path/temp/hccapx" ]
then
    rm -r "$path/temp/hccapx" 
fi

mkdir "$path/temp/hccapx"
mkdir "$path/temp/johns"

if [ "$searchtype" = "0" ]
then
    sqlhits=$(sqlite3 "$path/data/pot.db" "select bssid,pots_id,essid from pots where status=0 and rowid>0" | sed "s/://g")
elif [ "$searchtype" = "1" ]
then
    sqlhits=$(sqlite3 "$path/data/pot.db" "select bssid,pots_id,essid from pots where status=2 and rowid>0" | sed "s/://g")
elif [ "$searchtype" = "2" ]
then
    sqlhits=$(sqlite3 "$path/data/pot.db" "select bssid,pots_id,essid from pots where status=0 and essid like '%$search%'" | sed "s/://g")
elif [ "$searchtype" = "3" ] # name
then
    sqlhits=$(sqlite3 "$path/data/pot.db" "select bssid,pots_id,essid from pots where status=0 and essid like '%$search%'" | sed "s/://g")
elif [ "$searchtype" = "4" ] # gps
then
    sqlhits=$(sqlite3 "$path/data/pot.db" "select bssid,pots_id,essid from pots where status=0 and coords_best_lon>$lonrange and coords_best_lon<-$lonrange and coords_best_lon>$latrange and coords_best_lon<-$latrange" | sed "s/://g")
elif [ "$searchtype" = "5" ] # strassen
then
    sqlhits=$(sqlite3 "$path/data/pot.db" "select bssid,pots_id,essid from pots where status=0 and address_best like '%$search%'" | sed "s/://g")
fi


echo "------------------------------------------------"

if [ "$mode" = "1" ]
then
    name=$(sqlite3 "$path/data/pot.db" "select name from wordlists where wordlists_id=$lists_id")
    #echo "name $name"
    hashcat=$(find "$listpath" -name "$name")
elif [ "$mode" = "2" ]
then
    check=$(sqlite3 "$path/data/pot.db" "select johns_charsets_pots_id from johns_charsets_pots where johns_id=${johnsingle[$j]} and charsets_id=$lists_id")
fi
name=$(sqlite3 "$path/data/pot.db" "select name from wordlists where wordlists_id=$lists_id")
hashcat=$(find "$listpath" -name "$name")
### MERGE ALL INTO ONE HCCAP FILE
SAVEIFS=$IFS
IFS=$'\n'
sqlhits=($sqlhits)
IFS=$SAVEIFS
echo "FOUND ${#sqlhits[@]} POSSIBLE WIFIS"
for (( i=0; i<${#sqlhits[@]}; i++ ))
do


    potsingle="${sqlhits[$i]}";
 
    SAVEIFS=$IFS
    IFS=$'|'
    potsingle=($potsingle)
    IFS=$SAVEIFS
    bssid="${potsingle[0]}";
    potid="${potsingle[1]}";
    essid="${potsingle[2]}";
    if [ "$verified" = "0" ]
    then
        johnid=$(sqlite3 "$path/data/pot.db" "select johns_id from johns where bssid='$bssid' and status='not verfified'")
    elif [ "$verified" = "1" ]
    then
        johnid=$(sqlite3 "$path/data/pot.db" "select johns_id from johns where bssid='$bssid' and status='verfified' order by johns_id asc limit 1 offset 0")
    elif [ "$verified" = "2" ]
    then
        johnid=$(sqlite3 "$path/data/pot.db" "select johns_id from johns where bssid='$bssid'")
    fi
    
 


    if [ "$mode" = "1" ] && [ -n "$johnid" ]
    then
        check=$(sqlite3 "$path/data/pot.db" "select johns_wordlists_pots_id from johns_wordlists_pots where johns_id=$johnid and wordlists_id=$lists_id")
            #echo "name $name"

    elif [ "$mode" = "2" ] && [ -n "$johnid" ]
    then
        check=$(sqlite3 "$path/data/pot.db" "select johns_charsets_pots_id from johns_charsets_pots where johns_id=$johnid and charsets_id=$lists_id")
    elif [ "$mode" = "3" ] && [ -n "$johnid" ]
    then
        check=$(sqlite3 "$path/data/pot.db" "select johns_wordlists_pots_id from johns_wordlists_pots where pots_id=$potid and wordlists_id=$lists_id")
      
    fi
    if [ ! "$check" ] && [ -n "$johnid" ]
    then
        
        potid=$(sqlite3 "$path/data/pot.db" "select johns_wordlists_pots_id from johns_wordlists_pots where johns_id=$johnid and wordlists_id=$lists_id")
        count=$(($count + 1))
        allcount=$(($allcount + 1))
        sqlite3 "$path/data/pot.db" "select essid,hash,station,bssid_convert,bssid,blank,type,status,source from johns where johns_id=$johnid" | sed "s/|/:/g" >> "$path/temp/johns/$lists_id.john"; 
    fi

    #query="johns_id=$query"

    echo
    echo "-----"
    echo "---------------"
    echo "[$i]"
    echo "[ $essid ]" 
    echo
    echo "---------------"
    echo "---------------"
    echo "ALL [$allcount]" 
    echo "FOUND NEW [$count]" 
    echo "WORDLIST : $name [$lists_id]"
    echo ""



    #echo "$query"
    #sleep 10000

done



wlanjohn2hcx -o "$path/temp/hccapx/word.$lists_id.hccapx" "$path/temp/johns/$lists_id.john"
/root/hashcat/./hashcat -m 2500 --nonce-error-correction $nonce -w 4 -d 1,2 "$path/temp/hccapx/word.$lists_id.hccapx" /media/root/DUMPER1/genpmk/unzipped/MasterCombo/MasterCombo

if [ "$mode" = "1" ]
then
    echo 
    
elif [ "$mode" = "2" ]
then
    echo 
    #/root/hashcat/./hashcat -m 2500 --nonce-error-correction $nonce -w 4 -d 1,2 "$path/temp/hccapx/word.$lists_id.hccapx" -a 3 /media/root/DUMPER1/genpmk/unzipped/MasterCombo/MasterCombo
elif [ "$mode" = "3" ]
then
    echo 
    #/root/hashcat/./hashcat -m 2500 --nonce-error-correction $nonce -w 4 -d 1,2 "$path/temp/hccapx/word.$lists_id.hccapx" -a 3 /media/root/DUMPER1/genpmk/unzipped/MasterCombo/MasterCombo
fi
johns="$alljohns"
echo "------------------------------------------------"
#echo "$johns"
SAVEIFS=$IFS
IFS=$'@'
johns=($johns)
IFS=$SAVEIFS
for (( u=0; u<${#johns[@]}; u++ ))
do
    if [ -n "${johns[$u]}" ]
    then
        johnid="${johns[$u]}";
        bssid=$(sqlite3 "$path/data/pot.db" "select bssid_convert from johns where johns_id=$johnid" | sed "s/-//g")   
        potid=$(sqlite3 "$path/data/pot.db" "select pots_id from pots where bssid='$bssid'")
        if [ ! "$potid" ]
        then
            potid=0
        fi
        if [ "$mode" = "1" ]
        then
            sqlite3 "$path/data/pot.db" "insert into johns_wordlists_pots(johns_id,wordlists_id,pots_id,nonce) values($johnid,$lists_id,$potid,$nonce)"
        elif [ "$mode" = "2" ]
        then
            sqlite3 "$path/data/pot.db" "insert into johns_charsets_pots(johns_id,charsets_id,pots_id,nonce) values($johnid,$lists_id,$potid,$nonce)"
        elif [ "$mode" = "3" ]
        then
            sqlite3 "$path/data/pot.db" "insert into johns_charsets_pots(johns_id,charsets_id,pots_id) values($johnid,$lists_id,$potid)"
        fi
    fi
done



