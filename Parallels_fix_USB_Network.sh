#!/bin/sh

MKC_txt() {
	printf "\033[1;32m$@\033[0m\n"
}

PARALLELS_DIR="/Library/Preferences/Parallels"  # Путь к папке в которой хранятся нужные конфиги

################################################################################################

usb_fix() {
MKC_txt
  MKC_txt " >> USB FIX"
    grep -rl 'Usb>0' $PARALLELS_DIR/dispatcher.desktop.xml | xargs perl -p -i -e 's/Usb>0/Usb>1/g'
    sleep 1
  MKC_txt " << "
MKC_txt
menu
}

network_fix() {
MKC_txt
  MKC_txt " >> Network FIX"
    MKC_txt " >> Try search and replace: UseKextless>-1"
      grep -rl 'UseKextless>-1' $PARALLELS_DIR/network.desktop.xml | xargs perl -p -i -e 's/UseKextless>-1/UseKextless>0/g'
    MKC_txt " >> Try search and replace: UseKextless>1"
      grep -rl 'UseKextless>1' $PARALLELS_DIR/network.desktop.xml | xargs perl -p -i -e 's/UseKextless>1/UseKextless>0/g'
  sleep 2
  MKC_txt " << "
MKC_txt
menu
}

################################################################################################

menu() {
clear
MKC_txt "Menu:"
	MKC_txt
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

start() {
  if [ "$(id -u)" -ne 0 ]; then
    clear; MKC_txt "You are not a root | Вы не root"; else clear
    MKC_txt "Запустить скрипт для исправления Сети или USB в Parallels Desktop v.16?"
    MKC_txt "Run the script for fix the Network or USB in Parallels Desktop v.16?"
    MKC_txt
      MKC_txt " - 1 - ДА – YES ✔"
      MKC_txt " - 0 - НЕT – NO ✔"
    MKC_txt
		read -p "...: " case
    case $case in
      1) menu;;
      0) exit;;
    esac;
  fi
}

start
