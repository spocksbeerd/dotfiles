#!/bin/bash

imgpath=~/.local/bin/screenshot.png
scrot -c "${imgpath}" 

while [ ! -f "${imgpath}" ];
do
    sleep 0.1
done

paplay ~/.local/share/sounds/notification.ogx &

feh -F "${imgpath}" 
rm "${imgpath}" 
