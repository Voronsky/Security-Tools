#!/bin/bash
##############################################
#Author: Ivan Diaz
#Date: 4/1/2015
#Description: A bash script to see if certain security/crypto programs are installed. If not, install them. Requires user to input sudo
###############################################
echo "Remember this script will install necessary tools. Thus sudo will be used"
echo ""
while true; do
    read -p "Ready to take the Red pill?" yn
    case $yn in
	[Yy]* ) break;;#sudo apt-get update; break;;
	[Nn]* ) echo "Run me again when your ready"; exit;;
	* ) echo "Its a Yes or no.";
    esac
done

echo "Ok now to get the stuff onto your computer"
    

##############################

function firefoxBrowser(){

    echo "Lets see if you got firefox"
    if type firefox 2>/dev/null > /dev/null; then
	echo "it exists"

    else 

	echo "Don't got firefox? Time to get it installed"
	sudo apt-get install firefox -y
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
    fi
}

#################################
function callAllFunctions(){
    firefoxBrowser;
    aircrackngCheck;
    torBrowserCheck;
}

callAllFunctions;
