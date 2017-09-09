#!/bin/bash
#Script pour effectuer les commits de tous les conteneurs
set -e
set -u
#Recuperation de tous les conteneurs actifs et split des informations
ALLPS=$(docker ps | awk '{ print $1"|"$2 }' | grep -v CONTAINER )
for i in $ALLPS; do
    CTID=$(echo $i | cut -d '|' -f1)
    IMAGE=$(echo $i | cut -d '|' -f2)
    REPO=$(echo $IMAGE | cut -d ':' -f1)
    TAG=$(echo $IMAGE | cut -d ':' -f2)
    DISTROVER=$(echo $TAG | cut -d '-' -f1)
    TIMESTAMP=$(echo $TAG | cut -d '-' -f2)
    TIMESTAMP_NOW=$(date +"%m%d%y_%H%M%S")
    echo "Sauvegarde du conteneur  CTID $CTID to $REPO:$DISTROVER-$TIMESTAMP_NOW"
    docker commit $CTID $REPO:$DISTROVER-$TIMESTAMP_NOW
    echo "Commit reussi"
done
