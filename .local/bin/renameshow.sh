#!/bin/bash

read -p "Name of the show: " base_name
read -p "File extension: " extension

index=1

for file in *".$extension"; do
    episode_number=$index

    if [ $index -lt 10 ]; then
        episode_number="0$index"
    fi

    new_name="${base_name} - ${episode_number}.${extension}"
    mv "$file" "$new_name"

    index=$(expr $index + 1)
done
