#!/bin/bash

power=$(bluetoothctl show | grep Powered: | awk '{print $2}')
if [ "$power" = "yes" ]; then
    echo "true"
else
    echo "false"
fi
