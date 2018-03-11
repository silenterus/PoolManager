#!/bin/bash 


### GET SETTINGS

configid=1

curl "maps.googleapis.com/maps/api/geocode/xml?latlng=$1,$2&sensor=false" | grep "<formatted_address>" | grep -m1 "" | sed "s/  <formatted_address>//g" | sed "s/<\/formatted_address>//g"
