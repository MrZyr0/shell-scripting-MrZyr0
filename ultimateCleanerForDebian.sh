#!/bin/bash

# COLORS DEFINITION
RED="\033[31m"            # red
GREEN="\033[92m"          # green (actually light_green)
YELLOW="\033[33m"         # yellow
LIGHT_YELLOW="\033[93m"   # light_yellow
COLOR_OFF="\033[39m"      # Clean the color, return to default


clear

echo -e $LIGHT_YELLOW"  #############################"$COLOR_OFF
echo -e $LIGHT_YELLOW"  ## ULTIMATE CLEANER SCRIPT ##"$COLOR_OFF
echo -e $LIGHT_YELLOW"  #############################"$COLOR_OFF
echo -e "\n"


echo -e $YELLOW"[0] Récupération des paramètres..."$COLOR_OFF
if [ "$#" != 0 ] && [ "$1" != "" ] && [ -d "$1" ]
then
	WORKING_DIR=`realpath $1`
else
    echo -e $RED"Aucun arguments ! Il me faut le chemin du dossier à trier"$COLOR_OFF
    exit 1
fi

CLEAN_DIR="$WORKING_DIR/../CLEAN"


echo -e $YELLOW"[1] Création des dossiers de destination..."$COLOR_OFF

rm -rf $CLEAN_DIR
TMP="$CLEAN_DIR/TMP"
mkdir -p "$CLEAN_DIR/Audios" "$CLEAN_DIR/Documents" "$CLEAN_DIR/Executables" "$CLEAN_DIR/Inclassables" "$CLEAN_DIR/Photos" "$CLEAN_DIR/Photos/sans dates"  "$CLEAN_DIR/Vidéos"
mkdir $TMP

echo -en "\e[33;5m[2] Trie en cours...\e[39;0m"
IMG=0
DOC=0
EXE=0
AUDIO=0
VIDEO=0
OTHER=0


find "$WORKING_DIR" -name '*' -type f | while read FILE
do

    if file "$FILE" | grep -q 'MPEG ADTS'  # Audios
    then
        cp "$FILE" "$CLEAN_DIR/Audios"

    elif file "$FILE" | grep -q 'ASF'  # ASF (microsoft)
    then
        ((AUDIO++))

        if echo "$FILE" | grep -q '.aiff' || echo "$FILE" | grep -q '.wav' || echo "$FILE" | grep -q '.wma' || echo "$FILE" | grep -q '.wmv'
        then
            cp "$FILE" "$CLEAN_DIR/Audios"
        else
            cp "$FILE" "$CLEAN_DIR/Vidéos"
        fi

    elif file "$FILE" | grep -q 'PDF' || file "$FILE" | grep -q 'text' || file "$FILE" | grep -q 'XML' # Documents
    then
        ((DOC++))
        cp "$FILE" "$CLEAN_DIR/Documents"

    elif file "$FILE" | grep -q 'executable' # Executables
    then
        ((EXE++))
        cp "$FILE" "$CLEAN_DIR/Executables"

    elif file "$FILE" | grep -qE 'image' || file "$FILE" | grep -qE 'Image' || file "$FILE" | grep -qE 'bitmap'    # Pictures
    then
        ((IMG++))

            cp "$FILE" "$CLEAN_DIR/Photos"

    elif file "$FILE" | grep -q 'ISO Media'  # Videos
    then
        cp "$FILE" "$CLEAN_DIR/Vidéos"

    else
        ((OTHER++))
        cp "$FILE" "$CLEAN_DIR/Inclassables"
    fi

    echo "$IMG" > "$TMP/IMG"
    echo "$DOC" > "$TMP/DOC"
    echo "$EXE" > "$TMP/EXE"
    echo "$AUDIO" > "$TMP/AUDIO"
    echo "$VIDEO" > "$TMP/VIDEO"
    echo "$OTHER" > "$TMP/OTHER"
done

echo
echo -e $YELLOW"[FIN]$COLOR_OFF$GREEN Tri terminé ! "$COLOR_OFF

IMG=`cat $TMP/IMG`
DOC=`cat $TMP/DOC`
EXE=`cat $TMP/EXE`
AUDIO=`cat $TMP/AUDIO`
VIDEO=`cat $TMP/VIDEO`
OTHER=`cat $TMP/OTHER`
TOTAL=$(( $IMG + $DOC + $EXE + $AUDIO + $VIDEO + $OTHER ))

echo -e "\n"
echo -e "$TOTAL fichier(s) au total :"
echo -e "\t$IMG image(s)"
echo -e "\t$DOC document(s)"
echo -e "\t$EXE fichiers executables(s)"
echo -e "\t$AUDIO fichier(s) audio"
echo -e "\t$VIDEO fichier(s) vidéo"
echo -e "\t$OTHER fichier(s) inclassables"

rm -rf "$TMP"
exit 0
