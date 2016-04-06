#!/bin/sh

#Author:Mediashare
#Site:Mediashare.fr

# remgit.sh
# Creates a remote git repository from the current local directory

# Configuration
# Replace SSH_USERNAME, SSH_HOST, SSH_GIT_PATH with your details


echo "----------------------------------------------------------------------------"
echo "------ Service BackUp [\033[32mMediashare.fr\033[0m]"
echo "------ Création de dossier de sauvegarge sur [\033[36mVPS\033[0m]/[\033[35mGithub\033[0m]"
echo "----------------------------------------------------------------------------"
echo "------ Renseigner les informations demandés lié à votre compte [\033[36mVPS\033[0m]"
echo "----------------------------------------------------------------------------"

#RENSEINGNEMENT SERVEUR
echo "Votre Compte [\033[36m'Utilisateur'\033[0m] du serveur :"
read USER
#USER=root
echo "Vous serez connecté avec -> [\033[36m'$USER'\033[0m]"
#echo -n "Serveur :"
#read HOST
HOST=vps241658.ovh.net
echo "Serveur de sauvegarge -> [\033[36m'$HOST'\033[0m]"

REPO=${PWD##*/}

GIT_REMOTE_URL=ssh:/$USER@$HOST/$GIT_PATH/$REPO
GIT_PATH=/home/BackUp

now="$(date)"
#printf "%s\n" "$now"

NOW=$(echo $now|sed s/' '/'\-'/g)

echo "---------------------------------------------------------"
echo "------ Sauvegarde sur [\033[35mGithub\033[0m]"
echo "---------------------------------------------------------"


echo "Entrer le nom de votre compte [\033[35mGithub\033[0m] :"
read COMPTE
echo "Entrer le nom du Repository de [\033[35m'$COMPTE'\033[0m] Si celui-ci est une nouvelle sauvegarde à part:"
read PROJET
ADRESS="https://github.com/"$COMPTE"/"$PROJET".git"

echo "Vous serez connecté avec -> Compte: [\033[35m'$COMPTE'\033[0m] -> Repository: [\033[35m'$PROJET'\033[0m] "

# Configure local repo

echo "--"
echo "-- Récupération des fichiers + Envoi vers => [\033[37m' $ADRESS '\033[0m]"
echo "--"

echo "Ajouté un [\033[37m'commentaire'\033[0m] au commit :"
read COMMENTAIRE
echo "Ok [\033[37m'$COMMENTAIRE'\033[0m]"

git init
git add .
#git config --global push.default simple
git commit -m "'$now' - '$COMMENTAIRE' "
if [ "$PROJET" ]
	then
		ADDRESS="https://gitlab.com/"$COMPTE"/"$PROJET".git"
		git push --set-upstream $ADRESS master
	else
		git push --force
	fi
git merge master


echo "--"
echo "-- L'url du repository -> [\033[37m' $ADRESS '\033[0m]"
echo "--"
# Setup remote repo

echo "---------------------------------------------------------"
echo "------ Sauvegarde sur [\033[36mVPS\033[0m]"
echo "---------------------------------------------------------"

echo "--"
echo "-- Création de votre BackUp sur le serveur"
echo "-- [\033[37m$USER@$HOST$GIT_PATH$PROJET/$NOW\033[0m]"
echo "--"


ssh $USER@$HOST 'mkdir '$GIT_PATH' ; mkdir '$GIT_PATH'/'$PROJET' ; mkdir '$GIT_PATH'/'$PROJET'/'$NOW' ; cd '$GIT_PATH'/'$PROJET'/'$NOW' && git init && git pull '$ADRESS



echo "--"
echo "-- Your new git repo '$REPO' is ready and initialized at:"
echo "-- $USER@$HOST/$GIT_PATH/$PROJET/$NOW"
echo "--"
echo "[\033[32mok\033[0m]"

read