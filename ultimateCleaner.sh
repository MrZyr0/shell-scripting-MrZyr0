#!/bin/bash

if [ $* | grep ^/$/ ] == ""
then
    WORKING_DIR=`dirname $0`
else
    $* | grep ^/$/ > WORKING_DIR
fi
# Il faut que je créer un dossier CLEAN à coté du WORKING_DIR
CLEAN_DIR=../$WORKING_DIR


if [[ $* | grep fixtureload ]]
then
    echo "[0] Création des fixture"

    rm -rf ./fixtures

    mkdir -p \
        ./fixtures/root\
        ./fixtures/home/1\
        ./fixtures/home/.git\/logs\
        ./fixtures/home/home_du_grenier\
        ./fixtures/home/homework/documentaires

    echo "aaaa"     													                                                    > ./fixtures/home/aaaaa
    echo "/fixtures/root/aaaa"
    echo "bbbb"     													                                                    > ./fixtures/root/bbbbb
    echo "/fixtures/root/bbbbb"
    echo "zzzz"     													                                                    > ./fixtures/root/zzzzz
    echo "/fixtures/root/zzzzz"
    echo "aaaa"     													                                                    > ./fixtures/home/aaaaa
    echo "/fixtures/home/aaaa"
    echo "bbbb"     													                                                    > ./fixtures/home/bbbbb
    echo "/fixtures/home/bbbbb"
    echo "zzzz"     													                                                    > ./fixtures/home/zzzzz
    echo "/fixtures/home/zzzzz"
    echo "eeee"     													                                                    > ./fixtures/home/eeeeee
    echo "/fixtures/home/eeeeee"
    echo "coincoin"     													                                                > ./fixtures/home/1/duck.jpg
    echo "/fixtures/home/1/duck.jpg"
    echo "FATAL ERROR T NUL" 												                                                > ./fixtures/home/.git/logs/erros.tnul
    echo "/fixtures/home/.git/logs/erros.tnul"
    echo "OK" 														                                                        > ./fixtures/home/.git/logs/success.gg
    echo "/fixtures/home/.git/logs/success.gg"
    echo "GG WP I THINK" 													                                                > ./fixtures/home/.git/logs/win.arretedejouer
    echo "/fixtures/home/.git/logs/win.arretedejouer"
    echo "." 														                                                        > ./fixtures/home/.git/logs/default.jecpas
    echo "/fixtures/home/.git/logs/default.jecpas"
    echo "ILLUMINATI" 													                                                    > ./fixtures/home/home_du_grenier\plan_des_capitalistes.pdf
    echo "/fixtures/home/home_du_grenier\plan_des_capitalistes.pdf"
    echo "title : fukcing super smash brothers utlimated for my fucking awesome goodness amzing NINTENDO GOD switch :D"     > ./fixtures/home/homework/game.cshrap
    echo "/fixtures/home/homework/game.cshrap"
    echo "give me more RAM !" 					    							                                            > ./fixtures/home/homework/unity.exe
    echo "/fixtures/home/homework/unity.exe"
    echo "elp.tentacode.net" 					    							                                            > ./fixtures/home/homework/PHPwebsite
    echo "/fixtures/home/homework/PHPwebsite"
    echo "tada !" 							    							                                                > ./fixtures/home/homework/presentation
    echo "/fixtures/home/homework/presentation"
    echo "this is windobe" 						    							                                            > ./fixtures/home/homework/windows.del
    echo "/fixtures/home/homework/windows.del"
    echo "yeah take my money ;-)" 					    							                                        > ./fixtures/home/homework/macos.run
    echo "/fixtures/home/homework/macos.run"
    echo "interdit aux -18 !" 					    							                                            > ./fixtures/home/homework/documentaires/belle_blonde_chez_les_7_nains.mov
    echo "/fixtures/home/homework/documentaires/belle_blonde_chez_les_7_nains.mov"
    echo "tj là ?" 							    							                                                > ./fixtures/home/homework/documentaires/BOOBSWATCH.mp4
    echo "/fixtures/home/homework/documentaires/BOOBSWATCH.mp4"
    echo "tu ne devrai pas regarder ça !" 				    							                                    > ./fixtures/home/homework/documentaires/Tout_a_declarer(4K).mkv
    echo "/fixtures/home/homework/documentaires/Tout_a_declarer(4K).mkv"
    echo "bon tant pis je t'aurais prévenu..." 										                                        > ./fixtures/home/homework/documentaires/AlertaMalyBoules.avi
    echo "/fixtures/home/homework/documentaires/AlertaMalyBoules.avi"

fi


echo "[1] Trie en cours..."
files = file -f
for file in $files
do
    if [ file | grep 'image data' ] != ""
    then
        # copier le fichier vers un sous dossier du clean dir
    fi

done
echo "FIN"
