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

# Patch Note 1.5 :
#   - 1.5 :
#       - Ajout de nouveau Outil
#   - 1.4.6 :
#       - Optimisation Mise à jour Windows.
#   - 1.4.5 :
#       - Ajout du système de Mise à jour.
#       - Sortie Public.
#

now="$(date +%Y-%m-%d)"
#printf "%s\n" "$now"
NOW=$now
#VERSION="1.4.3 - $(echo $now)"
VERSION="1.5.2"

echo ""
echo "----------------------------------------------------------------------------"
echo -e "------ Service Mise à Jour MediaDev-Start de [\033[32mMediashare.fr\033[0m]"
echo -e "------ [\033[36mVersion : $VERSION\033[0m]"
echo "----------------------------------------------------------------------------"
echo ""
echo ""
echo ""

echo -e -n "Voulez-vous faire une mise à jour ou une installation ? [\033[32mYes(y)/No(n)\033[0m] :"
read MAJ
MAJ=${MAJ:-n}

if [ "$MAJ" = "y" ]
then
    mkdir patch
    mkdir tools
    curl -o patch/patch.sh "http://vps241658.ovh.net/script/patch/patch.sh"
    powershell "& { (New-Object Net.WebClient).DownloadFile('http://vps241658.ovh.net/script/patch/patch.sh', 'patch/patch.sh') }"
    chmod 777 patch/patch.sh
    echo ""
    bash -e patch/patch.sh
fi

echo -e -n "[\033[32mLancer un Outil du pack MediaDev\033[0m] [\033[31mYes(y)/No(n)/Restart(r)\033[0m] :"
read START
START=${START:-y}

if [ "$START" = "y" ]
then
    echo -e -n "- \033[31mGitLab-Save\033[0m [\033[32mDefault\033[0m]   "
    echo ""
    echo -e -n "- \033[31mSQLmap\033[0m (détection de faille sql) [\033[32mSQL\033[0m]   "
    echo ""
    echo -e -n "- \033[31mBruteForce\033[0m [\033[32mBF\033[0m]   "
    echo ""
    echo -e -n "- \033[31mCupp\033[0m (Génération de Password) [\033[32mC\033[0m]   "
    echo ""
    echo -e -n "- \033[31mDork Finder\033[0m [\033[32mD\033[0m]   "
    echo ""
    echo -e -n "Selection de l'[\033[31mOutils\033[0m] MediaDev :"
    echo ""
    read TOOLS
    TOOLS=${TOOLS:-Default}
    
    if [ "$TOOLS" = "Default" ]
    then
        bash tools/GitLab-Save.sh
    fi

    if [ "$TOOLS" = "SQL" ]
    then
        chmod 777 tools/
        bash tools/sqlmap/start.sh
    fi

    if [ "$TOOLS" = "C" ]
    then
        chmod 777 tools/
        cd tools/cupp/
        echo -e -n "Donner des [\033[31mMots-Clés\033[0m] pour générer des password :"
        python cupp.py -i
    fi

    if [ "$TOOLS" = "BF" ]
    then
        chmod 777 tools/
        cd tools/patator/
        python patator.py
    fi

    if [ "$TOOLS" = "D" ]
    then
        chmod 777 tools/
        cd tools/dork
        python Dork\ Finder.py
    fi
fi
if [ "$START" = "r" ]
then
    bash MediaDev-Start.sh 
fi
