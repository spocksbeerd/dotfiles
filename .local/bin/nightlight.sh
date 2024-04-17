#!/bin/bash

host=$(uname -n)

if [[ "$host" == "laptop" ]]; then
    sct 3000
else
    sct 3400
fi
