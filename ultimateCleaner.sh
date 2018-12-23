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
if [ "$#"" != 0 ] && [ "$1" != "" ] && [ -d "$1" ]
then
    WORKING_DIR="$1"
	#WORKING_DIR=`realpath"$1"` for realpath but only on debian
else
    echo -e $RED"Aucun arguments ! Il me faut le chemin du dossier à trier"$COLOR_OFF
    exit 1
fi

CLEAN_DIR="$WORKING_DIR/CLEAN"
#CLEAN_DIR="$WORKING_DIR/../CLEAN" for realpath but only on debian


echo -e $YELLOW"[1] Création des dossiers de destination..."$COLOR_OFF

rm -rf $CLEAN_DIR
TMP="$CLEAN_DIR/TMP"
mkdir -p "$CLEAN_DIR/Photos" "$CLEAN_DIR/Photos/sans dates"  "$CLEAN_DIR/Vidéos" "$CLEAN_DIR/Documents" "$CLEAN_DIR/Audio" "$CLEAN_DIR/Inclassables"
mkdir $TMP

echo -en "\e[33;5m[2] Trie en cours...\e[39;0m"
IMG=0
DOC=0
AUDIO=0
VIDEO=0
OTHER=0


find "$WORKING_DIR" -name '*' -type f | while read FILE
do

	if file "$FILE" | grep -qE 'image | bitmap'
	then
		((IMG++))

		echo "$FILE"

		YEAR=`stat -t %Y "$FILE" | cut -d ' ' -f 9 | sed s/\"//g`

		if [ ! -d "$CLEAN_DIR/Photos/$YEAR" ] && [ "$YEAR" != 1 ]
		then
			mkdir "$CLEAN_DIR/Photos/$YEAR"
		fi

		MONTH=`stat -t %m "$FILE" | cut -d ' ' -f 9 | sed s/\"//g`

		if [ ! -d "$CLEAN_DIR/Photos/$YEAR/$MONTH" ] && [ "$YEAR" != 1 ]
		then
			mkdir "$CLEAN_DIR/Photos/$YEARS/$MONTH"
		fi

		if [ "$YEAR" != "" ] && [ "$MONTH" != "" ] && [ "$YEAR" != 1 ] && [ "$MONTH" != 1 ]
		then
			cp "$FILE" "$CLEAN_DIR/Photos/$YEAR/$MONTH"
		else
			cp "$FILE" "$CLEAN_DIR/Photos/sans dates"
		fi

	elif file "$FILE" | grep -q 'PDF'
	then
		((DOC++))
		cp "$FILE" "$CLEAN_DIR/Documents"

	elif file "$FILE" | grep -q 'ASF'
	then
        	((AUDIO++))

			if [ echo "$FILE" | grep -q '.aiff' ] &&  [ echo "$FILE" | grep -q '.wav' ] &&  [ echo "$FILE" | grep -q '.wma' ] &&  [ echo "$FILE" | grep -q '.wmv' ]
			then
				cp "$FILE" "$CLEAN_DIR/Audio"
			else
				cp "$FILE" "$CLEAN_DIR/Vidéos"
			elif

	else
	        ((OTHER++))
        	cp "$FILE" "$CLEAN_DIR/Inclassables"
	fi

echo "$IMG" > "$TMP/IMG"
echo "$DOC" > "$TMP/DOC"
echo "$AUDIO" > "$TMP/AUDIO"
echo "$VIDEO" > "$TMP/VIDEO"
echo "$OTHER" > "$TMP/OTHER"

done

echo
echo -e $YELLOW"[FIN]$COLOR_OFF$GREEN Tri terminé ! "$COLOR_OFF

IMG=`cat $TMP/IMG`
DOC=`cat $TMP/DOC`
AUDIO=`cat $TMP/AUDIO`
VIDEO=`cat $TMP/VIDEO`
OTHER=`cat $TMP/OTHER`
TOTAL=$(( $IMG + $DOC + $AUDIO + $VIDEO + $OTHER ))

echo -e "\n"
echo -e "$TOTAL fichier(s) au total :"
echo -e "\t$IMG image(s)"
echo -e "\t$DOC document(s)"
echo -e "\t$AUDIO fichier(s) audio"
echo -e "\t$VIDEO fichier(s) vidéo"
echo -e "\t$OTHER fichier(s) inclassables"

rm -rf "$TMP"
exit 0

