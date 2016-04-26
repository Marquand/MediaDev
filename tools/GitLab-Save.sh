#!/bin/bash

# Author:Mediashare
# Site:Mediashare.fr

# remgit.sh
# Creates a remote git repository from the current local directory

# Configuration
# Replace SSH_USERNAME, SSH_HOST, SSH_GIT_PATH with your details

echo ""
echo "----------------------------------------------------------------------------"
echo -e "------ Service BackUp GitLab [\033[32mMediashare.fr\033[0m]"
echo -e "------ Création de dossier de sauvegarge sur [\033[36mGitLab\033[0m]"
echo "----------------------------------------------------------------------------"

now="$(date)"
#printf "%s\n" "$now"
NOW=$(echo $now|sed s/' '/'\-'/g)

echo -e -n "Entrer la [\033[36mFonction\033[0m] voulu [\033[32mPush -> (p)\033[0m]/[\033[35mInit -> (i)\033[0m]/[\033[34mClone -> (c)\033[0m]/[\033[33mSteal -> (s)\033[0m] :"
read FUNCTION
FUNCTION=${FUNCTION:-p}

if [ "$FUNCTION" = "p" ]
then
	echo "----------------------------------------------------------------------------"
	echo -e "------ Utilisation du service [\033[32mPush\033[0m]"
	echo "----------------------------------------------------------------------------"
	echo -e "------ [\033[32mConfiguration\033[0m]"
	echo "----------------------------------------------------------------------------"

	echo -e -n "Entrer le nom de votre compte [\033[36mGitLab\033[0m] {Point-Web}:"
	read COMPTE
	COMPTE=${COMPTE:-point-web}
	echo -e -n "Entrer le nom du Repository du compte [\033[35m'$COMPTE'\033[0m] dans le qu'elle vous souhaitez faire une sauvegarge :"
	read PROJET
	
	ADDRESS="https://gitlab.com/"$COMPTE"/"$PROJET".git"

	echo -e "Vous serez connecté avec -> Compte: [\033[35m'$COMPTE'\033[0m]"
	echo -e "Placer dans le répertoire -> Repository: [\033[35m'$PROJET'\033[0m]"

	# Configure local repo

	echo "----------------------------------------------------------------------------"
	echo -e "Récupération des fichiers + Envoi vers => [\033[31m' $ADDRESS '\033[0m]"
	echo "----------------------------------------------------------------------------"

	echo -e -n "Ajouté un [\033[33m'commentaire'\033[0m] au commit :"
	read COMMENTAIRE
	echo -e "Ok [\033[33m'$COMMENTAIRE'\033[0m]"

	echo -e -n "Préciser une [\033[33m'branche'\033[0m] {Master} :"
	read BRANCH

	git add .
	git add -u
	git add -A
	git commit -m "'$COMMENTAIRE' - '$now' "
	if [ "$PROJET" ]
	then
		ADDRESS="https://gitlab.com/"$COMPTE"/"$PROJET".git"
		if [ "$BRANCH" ]
		then
			git push $ADDRESS $BRANCH --force
		else
			git push $ADDRESS --force
		fi
	else
		if [ "$BRANCH" ]
		then
			git push $BRANCH --force
		else
			git push --force
		fi
	fi


	echo "----------------------------------------------------------------------------"
	echo -e "-- Fin du [\033[32mPush\033[0m]"
	echo "----------------------------------------------------------------------------"
	echo -e "[\033[32mok\033[0m]"
	read
fi


if [ "$FUNCTION" = "i" ]
then
	echo "----------------------------------------------------------------------------"
	echo -e "------ Utilisation du service [\033[35mInit\033[0m]"
	echo "----------------------------------------------------------------------------"
	echo -e "------ [\033[32mConfiguration\033[0m]"
	echo "----------------------------------------------------------------------------"


	    git init


	echo "----------------------------------------------------------------------------"
	echo -e "-- Fin du [\033[35mInit\033[0m]"
	echo "----------------------------------------------------------------------------"
	echo -e "[\033[32mok\033[0m]"
	read
fi



if [ "$FUNCTION" = "c" ]
then
	echo "----------------------------------------------------------------------------"
	echo -e "------ Utilisation du service [\033[34mClone\033[0m]"
	echo "----------------------------------------------------------------------------"
	echo -e "------ [\033[32mConfiguration\033[0m]"
	echo "----------------------------------------------------------------------------"

	echo -e -n "Entrer le nom de votre compte [\033[36mGitLab\033[0m] {Point-Web}:"
	read COMPTE
	COMPTE=${COMPTE:-point-web}
	echo -e -n "Entrer le nom du Repository du compte [\033[35m'$COMPTE'\033[0m] dans le qu'elle vous souhaitez faire une sauvegarge :"
	read PROJET
	
	ADDRESS="https://gitlab.com/"$COMPTE"/"$PROJET".git"

	echo -e "Vous serez connecté avec -> Compte: [\033[35m'$COMPTE'\033[0m]"
	echo -e "Placer dans le répertoire -> Repository: [\033[35m'$PROJET'\033[0m]"

	# Configure local repo

	echo "----------------------------------------------------------------------------"
	echo -e "Récupération des fichiers + Envoi vers => [\033[31m' $ADDRESS '\033[0m]"
	echo "----------------------------------------------------------------------------"


		git clone $ADDRESS 


	echo "----------------------------------------------------------------------------"
	echo -e "-- Fin du [\033[34mClone\033[0m]"
	echo "----------------------------------------------------------------------------"
	echo -e "[\033[32mok\033[0m]"
	read
fi


if [ "$FUNCTION" = "s" ]
then
	echo "----------------------------------------------------------------------------"
	echo -e "------ Utilisation du service [\033[33mSteal\033[0m]"
	echo "----------------------------------------------------------------------------"
	echo -e "------ [\033[32mConfiguration\033[0m]"
	echo "----------------------------------------------------------------------------"

	

	echo -e "Vous serez connecté avec -> Compte: [\033[35m'$COMPTE'\033[0m] -> Repository: [\033[35m'$PROJET'\033[0m] "

	# Configure local repo

	echo "--"
	echo -e "-- Récupération des fichiers + Envoi vers => [\033[31m' $ADDRESS '\033[0m]"
	echo "--"

	git init
	git add .
	git add -u
	git add -A
	git commit -m "'$now'"
	git push $ADDRESS --force


	echo "----------------------------------------------------------------------------"
	echo -e "Fin du service [\033[33mSteal\033[0m]"
	echo "----------------------------------------------------------------------------"
	echo -e "[\033[32mok\033[0m]"
	read
fi

echo "----------------------------------------------------------------------------"
echo -e "-- [\033[32m Fin du Programme \033[0m]"
echo "----------------------------------------------------------------------------"

read