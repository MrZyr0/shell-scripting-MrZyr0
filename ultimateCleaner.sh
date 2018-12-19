#!/bin/bash

# COLORS DEFINITION
BLACK="\[\033[0;30m\]"      # black
RED="\[\033[0;31m\]"        # red
GREEN="\[\033[0;32m\]"      # green
YELLOW="\[\033[0;33m\]"     # yellow
BLUE="\[\033[0;34m\]"       # blue
MAGENTA="\[\033[0;35m\]"    # magenta
CYAN="\[\033[0;36m\]"       # cyan
LIGHT_GREY="\[\033[0;37m\]" # light grey
DARK_GREY="\[\033[1;30m\]"  # dark grey
WHITE="\[\033[1;37m\]"      # white
COLOR_OFF="\[\033[0m\]"     # off


clear

echo "  ## ULTIMATE CLEANER SCRIPT ##"

echo "[0] Récupération des paramètres..."
if [ $# != 0 ] && [ $1 != "" ] && [ -d $1 ]
then
    echo $1
    WORKING_DIR=$1
else
    echo "[#] Aucun arguments ! Il me faut le chemin du dossier à trier"
    exit 1
fi

CLEAN_DIR=$WORKING_DIR/../CLEAN


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
for f in $files
do
    if [ file $f | grep 'image data' == 0 ]
    then
        cp file $CLEAN_DIR/Photos
    elif [ file $f | grep 'PDF' == 0 ]
    then
        cp file $CLEAN_DIR/Documents
    elif [ file $f | grep 'MPEG' == 0 ]
    then
        cp file $CLEAN_DIR/Audio
    elif [ file $f | grep 'AVI' == 0 ] || [ file | grep 'XviD' == 0]
    then
        cp file $CLEAN_DIR/Vidéo
    else
        cp file $CLEAN_DIR/Inclassables
    fi
done
echo $CLEAN_DIR
echo "[FIN] Tri terminé"
exit 0
