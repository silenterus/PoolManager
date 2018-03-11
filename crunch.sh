#!/bin/bash 



if [ -d "temp" ]
then
    rm -r temp
fi

mkdir temp

crunch 5 5 -o temp/crunched -t %%%dd -p $1 $2 $3 $4 $5 $6 $7 $8
cat temp/crunched > temp/NewDict

crunch 5 5 -o temp/crunched -t dd%%% -p $1 $2 $3 $4 $5 $6 $7 $8
cat temp/crunched >> temp/NewDict

crunch 5 5 -o temp/crunched -t %%dd -p $1 $2 $3 $4 $5 $6 $7 $8
cat temp/crunched >> temp/NewDict

crunch 5 5 -o temp/crunched -t dd%% -p $1 $2 $3 $4 $5 $6 $7 $8
cat temp/crunched >> temp/NewDict

crunch 3 3 -o temp/crunched -t dd% -p $1 $2 $3 $4 $5 $6 $7 $8
cat temp/crunched >> temp/NewDict
crunch 3 3 -o temp/crunched -t %dd -p $1 $2 $3 $4 $5 $6 $7 $8
cat temp/crunched >> temp/NewDict
crunch 3 3 -o temp/crunched -t d%d -p $1 $2 $3 $4 $5 $6 $7 $8
cat temp/crunched >> temp/NewDict
crunch 4 4 -o temp/crunched -t %dd% -p $1 $2 $3 $4 $5 $6 $7 $8
cat temp/crunched >> temp/NewDict
crunch 5 5 -o temp/crunched -t %d%d% -p $1 $2 $3 $4 $5 $6 $7 $8
cat temp/crunched >> temp/NewDict
crunch 2 2 -o temp/crunched -t dd -p $1 $2 $3 $4 $5 $6 $7 $8
cat temp/crunched >> temp/NewDict
crunch 2 2 -o temp/crunched -t d% -p $1 $2 $3 $4 $5 $6 $7 $8
cat temp/crunched >> temp/NewDict
crunch 2 2 -o temp/crunched -t %d -p $1 $2 $3 $4 $5 $6 $7 $8
cat temp/crunched >> temp/NewDict

crunch 4 4 -o temp/crunched -t %%%d -p $1 $2 $3 $4 $5 $6 $7 $8
cat temp/crunched >> temp/NewDict

crunch 4 4 -o temp/crunched -t d%%% -p $1 $2 $3 $4 $5 $6 $7 $8
cat temp/crunched >> temp/NewDict

crunch 3 3 -o temp/crunched -t %%d -p $1 $2 $3 $4 $5 $6 $7 $8
cat temp/crunched >> temp/NewDict

crunch 3 3 -o temp/crunched -t d%% -p $1 $2 $3 $4 $5 $6 $7 $8
cat temp/crunched >> temp/NewDict



crunch 3 3 -o temp/crunched -t %d% -p $1 $2 $3 $4 $5 $6 $7 $8
cat temp/crunched >> temp/NewDict 

cat temp/NewDict | sed -r '/^.{,8}$/d' > temp/NewDict2

rm temp/NewDict


