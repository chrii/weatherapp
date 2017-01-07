
############################################
### Copyright Christopher Pintarich 
### This Programm only works for the 24 hour 
### timeformat and is made for/with Linux Ubuntu 16.04 and Bash.
###
### The Mainlanguage of the comments is German 
### GPL Licenced
############################################

#!/bin/bash

siteconnection=`curl -so /dev/null --connect-timeout 1 www.accuweather.com && echo 0 || echo 1` 	#Verbindungsüberprüfung
daytime=`date | cut -d\  -f 4 | cut -d\: -f 1`								#Gekürzte Uhrzeit (Achtung, nur 24 Stunden Format)
weather=`lynx -source www.accuweather.com | egrep -i 'recentlocation' | cut -d\" -sf 4 | head -1`	#Wetter nach Ortd

##Bilder in der Früh
picfruehcloud="Bildpfad Früh mit Wolken"
picfruehklar="Bildpfad klar früh"
picfruehsun="Bildpfad sonne früh"

##Bilder am Tag
pictagcloud="Bildpfad Tag mit Wolken"
pictagklar="Bildpfad Tag klar"
pictagsun="Bildpfad Tag Sonnig"

##Bilder am Abend
picabendcloud="Bildpfad Abend mit Wolken"
picabendklar="Bildpfad Abend klar"
picabendsun="Bildpfad am Abned"

##Bilder in der Nacht
picnachtcloud="Bildpfad Nacht mit Wolken"
picnachtklar="Bildpfad Nacht klar"

##weather="sunny"  		##Dummy

if [ $daytime -gt 6 -a $daytime -lt 10 ]								#Definiert die Tageszeit 
	then daytime="frueh"
elif [ $daytime -gt 10 -a $daytime -lt 14 ]
	then daytime="Tag"
elif [ $daytime -gt 14 -a $daytime -lt 19 ]
	then daytime="Tag"
elif [ $daytime -gt 18 -a $daytime -lt 22 ]
	then daytime="Abend"
elif [ $daytime -gt 22 -o $daytime -lt 6 ]
	then daytime="Nacht"
else $daytime="Nacht"
fi

##Bei keiner Verbindung zur Website oder Internet 
#if [ $daytime = "frueh" ]										#Definition des Bildes wenn Verbindung vorhanden
#		then  picfruehsun=$noconnect 
#	elif [ $daytime = "frueh" ]  
#		then  picfruehklar=$noconnect
#	elif [ $daytime = "Tag" ]    
#		then  pictagsun=$noconnect
#	elif [ $daytime = "Abend" ]  
#		then  picabendsun=$noconnect
#	elif [ $daytime = "Nacht" ]  
##		then  picabendklar=$noconnect
#	else noconnect="Not found on Offlinedata"
#fi

case "$weather" in 
	"Cloudy" | "Partly cloudy" | "Clouds and sun" | "Mostly cloudy") weather="cloud" ;;
	"Clear") weather="klar" ;;
	"Partly sunny" | "Sun") weather="sun";;
	*) dather=`date | cut -d\  -f 2-4 && echo $weather` && echo $dather >> ~/wetterapp/weathererror ;;
esac

if [ $siteconnection = 0 ]										#Verbindungsüberprüfung
		then \
			 if [ $weather = "cloud" -a $daytime = "frueh" ]					#Definition des Bildes wenn Verbindung vorhanden
				then echo $picfruehcloud
			elif [ $weather = "klar" -a $daytime = "frueh" ]
				then echo $picfruehklar
			elif [ $weather = "sun" -a $daytime = "frueh" ]
				then echo $picfruehsun
			elif [ $weather = "cloud" -a $daytime = "Tag" ]
				then echo $pictagcloud
			elif [ $weather = "klar" -a $daytime = "Tag" ]
				then echo $pictagklar
			elif [ $weather = "sun" -a $daytime = "Tag" ]
				then echo $pictagsun
			elif [ $weather = "cloud" -a $daytime = "Abend" ]
				then echo $picabendcloud
			elif [ $weather = "klar" -a $daytime = "Abend" ]
				then echo $picabendklar
			elif [ $weather = "sun" -a $daytime = "Abend" ]
				then echo $picabendsun
			elif [ $weather = "cloud" -a $daytime = "Nacht" ]
				then echo $picnachtcloud
			elif [ $wearher = "klar" -a $daytime = "Nacht" ]
				then echo $picnachtklar
			else	$noconnect 
			fi
		else $daytime
fi
echo $weather
echo $noconnect
echo $daytime

