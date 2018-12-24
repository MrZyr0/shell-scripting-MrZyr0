# shell-scripting-MrZyr0

# .bash_profile
Beaucoup de personnalisation sur le PS1 mais surtout beaucoup d'ajout d'alias de commandes !

- Pour télécharger et appliquer (une sauvegarde du bash_profile actuelle est faite !):
```bash
cd ~ && mv .bash_profile .bash_profile.bak && wget https://raw.githubusercontent.com/tentacode-classroom/shell-scripting-MrZyr0/master/.bash_profile -O .bash_profile && source .bash_profile
```
- Pour supprimer le bash_profile :
```bash
cd ~ && rm .bash_profile && mv .bash_profile.bak .bash_profile
```

## Nouvelles commandes ! (alias)
- `where` permet d'afficher le chemin absolu du répertoire courant
![capture d'écran](https://github.com/tentacode-classroom/shell-scripting-MrZyr0/blob/master/screens/where.png)
- `why` permet d'avoir le code erreur de la commande précédante (avec une description si l'erreur est connu)
![capture d'écran](https://github.com/tentacode-classroom/shell-scripting-MrZyr0/blob/master/screens/why.png)
- `cx *un fichier à rendre executable*` permet de rapidement rendre executable un fichier
![capture d'écran](https://github.com/tentacode-classroom/shell-scripting-MrZyr0/blob/master/screens/cx.png)
- `cls`, `cc` sont des raccourcis au `clear`
### ls
- `lsc` permet d'afficher une colorisation pour `ls -AF`
![capture d'écran](https://github.com/tentacode-classroom/shell-scripting-MrZyr0/blob/master/screens/lsc.png)
- `lsf` permet d'afficher une colorisation pour `ls -lAFh`
![capture d'écran](https://github.com/tentacode-classroom/shell-scripting-MrZyr0/blob/master/screens/lsf.png)

Code couleur :
![capture d'écran](https://raw.githubusercontent.com/tentacode-classroom/shell-scripting-MrZyr0/master/screens/lsCodeCouleur.PNG)

# ultimateCleaner.sh

Il suffit de prendre le fichier compatible à son OS (à cause d'une commande non compatible avec les mac) et de l'appeler en lui donnant le dossier à trier.
Exemple `./ultimateCleanerForMac.sh bazar/`

## MacOS
Pour les Mac il faut que le script soit à côté du dossier à trier
Le script va créer un dossier `CLEAN` dans le dossier à trier.

## Debian
Pour Debian le script peut-être appelé de n'import où sur n'importe quel dossier.
Le script va créer un dossier `CLEAN` à côté du dossier à trier.
##  
Dans le dossier `CLEAN` il y a des sous-dossier par rapport au type des fichiers

## Télécharger
Debian : `wget https://github.com/tentacode-classroom/shell-scripting-MrZyr0/blob/master/ultimateCleanerForDebian.sh -O ultimateCleaner.sh`
MacOS : `wget https://github.com/tentacode-classroom/shell-scripting-MrZyr0/blob/master/ultimateCleanerForMac.sh -O ultimateCleaner.sh`

# showSupportedColors.sh

C'est un petit script pour afficher les codes des couleurs supportées ainsi qu'une description pour savoir comment les utiliser

## Télécharger
`wget https://raw.githubusercontent.com/tentacode-classroom/shell-scripting-MrZyr0/master/showSupportedColors.sh -O showSupportedColors.sh`
