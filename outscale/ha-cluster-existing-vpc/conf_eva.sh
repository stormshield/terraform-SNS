#!/bin/sh

SETCONF=/usr/Firewall/sbin/setconf
CF=/usr/Firewall/ConfigFiles
SBIN=/usr/Firewall/sbin
GLOBAL=/usr/Firewall/System/global

WANIP="${WANIP}"
SYNCIP="${SYNCIP}"
LANIP="${LANIP}"
MASK="${MASK}"
GW="${GWIP}"
PASSWORD="${PASSWORD}"

$SETCONF $CF/system Console State Serial
$SBIN/enconsole

$SBIN/fwpasswd -p $PASSWORD

# network

$SETCONF $CF/network ethernet0 Name wan
$SETCONF $CF/network ethernet0 Address $WANIP
$SETCONF $CF/network ethernet0 Mask $MASK

$SETCONF $CF/network ethernet1 Name sync
$SETCONF $CF/network ethernet1 Address $SYNCIP
$SETCONF $CF/network ethernet1 Mask $MASK

$SETCONF $CF/network ethernet2 Name lan
$SETCONF $CF/network ethernet2 Address $LANIP
$SETCONF $CF/network ethernet2 Mask $MASK

$SETCONF $CF/object Host gateway $GW
$SETCONF $CF/route Config DefaultRoute gateway

$SBIN/ennetwork

# SSH

$SETCONF $CF/system SSH State 1
$SETCONF $CF/system SSH Password 1
$SBIN/enservice

cat << EOFILTER > $CF/Filter/09
[Filter]
separator color="c0c0c0" comment="Administration" collapse="0"
pass from any on wan to Firewall_wan port ssh   # ssh on out
separator color="c0c0c0" comment="Lan to internet" collapse="0"
pass from network_lan to any    # lan to internet
separator color="c0c0c0" comment="Block all" collapse="0"
block from any to any

[NAT]
nat from Network_lan to internet on wan -> from Firewall_wan port ephemeral_fw to original
EOFILTER

enfilter 09

echo "Provisioning done!" >> /log/provisioning.log
