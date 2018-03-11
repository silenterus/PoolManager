#!/bin/bash 



function jumpto
{
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}

start=${1:-"start"}

jumpto $start


frameworkstartstart:

### GET SETTINGS

configid=1
config=$(sqlite3 "data/pot.db" "select root_path,dumper_path,autostart_dumper,onchannel,startdifference,stopper_active,dump_deamons from configs where configs_id=$configid")
echo "------------------------------------------------"
SAVEIFS=$IFS
IFS=$'|'
config=($config)
IFS=$SAVEIFS

path="${config[0]}"
dumperpath="${config[1]}"
autostartdumper="${config[2]}"
timeonchannel="${config[3]}"
startdifference="${config[4]}"
stopperactive="${config[5]}"
deamons="${config[6]}"
symbol1=$(toilet -f digital -F metal ..wOrDliSt.cReAtIoN..)
echo "$symbol1"


echo ;
echo -e "\e[36m\e[10m\e[1mxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\e[0m";
echo -e "\e[36m\e[10m\e[1mx  HASH OVERWATCH  x\e[0m";
echo -e "\e[36m\e[10m\e[1mxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx\e[0m";
echo ;


#platformlist=$(sqlite3 "$dir/db/harrys_hacksploit.db" "select name from platforms") 



while true; do

menustart:
clear
echo ;
echo -e "\e[36m\e[10m\e[1mWhat do you whant to do?\e[12m";
echo -e "\e[36m\e[10m\e[1m-----------------------------\e[2m";
echo -e "\e[36m\e[10m\e[1m1.  CHARSET ATTACK\e[2m";
echo -e "\e[36m\e[10m\e[1m2.  HANDSHAKES CHARSETS DIRECTLY\e[6m";
echo -e "\e[36m\e[10m\e[1m3.  DICTIONARY ATTACKS\e[6m";
echo -e "\e[36m\e[10m\e[1m4.  HANDSHAKES DICTIONARY DIRECTLY\e[6m";
echo -e "\e[36m\e[10m\e[1m9.  CONFIGS\e[6m";
echo ;
echo

echo -n "Enter your choice, or 0 for exit: "
read choice
echo
clear

