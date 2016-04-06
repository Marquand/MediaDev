#!/bin/bash

#Author:Mediashare
#Site:Mediashare.fr

# remgit.sh
# Creates a remote git repository from the current local directory

# Configuration
# Replace SSH_USERNAME, SSH_HOST, SSH_GIT_PATH with your details


echo "----------------------------------------------------------------------------"
echo -e "------ Service BackUp [\033[32mMediashare.fr\033[0m]"
echo -e "------ Création de dossier de sauvegarge sur [\033[36mVPS\033[0m]/[\033[35mGithub\033[0m]"
echo "----------------------------------------------------------------------------"
echo -e "------ Renseigner les informations demandés lié à votre compte [\033[36mVPS\033[0m]"
echo "----------------------------------------------------------------------------"

#RENSEINGNEMENT SERVEUR
echo -e -n "Votre Compte [\033[36m'Utilisateur'\033[0m] du serveur :"
read USER
#USER=root
echo -e "Vous serez connecté avec -> [\033[36m'$USER'\033[0m]"
#echo -n "Serveur :"
#read HOST
HOST=vps241658.ovh.net
echo -e "Serveur de sauvegarge -> [\033[36m'$HOST'\033[0m]"

REPO=${PWD##*/}

GIT_REMOTE_URL=ssh:/$USER@$HOST/$GIT_PATH/$REPO
GIT_PATH=/home/BackUp

now="$(date)"
#printf "%s\n" "$now"

NOW=$(echo $now|sed s/' '/'\-'/g)

echo "---------------------------------------------------------"
echo -e "------ Sauvegarde sur [\033[35mGithub\033[0m]"
echo "---------------------------------------------------------"


echo -e -n "Entrer le nom de votre compte [\033[35mGithub\033[0m] :"
read COMPTE
echo -e -n "Entrer le nom du Repository de [\033[35m'$COMPTE'\033[0m] Si celui-ci est une nouvelle sauvegarde à part:"
read PROJET
ADRESS="https://github.com/"$COMPTE"/"$PROJET".git"

echo -e "Vous serez connecté avec -> Compte: [\033[35m'$COMPTE'\033[0m] -> Repository: [\033[35m'$PROJET'\033[0m] "

# Configure local repo

echo "--"
echo -e "-- Récupération des fichiers + Envoi vers => [\033[37m' $ADRESS '\033[0m]"
echo "--"

echo -e -n "Ajouté un [\033[37m'commentaire'\033[0m] au commit :"
read COMMENTAIRE
echo -e "Ok [\033[37m'$COMMENTAIRE'\033[0m]"

git init
git add .
git config --global push.default simple
git commit -m "'$now' - '$COMMENTAIRE' "
git push --set-upstream $ADRESS master
git merge master


echo "--"
echo -e "-- L'url du repository -> [\033[37m' $ADRESS '\033[0m]"
echo "--"
# Setup remote repo

echo "---------------------------------------------------------"
echo -e "------ Sauvegarde sur [\033[36mVPS\033[0m]"
echo "---------------------------------------------------------"

echo "--"
echo "-- Création de votre BackUp sur le serveur"
echo -e "-- [\033[37m$USER@$HOST$GIT_PATH$PROJET/$NOW\033[0m]"
echo "--"


ssh $USER@$HOST 'mkdir '$GIT_PATH' ; mkdir '$GIT_PATH'/'$PROJET' ; mkdir '$GIT_PATH'/'$PROJET'/'$NOW' ; cd '$GIT_PATH'/'$PROJET'/'$NOW' && git init && git pull '$ADRESS



echo "--"
echo "-- Your new git repo '$REPO' is ready and initialized at:"
echo "-- $USER@$HOST/$GIT_PATH/$PROJET/$NOW"
echo "--"
echo -e "[\033[32mok\033[0m]"

read