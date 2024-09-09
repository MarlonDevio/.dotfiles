#!/bin/bash

# Gebruik zoxide's interactieve zoekfunctie en geef de output door aan cd
zi "$@"

# Als er geen directory werd geselecteerd, doen we niets
if [ $? -eq 0 ]; then
    selected_dir=$(zoxide query -i "$@")
    if [ -n "$selected_dir" ]; then
        cd "$selected_dir" || exit
    fi
else
    echo "No matching directory found."
fi
