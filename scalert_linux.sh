#!/bin/bash
# WAR Scenario Alerter
# Requires notify-send, aplay and ScenarioAlert Addon by Caffeine
# by xpander

# Go into the directory
BINDIR="$(dirname "$(readlink -fn "$0")")"
cd "$BINDIR"

# Parameters
# filename
file="scenarioAlert.log"
# Check for filesize to only trigger if its bigger than 1
filesize=1
# icon name
icon="warhammer-online-icon.png"
# Notification time in milliseconds
ntime="20000"
# Check inteval in seconds
ctime=5
# Audio file
audio="notify.wav"
# Check file md5sum
mdsum=$(md5sum ${file})

# Do the magic
while sleep $ctime; do
mdsum_new=$(md5sum ${file})
if [[ ${mdsum_new} != ${mdsum} && ($(stat -c%s $file) > $filesize) ]] ; then
# Notification with sound
notify-send "Warhammer:Return of Reckoning" "Scenario Pop" --icon="$BINDIR/$icon" --urgency=critical -t $ntime && aplay "$BINDIR/audio/$audio"
# Use the new md5sum
mdsum=${mdsum_new}
fi
done

