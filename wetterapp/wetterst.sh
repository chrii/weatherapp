#/bin/bash
weather=`lynx -source www.accuweather.com | egrep 'recentlocation' -i | cut -d\" -sf 4 | head -1`
dather=`date | cut -d\: -f 2-4 && echo $weather` && echo $dather >> ~/wetterapp/wetterberichtst
