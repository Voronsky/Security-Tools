#!/bin/bash
##############################################
#Author: Ivan Diaz
#Date: 4/1/2015
#Description: A bash script to see if certain security/crypto programs are installed. If not, install them. Requires user to input sudo
###############################################

echo "Remember this script will install essential netSec tools. Thus sudo will be used for the installation. Missing something on list? Report on Github!"
echo ""
echo "This SCRIPT WILL START IN THE HOME DIRECTORY!"
echo ""

#SUPA DUPA COOL PH DESIGN
echo "=======================================================
               /////      //
               //  /      //         
               ////       //
               //         //////
               //         //   //
               //         //   //
======================================================="

#To , by default, make sure the user is in their $HOME path during execution
cd $HOME

while true; do
    read -p "Ready to take the Red pill?" yn
    case $yn in
	[Yy]* ) break;;#sudo apt-get update; break;;
	[Nn]* ) echo "Run me again when your ready"; exit;;
	* ) echo "Its a Yes or no.";
    esac
done
echo "First thing, let's figure out the distro"
echo ""


$(echo $pkgUpdate)

function checkDistro(){
    #Check the distro from the release files located normally in /etc/
    #awk -f means "check after the input parameter, so "=" in our case. Then print $NF means print after it
    #sed -n 1p means print output until certain lines are met. 1p means 1 line, 2p would be 2 lines, 3p be 3 lines etc
    distro=$(cat /etc/*-release | awk -F "=" '{print $NF}' | sed -n 1p)

    if echo $distro >/dev/null == "Ubuntu*" || echo $distro >/dev/null == "Debian*";
	then
	echo "It is $distro. We will use Apt-get"
	pkgUpdate="sudo apt-get update -y"
	pkgInstall="sudo apt-get install -y"
    elif $distro == "Arch*";
	then
	echo "It is Arch. We will use Pacman"
	pkgUpdate="sudo pacman -Syu"
	pkgInstall="sudo pacman -S"
    fi
}
checkDistro;   

echo ""
echo "Ok now to get the stuff onto your computer"
echo ""
echo "Let's update first"

##############################

function firefoxBrowser(){

    echo "Lets see if you got firefox"
    if type firefox 2>/dev/null > /dev/null; then
	echo "it exists"

    else 

	echo "Don't got firefox? Time to get it installed"
	$(echo $pkgInstall) firefox 
	firefoxPATH=$(which firefox)
	echo "Firefox was installed in $firefoxPATH"
	echo ""
    fi
}

###############################


function torBrowserCheck(){
    echo "Lets get some Anonyminity setup!"
    #the -n parameter tests for a non-empty string. Using this to test if find can find a file with this name anyhwere within the user's $HOME path
    if [[ -n $(find $HOME -name "start-tor-browser")  ]] 
    then
	echo "TOR browser bundle exists"

    else
	echo "you don't have tor. It's essential for privacy. Remove if you wish"

	wget https://www.torproject.org/dist/torbrowser/4.0.6/tor-browser-linux64-4.0.6_en-US.tar.xz;
	tar xvf tor-browser-linux64-4.0.6_en-US.tar.xz;
	torFolder=$HOME/tor-browser_en-US/
	echo "Tor is Now setup in $torFolder"
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
	$(echo $pkgInstall) aircrack-ng 
	aircrackPATH=$(which aircrack-ng)
	echo "Aircrack has been installed in  $aircrackPATH"
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
	$(echo $pkgInstall) nmap 
	nmapPATH=$(which nmap)
	echo "nmap has been installed in $nmapPATH"
	echo ""
    fi
}

#############################
function tsharkCheck(){
    echo "Do you have tshark?"
    if type tshark 2>/dev/null>/dev/null;
    then
	echo "it exists"
    else
	$(echo $pkgInstall) tshark 
	tsharkPATH=$(which tshark)
	echo "tshark has been installed in $tsharkPATH"
    fi
}

##############################
function wireSharkCheck(){
    echo "Do you got wireshark?"

    if type wireshark 2>/dev/null>/dev/null;
    then
	echo "it exists"
    else
	$(echo $pkgInstall) wireshark
	wireSharkPATH=$(which wireshark)
	echo "wireshark has been installed in $wireSharkPath"
    fi
}
#################################

function ncCheck(){
    echo "Netcat, let's check that"
    
    if type nc 2>/dev/null>/dev/null;
    then
	echo "it exits"
    else
	$(echo $pkgInstall) nc
	ncPATH=$(which nc)
	echo "nc has been installed in $ncPATH"
    fi

}

#################################

#################################
function callAllFunctions(){
    firefoxBrowser;
    aircrackngCheck;
    torBrowserCheck;
    nmapCheck;
    tsharkCheck;
    wireSharkCheck;
    ncCheck;
}

echo "Let us begin"

callAllFunctions;
echo ""
echo ""
echo "All Done. Welcome aboard."
