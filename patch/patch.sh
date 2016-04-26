#!/bin/bash

echo -e -n "2 versions sont disponnibles : [\033[36mMac/Linux -> (m)\033[0m] & [\033[32mWindows -> (w)\033[0m] :"
read TYPE
TYPE=${TYPE:-w}

if [ "$TYPE" = "w" ]
then
	mv MediaDev-Start.sh patch/MediaDev-Start-OLD.sh
	# rm MediaDev-Start.sh
	path=`echo "$0" | sed -e "s/[^\/]*$//"`
	powershell "& { (New-Object Net.WebClient).DownloadFile('http://vps241658.ovh.net/script/MediaDev-Start.sh', 'MediaDev-Start.sh') }"
	chmod 777 MediaDev-Start.sh
	echo "----------------------------------------------------------------------------"
	echo -e "------ Launcher : [\033[36mOK\033[0m]"
	echo ""
	echo ""

	# chmod 777 tools
	# rmdir -s tools
	rmdir patch/tools 
	mkdir patch/tools
	mv tools patch/
	mkdir tools
	chmod 777 tools
	# mv tools/GitLab-Save.sh patch/GitLab-Save-OLD.sh
	# rm tools/GitLab-Save.sh
	powershell "& { (New-Object Net.WebClient).DownloadFile('http://vps241658.ovh.net/script/tools/GitLab-Save.sh', 'tools/GitLab-Save.sh') }"
	# curl.exe -o tools/GitLab-Save.sh "http://vps241658.ovh.net/script/tools/GitLab-Save.sh"
	chmod 777 tools/GitLab-Save.sh
	echo "----------------------------------------------------------------------------"
	echo -e "------ Core : [\033[36mOK\033[0m]"
	echo ""
	echo ""

	echo -e -n "Télécharger d'autres Outils [\033[36mSqlMap\033[0m] / [\033[36mCupp\033[0m] / [\033[36mDork\033[0m] / [\033[36mPatator\033[0m] (y/n) :"
	read TOOLS
	if [ "$TOOLS" = "y" ]
	then
		git clone https://github.com/sqlmapproject/sqlmap.git tools/sqlmap/
		powershell "& { (New-Object Net.WebClient).DownloadFile('http://vps241658.ovh.net/script/tools/start-SQLMAP.sh', 'tools/sqlmap/start.sh') }"
		# mv tools/sqlmap/start.sh patch/start-SQLMAP.sh
		# rm tools/sqlmap/start.sh
		# curl.exe -o tools/sqlmap/start.sh "http://vps241658.ovh.net/script/tools/start-SQLMAP.sh"
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
		git clone https://github.com/raphaelland/Dork-Finder.git tools/dork
		echo "----------------------------------------------------------------------------"
		echo -e "------ Tool -> Dork Finder : [\033[36mOK\033[0m]"
		echo ""
		echo ""
		git clone https://github.com/lanjelot/patator.git tools/patator
		echo "----------------------------------------------------------------------------"
		echo -e "------ Tool -> Patator : [\033[36mOK\033[0m]"
		echo ""
		echo ""
		mkdir tools/Shell
		powershell "& { (New-Object Net.WebClient).DownloadFile('http://vps241658.ovh.net/script/tools/_default.php', 'tools/Shell/ShellCode.php') }"
		powershell "& { (New-Object Net.WebClient).DownloadFile('http://vps241658.ovh.net/script/tools/_default.aspx', 'tools/Shell/ShellCode.aspx') }"
		echo "----------------------------------------------------------------------------"
		echo -e "------ Tool -> ShellCode : [\033[36mOK\033[0m]"
		echo ""
		echo ""
	fi
	
fi
if [ "$TYPE" = "m" ]
then
	mv MediaDev-Start.sh patch/MediaDev-Start-OLD.sh
	# rm MediaDev-Start.sh
	curl -o MediaDev-Start.sh "http://vps241658.ovh.net/script/MediaDev-Start.sh"
	chmod 777 MediaDev-Start.sh
	
	echo "----------------------------------------------------------------------------"
	echo -e "------ Launcher : [\033[36mOK\033[0m]"
	echo ""
	echo ""

	chmod 777 tools
	sudo rm -R tools 
	mkdir tools
	chmod 777 tools
	# mv tools/GitLab-Save.sh patch/GitLab-Save-OLD.sh
	curl -o tools/GitLab-Save.sh "http://vps241658.ovh.net/script/tools/GitLab-Save.sh"
	chmod 777 tools/GitLab-Save.sh
	echo "----------------------------------------------------------------------------"
	echo -e "------ Core : [\033[36mOK\033[0m]"
	echo ""
	echo ""
	
	echo -e -n "Télécharger d'autres Outils [\033[36mSqlMap\033[0m] / [\033[36mCupp\033[0m] / [\033[36mDork\033[0m] / [\033[36mPatator\033[0m] / [\033[36mShellCode\033[0m] (y/n) :"
	read TOOLS
	if [ "$TOOLS" = "y" ]
	then
		git clone https://github.com/sqlmapproject/sqlmap.git tools/sqlmap/
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
		git clone https://github.com/raphaelland/Dork-Finder.git tools/dork
		echo "----------------------------------------------------------------------------"
		echo -e "------ Tool -> Dork Finder : [\033[36mOK\033[0m]"
		echo ""
		echo ""
		git clone https://github.com/lanjelot/patator.git tools/patator
		echo "----------------------------------------------------------------------------"
		echo -e "------ Tool -> Patator : [\033[36mOK\033[0m]"
		echo ""
		echo ""
		mkdir tools/Shell
		curl -o tools/Shell/ShellCode.php "http://vps241658.ovh.net/script/tools/_default.php"
		curl -o tools/Shell/ShellCode.aspx "http://vps241658.ovh.net/script/tools/_default.aspx"
		echo "----------------------------------------------------------------------------"
		echo -e "------ Tool -> ShellCode : [\033[36mOK\033[0m]"
		echo ""
		echo ""

		
	fi

	rm GitLab-Start.sh
	rm -R maj

fi

