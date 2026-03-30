#!/bin/bash

# Get current bar hidden state
HIDDEN=$(sketchybar --query bar | jq -r '.hidden')

if [ "$HIDDEN" == "off" ]; then
    # Bar is visible, hide it and remove yabai padding
    sketchybar --bar hidden=on
    yabai -m config external_bar all:0:0
else
    # Bar is hidden, show it and restore yabai padding
    sketchybar --bar hidden=off
    yabai -m config external_bar all:32:0
fi
