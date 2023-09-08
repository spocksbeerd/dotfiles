#!/bin/bash

pkill dunst

dunstdir=~/.config/dunst

cat ${dunstdir}/dunstrc ${dunstdir}/colors | dunst -conf -
