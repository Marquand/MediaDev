#!/bin/bash

# Author:Mediashare
# Site:Mediashare.fr

# remgit.sh
# Creates a remote git repository from the current local directory

# Configuration
# Replace SSH_USERNAME, SSH_HOST, SSH_GIT_PATH with your details

now="$(date)"
#printf "%s\n" "$now"
NOW=$(echo $now|sed s/' '/'\-'/g)

VERSION=1.2

echo ""
echo "----------------------------------------------------------------------------"
echo -e "------ Service Mise à Jour GitLab-Save de [\033[32mMediashare.fr\033[0m]"
echo -e "------ [\033[36mVersion : $VERSION\033[0m]"
echo "----------------------------------------------------------------------------"
echo ""
echo ""
echo ""

echo -e -n "2 versions sont disponnibles : [\033[36mMac -> (mac)\033[0m] & [\033[32mWindows -> (win)\033[0m] :"
read TYPE
TYPE=${TYPE:-win}

if [ "$TYPE" = "win" ]
then
	mv GitLab-Start.sh GitLab-Start-OLD.sh
	path=`echo "$0" | sed -e "s/[^\/]*$//"`
	curl -o $path/maj_windows.sh "http://vps241658.ovh.net/script/GitLab-Save.sh"
fi
if [ "$TYPE" = "mac" ]
then

	mkdir maj
	
	mv GitLab-Start.sh maj/GitLab-Start-OLD.sh
	rm GitLab-Start.sh
	curl -o GitLab-Start.sh "http://vps241658.ovh.net/script/GitLab-Start.sh"
	chmod 777 GitLab-Start.sh	
	echo -e "------ Launcher : [\033[36mOK\033[0m]"
	echo ""
	echo ""

	curl -o maj/maj_windows.sh "http://vps241658.ovh.net/script/maj_windows.sh"
	curl -o maj/maj_mac.sh "http://vps241658.ovh.net/script/maj_mac.sh"
	echo -e "------ Config : [\033[36mOK\033[0m]"
	echo ""
	echo ""

	mv GitLab-Save.sh maj/GitLab-Save-OLD.sh
	rm GitLab-Save.sh
	curl -o GitLab-Save.sh "http://vps241658.ovh.net/script/GitLab-Save.sh"
	chmod 777 GitLab-Save.sh
	echo -e "------ Core : [\033[36mOK\033[0m]"
	echo ""
	echo ""
fi

echo -e -n "[\033[32mLancer GitLab-Save\033[0m] [\033[31mYes(y)/No(n)/Restart(r)\033[0m] :"
read START
if [ "$START" = "y" ]
then
	bash GitLab-Save.sh
fi
if [ "$START" = "r" ]
then
	bash GitLab-Start.sh 
fi
