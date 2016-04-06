#!/bin/bash

# Author:Mediashare - Marquand Thibault
# Site:Mediashare.fr

# Prérequis :
#   - Curl
#   - Git
#   - Compte GitLab

# Utilisation :
#   - Lancer ./GitLab-Start.sh
#   - Si besoin, faite l'installation ou la mise à jour sur le système d'exploitation que vous souhaitez.
#   - Vous pouvez attendre qu'on vous propose de lancer le script de sauvegarde ou directement avec ./GitLab-Save.sh
#   - Une fois dans le service de sauvergarde, vous avec plusieurs options :
#       - Init (i) : Initialisation du projet, vous devez créer un répertoire sur GitLab afin de stocker la sauvegarde.
#       - Push (p) : Mettre à jour votre sauvegarde sur GitLab.
#       - Clone (c) : Après une Initialisation, récupère une copie des fichiers sauvegardés.
#       - Steal (s) : Suspect.

# Patch Note 1.7 :
#   - 1.7.6 :
#       - Optimisation Mise à jour Windows.
#   - 1.7.5 :
#       - Ajout du système de Mise à jour.
#       - Sortie Public.
#

now="$(date +%Y-%m-%d)"
#printf "%s\n" "$now"
NOW=$now
#VERSION="1.7.3 - $(echo $now)"
VERSION="1.7.6"

echo ""
echo "----------------------------------------------------------------------------"
echo -e "------ Service Mise à Jour GitLab-Save de [\033[32mMediashare.fr\033[0m]"
echo -e "------ [\033[36mVersion : $VERSION\033[0m]"
echo "----------------------------------------------------------------------------"
echo ""
echo ""
echo ""

echo -e -n "Voulez-vous faire une mise à jour ou une installation ? [\033[32mYes(y)/No(n)\033[0m] :"
read MAJ
MAJ=${MAJ:-y}

if [ "$MAJ" = "y" ]
then
    mkdir maj
	curl -o maj/MàJ.sh "http://vps241658.ovh.net/script/patch/MàJ.sh"
	curl.exe -o maj/MàJ.sh "http://vps241658.ovh.net/script/patch/M%C3%A0J.sh"
	chmod 777 maj/MàJ.sh
	echo ""
    bash maj/MàJ.sh
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
