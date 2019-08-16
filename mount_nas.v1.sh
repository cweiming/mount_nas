#!/bin/sh

# @date  : 2013/02/15
# @author: Wei-Ming chen, PhD
# @usage : sh mount_nas.sh

echo -e "type #bash mount_nas.sh\n"

unset IP
unset NASUSER
unset NASPWD
unset NASDIR
unset LINUXUSER
unset LINUXUSERHOME

echo -n "NAS IP: (e.g. //140.xx.xx.xx/home):"
read IP

echo -n "NAS Username:"
read NASUSER

prompt="NAS Password:"
while IFS= read -p "$prompt" -r -s -n 1 char;do
  if [[ $char == $'\0' ]]; then
    break
  fi
  prompt='*'
  NASPWD+="$char"
done

echo -ne "\nLinux UserName:"
read LINUXUSER

echo -ne "Linux UserHome:"
read LINUXUSERHOME

echo -ne "Create a directory in $LINUXUSERHOME so as to mount the NAS:"
read NASDIR
mkdir -p $LINUXSERHOME/$NASDIR >/dev/null 2>&1


sudo mount -t cifs -o defaults,username=$NASUSER,passwd=$NASPWD,gid=bioinfo,uid=$(id -u $LINUXUSER) $IP $LINUXUSERHOME/$NASDIR
