#!/bin/bash

if ! pgrep -f lxqt-policykit-agent > /dev/null; then
    lxqt-policykit-agent &
fi
