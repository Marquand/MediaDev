    mv GitLab-Start.sh maj/GitLab-Start-OLD.sh
	rm GitLab-Start.sh
	curl -o GitLab-Start.sh "http://vps241658.ovh.net/script/GitLab-Start.sh"
	chmod 777 GitLab-Start.sh
	echo "----------------------------------------------------------------------------"
	echo -e "------ Launcher : [\033[36mOK\033[0m]"
	echo ""
	echo ""

	curl -o maj/maj_windows.sh "http://vps241658.ovh.net/script/maj_windows.sh"
	curl -o maj/maj_mac.sh "http://vps241658.ovh.net/script/maj_mac.sh"
	echo "----------------------------------------------------------------------------"
	echo -e "------ Config : [\033[36mOK\033[0m]"
	echo ""
	echo ""

	mv GitLab-Save.sh maj/GitLab-Save-OLD.sh
	rm GitLab-Save.sh
	curl -o GitLab-Save.sh "http://vps241658.ovh.net/script/GitLab-Save.sh"
	chmod 777 GitLab-Save.sh
	echo "----------------------------------------------------------------------------"
	echo -e "------ Core : [\033[36mOK\033[0m]"
	echo ""
	echo ""