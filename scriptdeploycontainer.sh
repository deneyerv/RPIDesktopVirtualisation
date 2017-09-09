#!/bin/sh
#Script d'automatisation du lancement des containers
echo "Script de déploiement des conteneurs"
#Ceation d'un pont réseau
docker network rm local
docker network create --driver=bridge local --subnet=10.0.0.0/24
echo "Deploiement du gestionnaire de conteneurs"
#docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer
echo "Entrer le nombre de conteneur à créer"
read number
if [ $number -lt 4 ];then
	#Lancer uniquement les conteneurs utilisant VNC4Server
	for i in `seq $i $number`;
	do
        docker run -d -it  --name vnc_container$i 43d56d45fbb5 sh
	sleep 20s
	docker network connect  local vnc_container$i
	echo "Conteneur N$i est lancé"
	done
elif [ $number -gt 3  &&  $number -lt 7]; then
	#Lancement de  4 conteneurs avec vnc4server et les autres prévus pour la cli et ssh
	for i in `seq $i  4`;
	do
	docker run -d -it  --name vnc_container$i 43d56d45fbb5 sh
        sleep 20s
        docker network connect  local vnc_container$i
	echo "Conteneur N$i est lancé ( Avec VNC4server)"
	done
	#Creation dus conteneurs sans interface graphiques
	numberofclidocker = $number - $i
	for i in `seq $i  $numberofclidocker`;
        do
	docker run -d -it  --name cli_container$i 01aa1fb3456d  sh
        sleep 15s
        docker network connect  local cli_container$i
	done
else
	#Lancer que des conteneurs pour les sessions cli et ssh
	for i in `seq $i $number`;
	do
        docker run  -d  -it --name cli_container$i -p 10.0.0.23:22:22  01aa1fb3456d sh
        sleep 15s
        docker network connect local cli_container$i
	done
fi

