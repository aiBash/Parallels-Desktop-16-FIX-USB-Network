#!/bin/sh

MKC_txt() {
	printf "\033[1;32m$@\033[0m\n"
}

PARALLELS_DIR="/Library/Preferences/Parallels"  # Путь к папке в которой хранятся нужные конфиги

################################################################################################

usb_fix() {
MKC_txt
  MKC_txt " >> USB FIX"
    sudo grep -rl 'Usb>0' $PARALLELS_DIR/dispatcher.desktop.xml | xargs perl -p -i -e 's/Usb>0/Usb>1/g'
  MKC_txt "$(tput setaf 1) << USB FIX = DONE"
MKC_txt
menu
}

network_fix() {
MKC_txt
  MKC_txt " >> Network FIX"
    MKC_txt " >> Try search and replace: UseKextless>-1"
      sudo grep -rl 'UseKextless>-1' $PARALLELS_DIR/network.desktop.xml | xargs perl -p -i -e 's/UseKextless>-1/UseKextless>0/g'
    MKC_txt " >> Try search and replace: UseKextless>1"
      sudo grep -rl 'UseKextless>1' $PARALLELS_DIR/network.desktop.xml | xargs perl -p -i -e 's/UseKextless>1/UseKextless>0/g'
  MKC_txt "$(tput setaf 1) << Network FIX = DONE"
MKC_txt
menu
}

################################################################################################

menu() {
MKC_txt "$(tput setaf 1)########################################################"
MKC_txt "Menu:"
	MKC_txt " - 1 – FIX USB"
  MKC_txt " - 2 – FIX Network"
MKC_txt
	MKC_txt " - 0 – Exit"
MKC_txt
read -p "...: " case
case $case in
	1) usb_fix;;
	2) network_fix;;
	0) exit;;
esac
}

menu