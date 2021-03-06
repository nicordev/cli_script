#! /bin/bash

## Switch on or off the night light mode, no matter what time is it.

nightLightEnabledKey='night-light-enabled'
scheduleFromKey='night-light-schedule-from'
scheduleToKey='night-light-schedule-to'

help() {
    styleTitle="\e[32;1m"
    styleStrong="\e[1m"
    styleNormal="\e[0m"
    scriptName=$(basename $0)

    echo -e "${styleTitle}How it works?\n${styleNormal}"
    
    echo -e "${styleStrong}To activate night light:${styleNormal}"
    echo -e "    $scriptName on"
    
    echo -e "${styleStrong}\nTo deactivate night light:${styleNormal}"
    echo -e "    $scriptName off"
    
    echo -e "${styleStrong}\nTo toggle night light:${styleNormal}"
    echo -e "    $scriptName toggle"

    echo -e "${styleStrong}\nTo list gnome settings related to night light:${styleNormal}"
    echo -e "    $scriptName listKeys"

    echo -e "${styleStrong}\nTo get a gnome setting:${styleNormal}"
    echo -e "    $scriptName get keyName"

    echo -e "${styleStrong}\nTo set a gnome setting:${styleNormal}"
    echo -e "    $scriptName set keyName keyValue"
}

# List setting keys related to night light
listKeys() {
    gsettings list-keys org.gnome.settings-daemon.plugins.color
}

# Get a setting value
#
# $1 setting key
get() {
    gsettings get org.gnome.settings-daemon.plugins.color "$1"
}

# Set a setting
#
# $1 setting key
# $2 setting value
set() {
    gsettings set org.gnome.settings-daemon.plugins.color "$1" "$2"
}

# Activate night light
on() {
    set $scheduleFromKey 12.0
    set $scheduleToKey 11.9
    set $nightLightEnabledKey true
}

# Deactivate night light
off() {
    set $nightLightEnabledKey false
}

# Toggle night light
toggle() {
    if [ $(get $nightLightEnabledKey) == true ]; then
        off
        return
    fi

    on
}

if [ $# -eq 0 ]; then
    help
    exit
fi

$@