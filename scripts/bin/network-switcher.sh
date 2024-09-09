#!/bin/bash

SSID1="H369AEB0E20"
PASSWORD1="39DAD6A2DC76"
SSID2="RemmersWiffi"
PASSWORD2="35050711"

# Check if RSSI values are captured
if [ -z "$RSSI1" ] || [ -z "$RSSI2" ]; then
  echo "One of the networks could not be found."
  exit 1
fi
# Get the RSSI (signal strength) for each network
RSSI1=$( /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s "$SSID1" | awk '{print $3}' )

RSSI2=$( /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s "$SSID2" | awk '{print $3}' )

if [ "$RSSI1" -gt "$RSSI2" ]; then
  networksetup -setairportnetwork en0 "$SSID1" PASSWORD1 
else
  networksetup -setairportnetwork en0 "$SSID2" PASSWORD2 
fi
