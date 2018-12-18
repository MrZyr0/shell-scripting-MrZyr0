#!/bin/bash
clear

echo "## ULTIMATE CLEANER SCRIPT ##"

echo "[0] Récupération des paramètres..."
if [ -d $1 ]
then
    WORKING_DIR=$1
fi

CLEAN_DIR="$WORKING_DIR/../CLEAN"


echo "[1] Création du dossier de destination..."

rm -rf $CLEAN_DIR
mkdir -p $CLEAN_DIR/Photos
mkdir -p $CLEAN_DIR/Vidéos
mkdir -p $CLEAN_DIR/Documents
mkdir -p $CLEAN_DIR/Audio
mkdir -p $CLEAN_DIR/Inclassables

echo "[2] Récupération des fichiers..."
FILES=`find $WORKING_DIR -type f`

echo "[3] Trie en cours..."
for file in $files
do
    if [ file | grep 'image data' == 0 ]
    then
        cp file $CLEAN_DIR/Photos
    elif [ file | grep 'PDF' == 0 ]
    then
        cp file $CLEAN_DIR/Documents
    elif [ file | grep 'MPEG' == 0 ]
    then
        cp file $CLEAN_DIR/Audio
    elif [ file | grep 'AVI' == 0 ] || [ file | grep 'XviD' == 0]
    then
        cp file $CLEAN_DIR/Vidéo
    else
        cp file $CLEAN_DIR/Inclassables
    fi
done
echo "[FIN] Tri terminé"
