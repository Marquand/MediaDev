#!/bin/sh

#Author:Mediashare
#Site:Mediashare.fr

# remgit.sh
# Creates a remote git repository from the current local directory

# Configuration
# Replace SSH_USERNAME, SSH_HOST, SSH_GIT_PATH with your details


echo "----------------------------------------------"
echo  "------ Service BackUp [\033[32mMediashare.fr\033[0m] --------"
echo "----------------------------------------------"

 
echo "Utilisateur :"
read USER
#USER=root
echo  "Ok [\033[32m'$USER'\033[0m]"

#echo -n "Serveur :"
#read HOST
HOST=vps241658.ovh.net
echo  "Votre serveur : [\033[32m'$HOST'\033[0m]"

REPO=${PWD##*/}

GIT_REMOTE_URL=ssh:/$USER@$HOST/$GIT_PATH/$REPO
GIT_PATH=/home/BackUp

now="$(date)"
#printf "%s\n" "$now"

NOW=$(echo $now|sed s/' '/'\-'/g)

echo "-------------------------------------------"
echo "------ Création du Repository/Commit --------"
echo "-------------------------------------------"

echo  "Entrer le nom du Projet sur Github :"
read PROJET
ADDRESS="https://github.com/Marquand/"$PROJET".git"

# Configure local repo

echo "--"
echo  "-- Récupération des fichiers + Envoi vers => [\033[32m' $ADDRESS '\033[0m]"
echo "--"
 
echo  "Commentaire :"
read COMMENTAIRE

echo  "Ok [\033[32m'$COMMENTAIRE'\033[0m]"


git init
git add .
git config --global push.default simple
git commit -m "'$now' - '$COMMENTAIRE' "
git push --set-upstream $ADDRESS master
git merge master

# Setup remote repo

echo "--"
echo "-- Creating bare remote repo at:"
echo "-- $USER@$HOST/$GIT_PATH/$REPO"
echo "--"


ssh $USER@$HOST 'mkdir '$GIT_PATH' ; mkdir '$GIT_PATH'/'$PROJET' ; mkdir '$GIT_PATH'/'$PROJET'/'$NOW' ; cd '$GIT_PATH'/'$PROJET'/'$NOW' && git init && git pull '$ADDRESS


echo "--"
echo "-- Your new git repo '$REPO' is ready and initialized at:"
echo "-- $USER@$HOST/$GIT_PATH/$PROJET/$NOW"
echo "--"
echo "[\033[32mok\033[0m]"

read