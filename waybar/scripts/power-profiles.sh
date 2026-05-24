#!/bin/bash

# Get the active profile name
profile=$(powerprofilesctl get)

# Map the active profile to a percentage bracket and a css class name
case "$profile" in
    "performance")
        class="performance"
        percentage=0
        ;;
    "balanced")
        class="balanced"
        percentage=40
        ;;
    "power-saver")
        class="power-saver"
        percentage=70
        ;;
    *)
        class="error"
        percentage=100
        ;;
esac

# Output the valid JSON block string
echo "{\"text\": \"$profile\", \"percentage\": $percentage, \"class\": \"$class\"}"
