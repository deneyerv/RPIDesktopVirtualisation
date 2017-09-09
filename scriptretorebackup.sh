#!/bin/sh
#Script pour la restauration de l'archive
echo "Récupération et extraction de l'archive";
#Répertoire de backup
dirbackup=/backup
#A la racine pour l'extraction
cd /
# On extraction de l'archive
tar -xvzf $dirbackup/backup.tar.gz "etc" "root" "home" "dockerdata"
echo "### Fin de l'extraction";



