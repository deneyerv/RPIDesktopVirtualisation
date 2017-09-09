#!/bin/bash
#Script de création  backup des données utilisateurs et  des fichiers de configurations
#Date du jour
backupdate=$(date +%Y-%m-%d)

#Répertoire de backup
dirbackup=/backup

#Création du répertoire de backup
mkdir $dirbackup

#Creation de l'archive
tar -cvzf /$dirbackup/backup.tar.gz "/etc/" "/root" "/home" "/dockerdata"
echo "Fin de la sauvegarde"
echo ""


