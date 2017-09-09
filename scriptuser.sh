#!/bin/bash
#Script pour l'ajout des utilisateurs
echo  "Lancement du script pour l'ajout des utilisateurs"
echo  "nom de l'utilisateur"
read login
echo  "mot de passe de l'utilisateur"
read password
useradd $login -p $password -d /home/$login
uid=$(grep -w $login /etc/passwd | awk -F: '{ print $3 }')
echo $uid
#Creation du dossier utilisateurs
mkdir /home/$login
chown $uid:$uid /home/$login
chmod -R 775 /home/$login

echo "/home/$login  /home/$login auto bind,defaults 0 0" >> /etc/fstab
mount /home/$login

#Redemarrage de service vsftpd
sudo service vsftpd restart