case $choice in
     1)
     charsetattack:
     echo ;
     echo -e "\e[36m\e[10m\e[1mCHARSET ATTACK\e[0m";
     echo ;
     echo -e "\e[36m\e[10m\e[1m [schar=] for DB SEARCH HANDSHAKES \e[0m";
     echo ;
     echo ;
     echo -n "Enter ID RANGE [1,3,10-15] : "
     read server
     check=$(grep 'schar=' <<< "$server" | sed "s/schar=//g")
     echo "$check"
     if [ -n "$check" ]
     then
         checkletter=$(grep '[a-zA-Z]' <<< "$check")
         if [ -n "$checkletter" ]
         then
             echo lala;
         fi 
     else
          echo -e "\e[31m\e[10m\e[1mNO SEARCH TERM\e[0m";
          jumpto charsetattack        
     fi

     echo "$checkletter"
     echo "$checknum"
     break
     ;;
     2)
     echo ;
     echo -e "\e[36m\e[10m\e[1mHANDSHAKES CHARSETS DIRECTLY\e[0m";
     echo -e "\e[36m\e[10m\e[1m [sshake] for DB SEARCH HANDSHAKES \e[0m";
     echo -e "\e[36m\e[10m\e[1m [schar] for DB SEARCH HANDSHAKES \e[0m";
     read server
     break
     ;;
     3)
     echo ;
     echo -e "\e[36m\e[10m\e[1mDICTIONARY ATTACKS\e[0m";
     echo -e "\e[36m\e[10m\e[1m [sdic] for DB SEARCH \e[0m";
     echo ;
     read server
     break
     ;;
     4)
     echo ;
     echo -e "\e[36m\e[10m\e[1mHANDSHAKES DICTIONARY DIRECTLY\e[0m";
     echo -e "\e[36m\e[10m\e[1m [sshake] for DB SEARCH HANDSHAKES \e[0m";
     echo -e "\e[36m\e[10m\e[1m [sdic] for DB SEARCH HANDSHAKES \e[0m";
     echo ;
     read server
     break
     ;;
     9)
     configstart:
     echo ;
     clear
     echo -e "\e[36m\e[10m\e[1mCONFIGS\e[0m";
     echo -e "\e[36m\e[10m\e[1m-----------------------------\e[2m";
     echo -e "\e[31m\e[10m\e[1m0. BACK\e[2m";
     echo -e "\e[36m\e[10m\e[1m-----------------------------\e[2m";
     echo -e "\e[36m\e[10m\e[1m1.  ROOT DIRECTORY [$path]\e[2m";
     echo -e "\e[36m\e[10m\e[1m2.  HANDSHAKEDUMPER DIRECTORY  [$dumperpath]\e[6m";
     if [ "$autostartdumper" == "1" ]
     then
         echo -e "\e[36m\e[10m\e[1m3.  AUTOSTART HANDSHAKEDUMPER\e[6m" "\e[32m\e[10m\e[1m[enabled]\e[6m";
     elif [ "$autostartdumper" == "0" ]
     then
         echo -e "\e[36m\e[10m\e[1m3.  AUTOSTART HANDSHAKEDUMPER\e[6m" "\e[31m\e[10m\e[1m[disabled]\e[6m";
     fi
     if [ "$stopperactive" == "1" ]
     then
         echo -e "\e[36m\e[10m\e[1m4.  POWER OFF MODE\e[6m" "\e[32m\e[10m\e[1m[enabled]\e[6m";
     elif [ "$stopperactive" == "0" ]
     then
         echo -e "\e[36m\e[10m\e[1m4.  POWER OFF MODE\e[6m" "\e[31m\e[10m\e[1m[disabled]\e[6m";
     fi
     echo -e "\e[36m\e[10m\e[1m5.  TIME ON CHANNEL  [$timeonchannel]\e[6m";
     echo -e "\e[36m\e[10m\e[1m6.  HOW MANY DUMP DEAMONS  [$deamons]\e[6m";
     echo -e "\e[36m\e[10m\e[1m7.  START CHANNEL DIFFERENCE BETWEEN DEAMONS  [$startdifference]\e[6m";
     echo -e "\e[36m\e[10m\e[1m8.  BERKELEY FILTER PATH [$dumperpath]\e[6m";
     echo -e "\e[36m\e[10m\e[1m9.  RS-SCAN FILTER PATH [$dumperpath]\e[6m";
     echo -e "\e[36m\e[10m\e[1m\e[6m"

 
     read config
     case $config in
          1)
          echo ;
          echo -e "\e[36m\e[10m\e[1mCHANGE ROOT PATH\e[0m";
          echo ;
          read newpath
          path="$newpath";
          sqlite3 "data/pot.db" "update configs set root_path='$newpath' where configs_id=$configid";
          echo -e "\e[32m\e[10m\e[1mCHANGED ROOT PATH TO\e[0m";
          echo -e "\e[32m\e[10m\e[1m$path\e[0m";
          ;;
          2)
          echo ;
          echo -e "\e[36m\e[10m\e[1mCHANGE HANDSHAKEDUMPER PATH\e[0m";
          echo ;
          read newpath
      
          #awk '{ if (NR == 2) print "$path"; else print $0}' config/config > config/config2
          sqlite3 "data/pot.db" "update configs set dumper_path='$newpath' where configs_id=$configid";
          path="$newpath";
          echo -e "\e[32m\e[10m\e[1mCHANGED HANDSHAKEDUMPER PATH TO\e[0m";
          echo -e "\e[32m\e[10m\e[1m$path\e[0m";
          ;;
          3)
          echo ;
          if [ "$autostartdumper" == "0" ]
          then
              echo -e "\e[36m\e[10m\e[1mAUTOSTART HANDSHAKEDUMPER\e[6m" "\e[32m\e[10m\e[1m[enabled]\e[6m";
              echo ;  
              autostartdumper=1;
              sqlite3 "data/pot.db" "update configs set autostart_dumper=1 where configs_id=$configid";
          elif [ "$autostartdumper" == "1" ]
          then
              echo -e "\e[36m\e[10m\e[1mAUTOSTART HANDSHAKEDUMPER\e[6m" "\e[31m\e[10m\e[1m[disabled]\e[6m";
              echo ;  
              autostartdumper=0;
              sqlite3 "data/pot.db" "update configs set autostart_dumper=0 where configs_id=$configid";
          fi
          jumpto configstart
          ;;
          4)
          echo ;
          if [ "$stopperactive" == "0" ]
          then
              echo -e "\e[36m\e[10m\e[1mPOWER OFF MODE\e[6m" "\e[32m\e[10m\e[1m[enabled]\e[6m";
              echo ;  
              stopperactive=1;
              sqlite3 "data/pot.db" "update configs set stopper_active=1 where configs_id=$configid";
          elif [ "$stopperactive" == "1" ]
          then
              echo -e "\e[36m\e[10m\e[1mPOWER OFF MODE\e[6m" "\e[31m\e[10m\e[1m[disabled]\e[6m";
              echo ;  
              stopperactive=0;
              sqlite3 "data/pot.db" "update configs set stopper_active=0 where configs_id=$configid";
          fi
          jumpto configstart
          ;;
          5)
          timeonchannelstart:
          echo ;
          read timeonchannel
          checker=$(grep '[a-zA-Z]' <<< "$timeonchannel")
          if [ -n "$checker" ]
          then
              echo -e "\e[31m\e[10m\e[1mNOT VALID\e[0m";
              echo -e "\e[31m\e[10m\e[1mNEED TO BE A NUM\e[0m";
              jumpto timeonchannelstart
          else
              sqlite3 "data/pot.db" "update configs set onchannel=$timeonchannel where configs_id=$configid";
              echo -e "\e[36m\e[10m\e[1mCHANGED TIME ON CHANNEL TO \e[6m" "\e[32m\e[10m\e[1m[$timeonchannel]\e[6m";
          fi
          jumpto configstart
          ;;
          6)
          deamonsstart:
          echo ;
          read deamons
          checker=$(grep '[a-zA-Z]' <<< "$deamons")
          if [ -n "$checker" ]
          then
              echo -e "\e[31m\e[10m\e[1mNOT VALID\e[0m";
              echo -e "\e[31m\e[10m\e[1mNEED TO BE A NUM\e[0m";
              jumpto deamonsstart
          else
              sqlite3 "data/pot.db" "update configs set dump_deamons=$deamons where configs_id=$configid";
              echo -e "\e[36m\e[10m\e[1mCHANGED DEAMONS TO \e[6m" "\e[32m\e[10m\e[1m[$deamons]\e[6m";
          fi
          jumpto configstart
          ;;
          7)
          startdifferencestart:
          echo ;
          read startdifference
          checker=$(grep '[a-zA-Z]' <<< "$startdifference")
          if [ -n "$checker" ]
          then
              echo -e "\e[31m\e[10m\e[1mNOT VALID\e[0m";
              echo -e "\e[31m\e[10m\e[1mNEED TO BE A NUM\e[0m";
              jumpto startdifferencestart
          else
              sqlite3 "data/pot.db" "update configs set startdifference=$startdifference where configs_id=$configid";
              echo -e "\e[36m\e[10m\e[1mCHANGED START DIFFERENCE TO \e[6m" "\e[32m\e[10m\e[1m[$startdifference]\e[6m";
          fi
          jumpto configstart
          ;;
          0)
          echo ;
          echo -e "\e[31m\e[10m\e[1mBACK\e[0m";
          jumpto menustart
          ;;
          9)
          echo ;
          echo -e "\e[36m\e[10m\e[1mFISH SOME HANDSHAKES\e[0m";
          echo ;
          read server
          break
          ;;
          0)
          echo "OK, see you!"
          break
          ;;
          *)
          echo ;
          echo -e "\e[31m\e[10m\e[1mNOT VALID\e[0m";
          echo ;
          ;;
     esac  
     ;;
     0)
     echo "OK, see you!"
     ;;
     *)
     echo ;
     echo -e "\e[31m\e[10m\e[1mNOT VALID\e[0m";
     echo ;
     ;;
esac  
done

