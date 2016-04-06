#!/bin/bash

echo -e -n "2 versions sont disponnibles : [\033[36mMac/Linux -> (m)\033[0m] & [\033[32mWindows -> (w)\033[0m] :"
read TYPE
TYPE=${TYPE:-win}

if [ "$TYPE" = "w" ]
then
	mv MediaDev-Start.sh patch/MediaDev-Start-OLD.sh
	rm MediaDev-Start.sh
	path=`echo "$0" | sed -e "s/[^\/]*$//"`
	curl.exe -o MediaDev-Start.sh "http://vps241658.ovh.net/script/MediaDev-Start.sh"
	chmod 777 MediaDev-Start.sh
	echo "----------------------------------------------------------------------------"
	echo -e "------ Launcher : [\033[36mOK\033[0m]"
	echo ""
	echo ""

	curl.exe -o maj/maj_windows.sh "http://vps241658.ovh.net/script/patch/maj_windows.sh"
	curl.exe -o maj/maj_mac.sh "http://vps241658.ovh.net/script/patch/maj_mac.sh"
	echo "----------------------------------------------------------------------------"
	echo -e "------ Config : [\033[36mOK\033[0m]"
	echo ""
	echo ""

	mv tools/GitLab-Save.sh patch/GitLab-Save-OLD.sh
	rm tools/GitLab-Save.sh
	curl.exe -o tools/GitLab-Save.sh "http://vps241658.ovh.net/script/tools/GitLab-Save.sh"
	chmod 777 tools/GitLab-Save.sh
	echo "----------------------------------------------------------------------------"
	echo -e "------ Core : [\033[36mOK\033[0m]"
	echo ""
	echo ""
fi
if [ "$TYPE" = "m" ]
then
	mv MediaDev-Start.sh maj/MediaDev-Start-OLD.sh
	rm MediaDev-Start.sh
	rm GitLab-Start.sh
	rm -R maj
	curl -o MediaDev-Start.sh "http://vps241658.ovh.net/script/MediaDev-Start.sh"
	chmod 777 MediaDev-Start.sh
	echo "----------------------------------------------------------------------------"
	echo -e "------ Launcher : [\033[36mOK\033[0m]"
	echo ""
	echo ""

	curl -o maj/maj_windows.sh "http://vps241658.ovh.net/script/patch/maj_windows.sh"
	curl -o maj/maj_mac.sh "http://vps241658.ovh.net/script/patch/maj_mac.sh"
	echo "----------------------------------------------------------------------------"
	echo -e "------ Config : [\033[36mOK\033[0m]"
	echo ""
	echo ""

	mv tools/GitLab-Save.sh patch/GitLab-Save-OLD.sh
	rm tools/GitLab-Save.sh
	curl -o tools/GitLab-Save.sh "http://vps241658.ovh.net/script/tools/GitLab-Save.sh"
	chmod 777 tools/GitLab-Save.sh
	echo "----------------------------------------------------------------------------"
	echo -e "------ Core : [\033[36mOK\033[0m]"
	echo ""
	echo ""

    echo -e -n "Télécharger d'autres Outils [\033[36mSqlMap\033[0m] & [\033[32mCupp\033[0m] :"
    read TOOLS

    if ["$TOOLS" = "y"]
    then
        git clone https://github.com/sqlmapproject/sqlmap.git tools/sqlmap/
        mv tools/sqlmap/start.sh patch/start-SQLMAP.sh
        rm tools/sqlmap/start.sh
        curl -o tools/sqlmap/start.sh "http://vps241658.ovh.net/script/tools/start-SQLMAP.sh"
        chmod 777 tools/sqlmap/start.sh
        echo "----------------------------------------------------------------------------"
        echo -e "------ Tool -> SqlMap : [\033[36mOK\033[0m]"
        echo ""
        echo ""


        git clone https://github.com/Mebus/cupp.git tools/cupp
        echo "----------------------------------------------------------------------------"
        echo -e "------ Tool -> Cupp : [\033[36mOK\033[0m]"
        echo ""
        echo ""
	fi


fi