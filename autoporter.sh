#!/bin/bash
if [[ "$EUID" -ne 0 ]]; then
	echo "Sorry, you need to run this as root"
	exit 2
fi
if readlink /proc/$$/exe | grep -qs "dash"; then
	echo "This script needs to be run with bash, not sh"
	exit 1
fi

echo -e "AUTOPORTER 0.1 MT6580\nCREDITS: LHSouls\n1) DOWNLOAD SOURCES\n2) AUTOPORT 3.10.72\n3) CLEAR DIRECTORIES\n4) EXIT"
read -p "WRITE A NUMBER: (1-4) " option
    case $option in
        1)
        if [[ -e /usr/bin/git ]]; then
        clear
            echo "git ok"
            else 
            apt-get install git -y
        fi
        if [[ -e ~/autoporter/mkbootimg_tools ]]; then
        echo "mkboot ok"
        else
        mkdir autoporter
        cd autoporter
        wget 
        chmod 777 autoporter
        git clone https://github.com/xiaolu/mkbootimg_tools
        fi
        if [[ -e /usr/bin/unzip ]]; then
        echo "unzip ok"
        else
        apt install unzip
        fi
          if [[ -e /usr/bin/zip ]]; then
    echo "zip ok"
    sleep 3s 
    clear
    else
    apt-get install zip
    fi
    clear
    read -p "Want to download your rom directly from wget? [Yes or no ]" resp
    if [[ $resp = yes ]]; then
    read -p "What is the rom link you want to download? only works with dropbox link or direct links " link
    wget $link -O ~/autoporter/port/rom.zip
    clear
    echo "OK downloaded ROM"
    sleep 4s
    clear
    else 
    clear
    echo "Okay, we will not download "
    sleep 2s
    clear
    fi
        if [[ ~/autoporter/autoporter.sh ]]; then
        bash ~/autoporter/autoporter.sh
    else
        wget
        chmod 777 autoporter
         bash ~/autoporter/autoporter.sh
    fi
        ;;
        2)
        echo ""
        echo "preparing.."
        sleep 2s 
    if [[ -e ~/autoporter/ ]]; then
        echo "ok"
    else
     mkdir ~/autoporter/
    fi
    if [[ -e ~/autoporter/stock ]]; then
        echo "paste stock ok"
    else
    mkdir ~/autoporter/stock
    chmod 777 ~/autoporter/stock
    fi
    if [[ -e ~/autoporter/port ]]; then
    echo "paste port ok"
    read -n 1 -s -p "Move the files and press any key to continue.." ; echo "" ; echo "" 
    else 
    mkdir ~/autoporter/port
    chmod 777 
    fi
    if [[ ~/autoporter/port/*.zip ]]; then
     echo "ok unziping.."
    sleep 3s
    cd ~/autoporter/port
    unzip ~/autoporter/port/*.zip 
    rm ~/autoporter/port/*.zip
    fi
    echo ""
    echo "copying files.."
    sleep 3s
    cp -r ~/autoporter/stock/system/* ~/autoporter/port/system
    cp -r ~/autoporter/port/boot.img ~/autoporter/mkbootimg_tools
    cd ~/autoporter/mkbootimg_tools
    bash mkboot boot.img boot
    cp -r ~/autoporter/stock/boot.img ~/autoporter/mkbootimg_tools
    cd ~/autoporter/mkbootimg_tools
    bash mkboot boot.img boot2
    cp -r ~/autoporter/mkbootimg_tools/boot2/kernel ~/autoporter/mkbootimg_tools/boot/kernel
    bash mkboot boot newboot.img
    cp ~/autoporter/mkbootimg_tools/newboot.img  ~/autoporter/port/boot.img
     read -n 1 -s -p "modify the build.prop manually and press any key to continue.." ; echo "" ; echo ""
     read -p "What is the name of the ROM? " rom
     if [[ -e ~/autoporter/out  ]]; then
     chmod 777 ~/autoporter/out
     cd ~/autoporter/port/
     zip -r ~/autoporter/out/Autoport_$rom.zip *
     else
     mkdir ~/autoporter/out
     chmod 777 ~/autoporter/out
     cd ~/autoporter/port/
     zip -r ~/autoporter/out/Autoport_$rom.zip *
     fi
     clear
     echo ""
     echo "ROM AVALIABLE IN ~/autoporter/out/Autoport_$rom.zip "
     echo ""
     sleep 5s
     clear
bash ~/autoporter/autoporter.sh
        ;;
        3)
        clear
        echo ""
        echo " removing files for the next installation..."
        sleep 3s 
        rm -rf ~/autoporter/port/*
        rm -rf ~/autoporter/mkbootimg_tools/boot
        rm -rf ~/autoporter/mkbootimg_tools/boot2
        rm -rf ~/autoporter/mkbootimg_tools/boot.img
        clear
        if [[ -e ~/autoporter/autoporter.sh ]]; then
    bash ~/autoporter/autoporter.sh
    else
    wget
    chmod 777 autoporter
    bash ~/autoporter/autoporter.sh
    fi
        ;;
        4)
        clear
        echo "Exiting..."
        sleep 3s
        exit
        
        ;;
esac
 exit