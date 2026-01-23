#!/bin/bash

CONFIG_FILE="$HOME/dotfiles/niri/config.kdl"

if [[ "$1" == "intl" ]]; then
    # Set US International layout
    sed -i 's/layout "us"/layout "us"/' "$CONFIG_FILE"
    if grep -q 'variant "intl"' "$CONFIG_FILE"; then
        echo "Already using US International layout"
    else
        sed -i '/layout "us"/a\	    variant "intl"' "$CONFIG_FILE"
        echo "Switched to US International layout"
    fi
else
    # Set classic US layout (remove variant line)
    if grep -q 'variant "intl"' "$CONFIG_FILE"; then
        sed -i '/variant "intl"/d' "$CONFIG_FILE"
        echo "Switched to classic US layout"
    else
        echo "Already using classic US layout"
    fi
fi
