# About colors & formating https://bit.ly/2MONcNt
# FORMATING DEFINITION
BOLD="\e[1m"
DIM="\e[2m"
UNDERLINE="\e[4m"
BLINK="\e[5m"
INVERTED="\e[7m"
HIDDEN="\e[8m"
RESET="\e[0m"           # Clear formating, return to default

# COLORS DEFINITION
BLACK="\e[30m"          # black
RED="\e[31m"            # red
PINK="\e[91m"           # pink (actually light_red)
GREEN="\e[92m"          # green (actually light_green)
DARK_GREEN="\e[32m"     # green
YELLOW="\e[33m"         # yellow
LIGHT_YELLOW="\e[93m"   # light_yellow
BLUE="\e[94m"           # blue
DARK_BLUE="\e[34m"      # blue (actually dark_blue)
MAGENTA="\e[95m"        # magenta (actually light_magenta)
DARK_MAGENTA="\e[35m"   # magenta
CYAN="\e[96m"           # cyan (actually light_cyan)
DARK_CYAN="\e[36m"      # cyan
LIGHT_GREY="\e[37m"     # light grey
DARK_GREY="\e[90m"      # dark grey
WHITE="\e[97m"          # white
COLOR_OFF="\e[39m"      # Clean the color, return to default


# FUNCTIONS
function prompt_idle
{
	local exitCode=$?

	if [ $exitCode == 0 ]
	then
        	echo -e "\e[92;1m|\e[39;0m"
	else
        	echo -e "\e[31;1m|\e[39;0m"
	fi
}


function prompt_git_branch
{
	branch=`git branch 2> /dev/null | grep -E '^\*' | sed "s/\* //"`
        if [ ! -z "$branch" ]
	then
		if [ "$branch" = "(no branch)" ]
		then
			echo " $branch"
		else

		dirty=`git status -s 2> /dev/null`
            		if [ ! -z "$dirty" ]
			then
		        	dirty='*'
			fi
        		echo " ($branch$dirty)"
        	fi
        fi
}


# function ls_custom
# {
# 	lsOut=`ls -GFlah`
#
# 	for item in $lsOut
# 	do
# 		grepOut=`$item | grep ^.`
#
# 		if [ "$grepOut" != "" ]
# 		then
# 			echo -e "\e[37m$item"
# 		else
# 			echo $item
# 		fi
# 	done
# }


function cp_to_desktop
{
	Destination="$1"


	if [ "$#" != 2 ]
	then
		echo -e $RED"Aucun arguments ! Il me faut le chemin à copier !"$COLOR_OFF
		return 1
	elif [ "$#" != 2 ] && [ "$2" = "" ]
	then
		echo -e $RED"Arguments Invalide ! Il ne peux être vide, il me faut le chemin à copier !"$COLOR_OFF
		return 2
	elif [ ! -f "$2" ] && [ ! -d "$2" ]
	then
		echo -e $RED"Arguments Invalide ! Il me faut chemin vers un fichier ou un dossier !"$COLOR_OFF
		return 3
	else
		linkOfFileToCopy=`realpath "$2"`
		fileName=`echo "$linkOfFileToCopy" | sed "s/.*\///"`
	fi


	if [ -f $linkOfFileToCopy ]
	then
		echo -e "Copie de $INVERTED$fileName$RESET en cours..."

		cp "$linkOfFileToCopy" $Destination

		local exitCode=$?

		if [ $exitCode = 0 ]
		then
			echo -e $GREEN"Fichier copié avec succès ! 😊👍"$COLOR_OFF
		else
			echo -e $RED"Il y a eu un soucis au moment de la copie...\n""Erreur $?"$COLOR_OFF
		fi

	elif [ -d $linkOfFileToCopy ]
	then
		echo -e "Copie de $INVERTED$fileName$RESET en cours..."

		cp -R "$linkOfFileToCopy" $Destination

		local exitCode=$?

		if [ $exitCode = 0 ]
		then
			echo -e $GREEN"Dossier copié avec succès ! 😊👍"$COLOR_OFF
		else
			echo -e $RED"Il y a eu un soucis au moment de la copie...\n""Erreur $?"$COLOR_OFF
		fi
	fi
}


function prompt_error
{
    local exitCode=$?
    local prevCmd=$(history | tail -2 | cut -c8- | head -1)

    if [ $exitCode = 0 ]
    then
        echo -e $CYAN"$prevCmd $COLOR_OFFà retourné $GREEN$exitCode$COLOR_OFF 😁👍"
    else
        echo -e $CYAN"$prevCmd $COLOR_OFFà retourné $RED$exitCode$COLOR_OFF 😱😡😭"
    fi
}

# PATH
#export PATH=/chemin:$PATH

# ALIAS
 ## CMD
#alias lsc='ls_custom'
alias cpd='cp_to_desktop "/mnt/c/Users/Julien/Desktop/"'
alias cps='cp_to_desktop "/mnt/c/Users/Julien/OneDrive\ -\ Ynov/Cours/B2/Scripting"'
alias where='pwd'
alias why='prompt_error'

 ## CD
alias cdy='cd /mnt/c/Users/Julien/OneDrive\ -\ Ynov/Cours/B2/'
alias cdd='cd /mnt/c/Users/Julien/Desktop/'
alias cdw='cd /mnt/c/Users/Julien/'


# TERMINAL THEME
export CLICOLOR=1
export LSCOLORS=XXXCXXXXBXX


# PS1
export PS1="\$(prompt_idle)$BLUE\\u $GREEN\\W$YELLOW\$(prompt_git_branch) $COLOR_OFF\$ "
