echo "/******************** Configuration ********************/"
cd "/etc/apache2/sites-enabled"
echo -e "Emplacement -> /etc/apache2/sites-enabled/ chargé : [\033[32mok\033[m] "

projet(){
   echo -n "Entrez le nom du projet : "
   read fichier
}

port() {
   echo -n "Entrez le port [80] : "
   read port
}

adresse(){
   echo -n "Entrez l'adresse de pointage ( ex: exemple.mediashare.fr| vps241658.ovh.net/exemple ) : "
   read adresse
}

projet
port
adresse

if [$port = ""]
   then
      port="80"
      echo -e "Définition du port 80 : [\033[32mok\033[0m]"
fi

> $fichier
echo -e "Création du fichier de configuration "$fichier": [\033[32mok\033[0m]"
echo "<VirtualHost *:"$port">" >> $fichier
echo "   ServerName "$adresse >> $fichier
echo "   ServerAlias www."$adresse >> $fichier
echo "" >> $fichier
echo "   DocumentRoot /var/www/"$fichier"/web" >> $fichier
echo "   <Directory /var/www/"$fichier"/web>" >> $fichier
echo "      AllowOverride None" >> $fichier
echo "      Order Allow,Deny" >> $fichier
echo "      Allow from All" >> $fichier
echo "" >> $fichier
echo "      <IfModule mod_rewrite.c>" >> $fichier
echo "         Options -MultiViews" >> $fichier
echo "         RewriteEngine On" >> $fichier
echo "         RewriteCond %{REQUEST_FILENAME} !-f" >> $fichier
echo "         RewriteRule (.*)$ app.php [QSA,L]" >> $fichier
echo "      </IfModule>" >> $fichier
echo "   </Directory>" >> $fichier
echo "" >> $fichier
echo "   ErrorLog /var/log/apache2/project_error.log" >> $fichier
echo "   CustomLog /var/log/apache2/project_access.log combined" >> $fichier
echo "</virtualHost>" >> $fichier
echo -e "Ecriture de la configuration dans  "$fichier": [\033[32mok\033[0m]"

