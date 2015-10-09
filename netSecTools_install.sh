#!/bin/bash
##############################################
#Author: Ivan Diaz
#Date: 4/1/2015
#Description: A bash script to see if certain security/crypto programs are installed. If not, install them. Requires user to input sudo
###############################################

echo "Remember this script will install essential netSec tools. Thus sudo will be used for the installation. Missing something on list? Report on Github!"
echo ""
echo "This SCRIPT WILL START IN THE HOME DIRECTORY!"

#SUPA DUPA COOL PH DESIGN
echo "=======================================================
               /////      //
               //  /      //         
               ////       //
               //         //////
               //         //   //
               //         //   //
======================================================="

#To make sure the user is in their $HOME path during execution
cd $HOME

while true; do
    read -p "Ready to take the Red pill?" yn
    case $yn in
	      [Yy]* ) break;;#sudo apt-get update; break;;
	      [Nn]* ) echo "Run me again when your ready"; exit;;
	      * ) echo "Its a Yes or no.";
    esac
done
echo "First thing, let's figure out the package manager"
echo ""

function checkPkgMngr(){

    #the -z parameter in bash checks to see if the given commands returns
    #if the string length equals zero. the ! will give it a true condition for if we the string returned > 0.
    if [[ ! -z $(which apt) ]]; then
	      pkgMngr="apt"
	      pkgUpdate="sudo apt-get -y update"
	      pkgInstall="sudo apt-get -y install"

    elif [[ ! -z $(which pacman) ]]; then
	      pkgMngr="pacman"
	      pkgUpdate="sudo pacman -Syu"
	      pkgInstall="sudo pacman -S"
	      
    elif [[! -z $(which yum) ]]; then
	      pkgMngr="yum"
	      pkgUpdate="yum update -y"
	      pkgInstall="yum install -y"

    fi
}

checkPkgMngr;   

echo ""
echo "You use $pkgMngr"
echo ""
echo "Ok now to get the stuff onto your computer"
echo ""
echo "Let's update first"

$(echo $pkgUpdate)

##############################################
#Lets do an Anon (optional) package prompt, if yes we will install some anon stuff
#If no, then go on with netSec tools as normal
##############################################

function anonCheck(){

    tools=('torBrowser' 'i2p' 'jitsi')
    for i in "${tools[@]}"
    do
        temp=$(echo $i)
        echo "Let's see if you got $temp"
        if [ "$temp" == "torBrowser" ]; then #first check to see if TOR browser string

            if [[ -n $(find $HOME -name "start-tor-browser")  ]]; then
                echo "TOR browser bundle exists"
            else
                echo "you don't have tor. It's essential for privacy. Remove if you wish"
                wget https://dist.torproject.org/torbrowser/5.0.3/tor-browser-linux64-5.0.3_en-US.tar.xz;
                tar xvf tor-browser-linux64-5.0.3_en-US.tar.xz;
	              torFolder=$HOME/tor-browser_en-US/
	              echo "Tor is Now setup in $torFolder"
	              echo ""
            fi
        elif [ "$temp" == "i2p" ]; then
            #check for i2p specific
            if [[ -n $(find $HOME -name "*i2p*") ]]; then
                echo "$temp Exist"
            else
                echo "Didn't find $temp on the system. Time to install"
                $(echo $pkgInstall) $temp
                tempPATH=$(which $temp)
                echo "$temp was installed in $tempPATH"
                echo ""
            fi
        else
            #Check for the other tools that aren't i2p or tor
            if type $temp 2>/dev/null > /dev/null; then
                echo "it exists"
            else
                echo "Didn't find $temp on system. Time to install"
                $(echo $pkgInstall) $temp
                tempPATH=$(which $temp)
                echo "$temp was installed in $tempPATH"
                echo  ""
            fi
        fi
    done
    
}
#########################################
function toolCheck(){
    tools=('nmap' 'netcat' 'firefox' 'gpg' 'wireshark' 'tshark')
    for i in "${tools[@]}"
    do
        temp=$(echo $i)
        echo "Lets see if you got $temp"
        if type $temp 2>/dev/null > /dev/null; then
            echo "it exists"
        else
            "Didn't find $temp on system. Time to install"
            $(echo $pkgInstall) $temp
            tempPATH=$(which $temp)
            echo "$temp was installed in $tempPATH"
            echo  ""
        fi
    done

}
#################################
echo "Let us begin"
#anonCheck;
#Loop to trigger the optional anon install
while true; do
    read -p "Want to have anonymity tools as well[y/n] " yn
    case $yn in
	      [Yy]* ) anonCheck;break;;
	      [Nn]* ) echo "Ok continuining the rest of the setup"; break;;
	      * ) echo "Its a Yes or no.";
    esac
done
toolCheck; #primary function to install all basic tools
echo "All Done. Welcome aboard."
