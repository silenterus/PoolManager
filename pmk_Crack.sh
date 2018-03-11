#!/bin/bash 


### GET SETTINGS

path="/root/wordlistFramework"

genpath="/media/root/DUMPER1/genpmk"


wait=350
threads=4
threadcurrent=0
sqlhits=$(sqlite3 "/root/wordlistFramework/data/pot.db" "select essid from rainbows")
echo "------------------------------------------------"
if [ -d "$path/temp/cap" ]
then
    rm -r "$path/temp/cap" 
fi

if [ ! "$1" ]
then
    echo "FORGOT PMK ID MORON!!!"
    exit
fi

mkdir "$path/temp/cap"


SAVEIFS=$IFS
IFS=$'\n'
sqlhits=($sqlhits)
IFS=$SAVEIFS

for (( i=0; i<${#sqlhits[@]}; i++ ))
do
    hit="${sqlhits[$i]}";
    #sqlhits=$(sqlite3 "/root/wordlistFramework/data/pot.db" "select name,wordlists_id from wordlists")
    echo "------------------------------------------------"
#echo "" > oftenNetworks
    pmks=$(sqlite3 "/root/wordlistFramework/data/pot.db" "select name,localpath,wordlists_pmks_id from wordlists_pmks where wordlists_pmks_id=$1")
    SAVEIFS=$IFS
    IFS=$'\n'
    pmks=($pmks)
    IFS=$SAVEIFS
    for (( p=0; p<${#pmks[@]}; p++ ))
    do
        pmk="${pmks[$p]}";
        SAVEIFS=$IFS
        IFS=$'|'
        pmk=($pmk)
        IFS=$SAVEIFS
        echo "${pmk[0]}"
        echo "${pmk[1]}"
        lists_id=${pmk[2]}
        if [ -f "$genpath/cow/${pmk[0]}/$hit.cow" ]
        then
            echo "STARTING COW"
            echo
            echo "-----"
            echo "---------------"
            echo "[$i]"
            echo "[ ${pmk[0]} - $hit.cow ]" 
            echo
            echo "---------------"
            echo "---------------"
               
            pothits=$(sqlite3 "$path/data/pot.db" "select bssid,pots_id,essid from pots where status=2" | sed "s/://g")
            ### MERGE ALL INTO ONE HCCAP FILE
            SAVEIFS=$IFS
            IFS=$'\n'
            pothits=($pothits)
            IFS=$SAVEIFS
            echo "FOUND ${#pothits[@]} POSSIBLE WIFIS"
            for (( u=0; u<${#pothits[@]}; u++ ))
            do
    
    
                potsingle="${pothits[$u]}";
     
                SAVEIFS=$IFS
                IFS=$'|'
                potsingle=($potsingle)
                IFS=$SAVEIFS
                bssid="${potsingle[0]}";
                potid="${potsingle[1]}";
                essid="${potsingle[2]}";                          
               
                johnid=$(sqlite3 "$path/data/pot.db" "select johns_id from johns where bssid='$bssid'")
            
                johnsingle="$johnid";
             
                SAVEIFS=$IFS
                IFS=$'\n'
                echo "--------------"
                echo ""
                echo "TRYING [$essid - $bssid ]" 
                echo
                echo "---------------"
                echo "---------------"
                johnsingle=($johnsingle)
                IFS=$SAVEIFS
            
                for (( j=0; j<${#johnsingle[@]}; j++ ))
                do 
    
     
                    check=$(sqlite3 "$path/data/pot.db" "select johns_pmks_pots_id from johns_pmks_pots where johns_id=${johnsingle[$j]} and pmks_id=$lists_id")
                    if [ ! "$check" ]
                    then
                        echo "STARTING COW WITH JOHN [${johnsingle[$j]}]" 
                        echo
                        echo "---------------"
                        sqlite3 "$path/data/pot.db" "select essid,hash,station,bssid_convert,bssid,blank,type,status,source from johns where johns_id=${johnsingle[$j]}" | sed "s/|/:/g" >> "$path/temp/johns/${johnsingle[$j]}.john"; 
                        wlanjohn2hcx -o "$path/temp/hccapx/pmk.${johnsingle[$j]}.hccapx" "$path/temp/johns/${johnsingle[$j]}.john"
                        wlanhcx2cap -i "$path/temp/hccapx/pmk.${johnsingle[$j]}.hccapx" -O "$path/temp/cap/${johnsingle[$j]}.cap"

                        cowpatty -c "'${johnsingle[$j]}'" -r "'$path/temp/cap/${johnsingle[$j]}.cap'" -d "'$genpath/cow/${pmk[0]}/$hit.cow'"
                        #sqlite3 "$path/data/pot.db" "insert into johns_pmks_pots(johns_id,pmks_id,pots_id) values(${johnsingle[$j]},$potid,$lists_id)"
                    else
                        echo "ALREADY TRIED JOHN [${johnsingle[$j]}]" 
                        echo
                        echo "---------------"
                    fi
                done
            
                #query="johns_id=$query"
            
 
            
            done
            
            

        else
            echo "NO COW FILE YET"  
        fi

    done

 
    #path=$(find "$listpath" -name "$name")
    #echo "$path"
    #sqlite3 "/root/wordlistFramework/data/pot.db" "update wordlists set localpath='$name' where wordlists_id=$wordlists_id"
    #num=$(sqlite3 "$path/data/old PTS/pot.db" "select rowid from pots where essid='${sqlhits[$i]}'" | wc -l );

done


