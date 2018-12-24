# shell-scripting-MrZyr0

# .bash_profile
Beaucoup de personnalisation sur le PS1 mais surtout beaucoup d'ajout d'alias de commandes !

## Nouvelles commandes
- `lsc` permet d'afficher une colorisation pour `ls -AF`
- `lsf` permet d'afficher une colorisation pour `ls -lAFh`
- `where` permet d'afficher le chemin absolu du répertoire courant
- `why` permet d'avoir le code erreur de la commande précédante (avec une description si l'erreur est connu)
- `cls`, `cc` sont des raccourcis au `clear`
- `cx *un fichier à rendre executable*` permet de rapidement rendre executable un fichier

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
