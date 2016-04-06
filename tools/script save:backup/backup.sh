#!/bin/sh
tar -zcvf BackUp-28012016.tar.gz *
echo "Preparation connexion"
ftp -i ftp://mediashask:Timquand1@ftp.mediashare.fr <<END_SCRIPT

binary
put BackUp-28012016.tar.gz /server/BackUp
EOF
