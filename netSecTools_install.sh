#!/bin/bash
##############################################
#Author: Ivan Diaz
#Date: 4/1/2015
#Description: A bash script to see if certain security/crypto programs are installed. If not, install them. Requires user to input sudo
###############################################

echo "Remember this script will install essential netSec tools. Thus sudo will be used for the installation. Missing something on list? Report on Github!"
echo ""
while true; do
    read -p "Ready to take the Red pill?" yn
    case $yn in
	[Yy]* ) break;;#sudo apt-get update; break;;
	[Nn]* ) echo "Run me again when your ready"; exit;;
	* ) echo "Its a Yes or no.";
    esac
done
echo ""
echo "Ok now to get the stuff onto your computer"
echo ""

function checkDistro(){
    #Check the distro from the release files located normally in /etc/
    #awk -f means "check after the input parameter, so "=" in our case. Then print $NF means print after it
    #sed -n 1p means print output until certain lines are met. 1p means 1 line, 2p would be 2 lines, 3p be 3 lines etc
    distro=$(cat /etc/*-release | awk -F "=" '{print $NF}' | sed -n 1p)

    if echo $distro == "Ubuntu*" || $distro == "Debian*";
	then
	echo "It is $distro. We will use Apt-get"
	pkgUpdate=$(sudo apt-get update)
	pkgInstall=$(sudo apt-get install)
	fi
    if echo $distro == "Arch*";
	then
	echo "It is Arch. We will use Pacman"
	pkgUpdate=$(sudo pacman -Syu)
	pkgInstall=$(sudo pacman -S)
    fi
}
checkDistro;   

##############################

function firefoxBrowser(){

    echo "Lets see if you got firefox"
    if type firefox 2>/dev/null > /dev/null; then
	echo "it exists"

    else 

	echo "Don't got firefox? Time to get it installed"
	sudo apt-get install firefox -y
	firefoxPATH=$(which firefox)
	echo "Firefox was installed in "$firefoxPATH
	echo ""
    fi
}

###############################


function torBrowserCheck(){
    echo "Lets get some Anonyminity setup!"
    #the -n parameter tests for a non-empty string. Using this to test if find can find a file with this name anyhwere within the user's $HOME path
    if [[ -n $(find $HOME -name "start-tor-browser") ]] 
    then
	echo "TOR browser bundle exists"

    else
	echo "you don't have tor. It's essential for privacy. Remove if you wish"

	wget https://www.torproject.org/dist/torbrowser/4.0.6/tor-browser-linux64-4.0.6_en-US.tar.xz;
	tar xvf tor-browser-linux64-4.0.6_en-US.tar.xz;
	torFolder=$HOME/tor-browser_en-US/
	echo "Tor is Now setup in " $torFolder
	echo ""

    fi
}

#############################
function aircrackngCheck(){
    echo "Do you have aircrack-ng?"
    if type aircrack-ng 2>/dev/null > /dev/null;
    then
	echo "it exists"
    else
	sudo apt-get update -y
	sudo apt-get install aircrack-ng -y
	aircrackPATH=$(which aircrack-ng)
	echo "Aircrack has been installed in " $aircrackPATH
	echo ""
    fi
}

############################
function nmapCheck(){
    echo "Do you have nmap?"
    if type nmap 2>/dev/null>/dev/null;
    then
	echo "it exists"
    else
	sudo apt-get install nmap -y
	nmapPATH=$(which nmap)
	echo "nmap has been installed in" $nmapPATH
	echo ""
}

#############################
function tsharkCheck(){
    echo "Do you have tshark?"
    if type tshark 2>/dev/null/dev/null;
    then
	echo "it exists"
    else
	sudo apt-get install tshark -y
	tsharkPATH=$(which tshark)
	echo "tshark has been installed in "$tsharkPATH
}

##############################

#################################
function callAllFunctions(){
    firefoxBrowser;
    aircrackngCheck;
    torBrowserCheck;
    nmapCheck;
    tsharkCheck;
}

callAllFunctions;
