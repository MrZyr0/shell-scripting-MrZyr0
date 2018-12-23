#!/bin/bash

# Pour en savoir plus sur les couleurs du terminale : https://bit.ly/2MONcNt
 
for fgbg in 38 48 ; do # Foreground / Background
    for color in {0..255} ; do # Colors
        # Display the color
        printf "\e[${fgbg};5;%sm  %3s  \e[0m" $color $color
        # Display 6 colors per lines
        if [ $((($color + 1) % 6)) == 4 ] ; then
            echo # New line
        fi
    done
    echo # New line
done

echo ""
echo "Il faut donner le paramètre -e à echo pour qu'il interprète la couleur"
echo "Pour utiliser des couleurs custom pour le texte : \e[38;5;leCodeCouleurchoisi et finir avec m"
echo "Pour utiliser des couleurs custom pour l'arrière-plan : \e[48;5;leCodeCouleurchoisi et finir avec m"
echo "Biensur il est possible de combiner couleur de texte et arrière-plan comme ceci : \e[48;5;couleurArrièrePlan;38:5;couleurText et finir avec m"
echo ""


exit 0
