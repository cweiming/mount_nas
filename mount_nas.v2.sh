#!/bin/bash

# @date  : 2013/02/15
# @author: Wei-Ming chen, PhD
# @usage : sh mount_nas.sh

unset IP
unset NASUSER
unset NASPWD
unset NASDOM
unset TMPPW
unset NASDIR
unset LINUXUSER
unset LINUXUSERHOME

read -p "NAS IP: (e.g. //140.xx.xx.xx/home): " IP

read -p "NAS Username: " NASUSER

read -sp "NAS Password: " NASPWD
echo ""

read -p "NAS Domain: " NASDOM

TMPPW=`date +%s | sha256sum | base64 | head -c 32`
echo '' > /tmp/$TMPPW
echo "username=$NASUSER" >> /tmp/$TMPPW
echo "password=$NASPWD" >> /tmp/$TMPPW
echo "domain=$NASDOM" >> /tmp/$TMPPW

read -p "Linux UserName: " LINUXUSER

read -p "Linux UserHome: "  LINUXUSERHOME

read -p "Create a directory in $LINUXUSERHOME so as to mount the NAS: " NASDIR
mkdir -p $LINUXUSERHOME/$NASDIR > /dev/null 2>&1

sudo mount -t cifs $IP $LINUXUSERHOME/$NASDIR -o defaults,credentials=/tmp/$TMPPW,uid=$(id -u $LINUXUSER),gid=$(id -g $LINUXUSER),file_mode=0664,dir_mode=0775
rm -rf /tmp/$TMPPW
