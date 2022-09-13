#!/bin/bash
network_config="/etc/sysconfig/network-scripts/ifcfg-ens33"
MAC=`cat /sys/class/net/ens33/address`
NAME=$1
IP=$2

if [ $# -eq 2 ]
then
  sudo sed -i "/HWADDR/c\HWADDR=\"$MAC\"" $network_config
  sudo sed -i "/IPADDR/c\IPADDR=$IP" $network_config
  sudo sed -i "/BOOTPROTO/c\BOOTPROTO=none" $network_config
  sudo sed -i "/ONBOOT/c\ONBOOT=yes" $network_config

  sudo sed -i 'd' /etc/hostname
  echo "$NAME" |sudo tee /etc/hostname
  sudo hostnamectl set-hostname "$NAME"
else
  echo "Usage: ./updateNetworkConfig.sh <New-Hostname> <New-IP>"
fi