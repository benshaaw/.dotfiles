#!/bin/sh
xrandr --output VIRTUAL1 --off --output eDP1 --primary --mode 1600x900 --pos 0x0 --rotate normal --output DP1 --mode 1920x1200 --pos 1600x0 --rotate normal --output HDMI2 --off --output HDMI1 --off --output DP2 --off && sleep 1 && i3-msg restart
