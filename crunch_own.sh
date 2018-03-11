#!/bin/bash 



input="$2"
dictpath="$1"
#sqlhits=$(cat "ALLGER")
echo "------------------------------------------------"
echo "" > TempList
echo "" > OutList
cat "$dictpath" >> TempList
SAVEIFS=$IFS
IFS=$'@'
input=($input)
IFS=$SAVEIFS
echo "DICT = $dictpath"
for (( i=0; i<${#input[@]}; i++ ))
do
    mode="${input[$i]}"
    SAVEIFS=$IFS
    IFS=$'|'
    mode=($mode)
    IFS=$SAVEIFS
    echo "$i/${#input[@]}"
    echo "$mode"

    appendmode="${mode[0]}"
    append="${mode[1]}"

    if [ "$appendmode" = "1" ]
    then
        sed ':a;N;$!ba;s/\n/\nAPPENDMODE/g' "TempList"  | sed "s/APPENDMODE/$append/g" >> OutList
    elif [ "$appendmode" = "2" ]
    then
        sed ':a;N;$!ba;s/\n/APPENDMODE\n/g' "TempList"  |  sed ':a;N;$!ba;s/\n\n/\n/g' | sed "s/APPENDMODE/$append/g" >> OutList
    elif [ "$appendmode" = "3" ]
    then
        sed ':a;N;$!ba;s/\n/APPENDMODE\nAPPENDMODE/g' "TempList"  | sed "s/APPENDMODE/$append/g" >> OutList
    elif [ "$appendmode" = "4" ]
    then
        sed ':a;N;$!ba;s/\n/APPENDMODE\nAPPENDMODE/g' "TempList"  | sed "s/APPENDMODE/$append/g" >> OutList
        sed ':a;N;$!ba;s/\n/APPENDMODE\n/g' "TempList"  | sed "s/APPENDMODE/$append/g" >> OutList
        sed ':a;N;$!ba;s/\n/APPENDMODE\n/g' "TempList"  | sed "s/APPENDMODE/$append/g" >> OutList
    fi
done
