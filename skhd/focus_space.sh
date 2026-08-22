#!/bin/bash

# Ensure jq is accessible if it's in a non-standard PATH
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

direction="$1"

# Get the array of space indexes for the current display
# Find which one is currently focused, and calculate the target
if [ "$direction" = "next" ]; then
  target_space=$(yabai -m query --spaces --display | jq -e 'map(.index) as $idx | map(.focused == 1 or .focused == true or .["has-focus"] == true) | index(true) as $cur | $idx[($cur + 1) % length]')
else
  target_space=$(yabai -m query --spaces --display | jq -e 'map(.index) as $idx | map(.focused == 1 or .focused == true or .["has-focus"] == true) | index(true) as $cur | $idx[($cur - 1 + length) % length]')
fi

# If a valid target space index was found, focus it
if [ -n "$target_space" ] && [ "$target_space" != "null" ]; then
  yabai -m space --focus "$target_space"
fi

# Focus next space on the CURRENT display (loops safely)
# ctrl - right : yabai -m space --focus $(yabai -m query --spaces --display | \
#     jq -e 'map(.index) as $idx | map(.focused == 1 or .focused == true or .["has-focus"] == true) | index(true) as $cur | $idx[($cur + 1) % length]')
#
# # Focus previous space on the CURRENT display (loops safely)
# ctrl - left  : yabai -m space --focus $(yabai -m query --spaces --display | \
#     jq -e 'map(.index) as $idx | map(.focused == 1 or .focused == true or .["has-focus"] == true) | index(true) as $cur | $idx[($cur - 1 + length) % length]')


