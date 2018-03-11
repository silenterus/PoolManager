#!/bin/bash

echo "" > proxys
curl "https://www.my-proxy.com/free-socks-4-proxy.html" -o free-socks-4-proxy.html
checkdead=1
routerlist=$(cat free-socks-4-proxy.html | grep -oP '(?<=\<div class\=\"list\"\>).*(?=\<\/div\>\<\/div\>\<div class\=\"list)' | sed "s/<br>/@/g" | sed "s/<div class='to-lock'>//g" | sed "s/:/	/g" | sed "s/#US//g")

SAVEIFS=$IFS
IFS=$'@'
routerlist=($routerlist)
IFS=$SAVEIFS
for (( i=0; i<${#routerlist[@]}; i++ ))
do
    if [ "$checkdead" = "1" ]
    then
        proxy="socks4	${routerlist[$i]}"
       
       
        cat "/etc/proxychainsTEST.conf" | sed "s/PROXYINPUT/$proxy/g" > /etc/proxychains.conf
        proxychains curl https://www.google.de -o test.proxy
        if [ -f "test.proxy" ]
        then
            echo "socks4 ${routerlist[$i]}" >> proxys
            rm test.proxy
        fi
        #cat "$proxyconf" | sed "s/PROXYINPUT/$proxy/g" > "teste/$i.test.proxy.conf"
        #proxychains curl https://www.google.de -o teste/$i.test.proxy
        
        #cat test.proxy >> test.proxy.all
    fi

done
curl "https://www.my-proxy.com/free-socks-5-proxy.html" -o free-socks-5-proxy.html
routerlist=$(cat free-socks-5-proxy.html | grep -oP '(?<=\<div class\=\"list\"\>).*(?=\<\/div\>\<\/div\>\<div class\=\"list)' | sed "s/<br>/@/g" | sed "s/<div class='to-lock'>//g" | sed "s/:/	/g" | sed "s/#US//g")

SAVEIFS=$IFS
IFS=$'@'
routerlist=($routerlist)
IFS=$SAVEIFS
for (( i=0; i<${#routerlist[@]}; i++ ))
do
    if [ "$checkdead" = "1" ]
    then
        proxy="socks4	${routerlist[$i]}"

       
        
        cat "/etc/proxychainsTEST.conf" | sed "s/PROXYINPUT/$proxy/g" > /etc/proxychains.conf
        proxychains curl https://www.google.de -o test.proxy
        if [ -f "test.proxy" ]
        then
            echo "socks5 ${routerlist[$i]}" >> proxys
            rm test.proxy
        fi
        
        #cat test.proxy >> test.proxy.all
    fi

done


proxyconf="/etc/proxychainsORI.conf"
proxyused="/etc/proxychains.conf"
cat "$proxyconf" > "$proxyused"
cat "proxys" >> "$proxyused"
 

echo
