# About colors & formating https://bit.ly/2MONcNt
# FORMATING DEFINITION
BOLD="\0033[1m"
DIM="\0033[2m"
UNDERLINE="\0033[4m"
BLINK="\0033[5m"
INVERTED="\0033[7m"
HIDDEN="\0033[8m"
RESET="\0033[0m"           # Clear formating, return to default

# COLORS DEFINITION
BLACK="\0033[30m"          # black
RED="\0033[31m"            # red
PINK="\0033[91m"           # pink (actually light_red)
GREEN="\0033[92m"          # green (actually light_green)
DARK_GREEN="\0033[32m"     # green
YELLOW="\0033[33m"         # yellow
LIGHT_YELLOW="\0033[93m"   # light_yellow
BLUE="\0033[94m"           # blue
DARK_BLUE="\0033[34m"      # blue (actually dark_blue)
MAGENTA="\0033[95m"        # magenta (actually light_magenta)
DARK_MAGENTA="\0033[35m"   # magenta
CYAN="\0033[96m"           # cyan (actually light_cyan)
DARK_CYAN="\0033[36m"      # cyan
GREY="\0033[90m"     	# grey
WHITE="\0033[97m"          # white
COLOR_OFF="\0033[39m"      # Clean the color, return to default


# FUNCTIONS
function prompt_idle
{
	local exitCode=$?

	if [ $exitCode == 0 ]
	then
        	echo -e "\0033[92;1m|\0033[39;0m"
	else
        	echo -e "\0033[31;1m|\0033[39;0m"
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


function ls_custom_full
{
	if [ $# != 0 ]
	then
		path="$1"
	else
		path=`pwd`
	fi

	i=0
	ls -AFhl "$path" | while read line
	do
		fileName=`echo "$line" | cut -c49- | sed s/*$//`

		isHidden=`echo "$fileName" | grep -E ^\\\.`
		isEmpty=`file "$fileName" | grep -E empty$`
		isFirstLine=`echo "$line" | grep -E ^total`


		if [ -f "$fileName" ] && [ -x "$fileName" ] && [ "$isHidden" != "" ] && [ ! -d "$fileName" ] && [ "$isEmpty" = "" ] && [ "$fileName" != "" ] # Hidden executable file
		then
			thisLine=`echo "$line" | sed "s/*$//" | sed "s/^.//"`
			echo -e "\0033[92;48;5;243m$thisLine\0033[39;0m"

		elif [ -f "$fileName" ] && [ -x "$fileName" ]  # Executable file (folder are executable to work)
		then
			thisLine=`echo "$line" | sed "s/*$//"`
			echo -e "$GREEN$thisLine$COLOR_OFF"

		elif [ -f "$fileName" ] && [ "$isHidden" != "" ] && [ "$isEmpty" = "" ] # Hidden file
		then
			thisLine=`echo "$line" | sed "s/^.//"`
			echo -e "$GREY$thisLine$COLOR_OFF"

		elif [ -d "$fileName" ] && [ "$isHidden" != "" ] # Hidden folder
		then
			thisLine=`echo "$line" | sed "s/\/$//"`
			echo -e "\0033[90;48;5;253m$thisLine\0033[39;0m"

		elif [ -f "$fileName" ] && [ "$isHidden" = "" ] && [ ! -x "$fileName" ] && [ "$isEmpty" = "" ] # Standard file
		then
			echo "$line"

		elif [ -d "$fileName" ] && [ "$isHidden" = "" ] && [ ! -z "$(ls -A "$fileName")" ] # Standard Folder
		then
			thisLine=`echo "$line" | sed "s/\/$//"`
			echo -e "\0033[30;48;5;253m$thisLine\0033[39;0m"

		elif [ "$isEmpty" != "" ] # Empty file
		then
			echo -e "$RED$line$COLOR_OFF"

		elif [ -d "$fileName" ] && [ -z "$(ls -A "$fileName")" ] # Empty folder
		then
			thisLine=`echo "$line" | sed "s/\/$//"`
			echo -e "\0033[31;48;5;253m$thisLine\0033[39;0m\t"
		elif [ "$isFirstLine" != "" ]
		then
			echo "$line"

		elif [ "$line" = "" ] || [ "$fileName" = "" ]
		then
			echo -e $RED"ERROR(empty) : $fileName $COLOR_OFF"
		else
			echo -e $RED"ERROR : $fileName $COLOR_OFF"
		fi

 	done
}

function ls_custom
{
	if [ $# != 0 ]
	then
		path="$1"
	else
		path=`pwd`
	fi

	i=0
	ls -AF "$path" | while read line
	do
		for fileName in "$line"
		do
			fileName=`echo "$fileName" | sed s/*$//`
			isHidden=`echo "$fileName" | grep -E ^\\\.`
			isEmpty=`file "$fileName" | grep -E empty$`

			if [ -f "$fileName" ] && [ -x "$fileName" ] && [ "$isHidden" != "" ] && [ ! -d "$fileName" ] && [ "$isEmpty" = "" ] && [ "$fileName" != "" ] # Hidden executable file
			then
				thisFile=`echo "$fileName" | sed "s/*$//" | sed "s/^.//"`
				echo -ne "\0033[92;48;5;243m$thisFile\0033[39;0m\t"
			
			elif [ -f "$fileName" ] && [ -x "$fileName" ]  # Executable file (folder are executable to work)
			then
				thisFile=`echo "$fileName" | sed "s/*$//"`
				echo -ne "$GREEN$thisFile$COLOR_OFF\t"
			
			elif [ -f "$fileName" ] && [ "$isHidden" != "" ] && [ "$isEmpty" = "" ] # Hidden file
			then
				thisFile=`echo "$fileName" | sed "s/^.//"`
				echo -ne "$GREY$thisFile$COLOR_OFF\t"
			
			elif [ -d "$fileName" ] && [ "$isHidden" != "" ] # Hidden folder
			then
				thisFile=`echo "$fileName" | sed "s/^.//" | sed "s/\/$//"`
				echo -ne "\0033[90;48;5;253m$thisFile\0033[39;0m\t"
			
			elif [ -f "$fileName" ] && [ "$isHidden" = "" ] && [ ! -x "$fileName" ] && [ "$isEmpty" = "" ] # Standard file
			then
				echo -ne "$fileName\t"

			elif [ -d "$fileName" ] && [ "$isHidden" = "" ] && [ ! -z "$(ls -A "$fileName")" ] # Standard Folder
			then
				thisFile=`echo "$fileName" | sed "s/\/$//"`
				echo -ne "\0033[30;48;5;253m$thisFile\0033[39;0m\t"

			elif [ "$isEmpty" != "" ] # Empty file
			then
				echo -ne "$RED$fileName$COLOR_OFF\t"
			
			elif [ -z "$(ls -A "$fileName")" ] # Empty folder
			then
				thisFile=`echo "$fileName" | sed "s/\/$//"`
				echo -ne "\0033[31;48;5;253m$thisFile\0033[39;0m\t"

			else
				echo -ne $RED"ERROR$COLOR_OFF\t"
			fi


			size=`echo $fileName | wc -m` 
			if [ "$size" > "6" ]
			then
				echo -ne "\t"
			fi

			((i++))

			if [ $(($i%4)) = 1 ] && [ $i != 1 ]
			then
				echo
			fi
		done
 	done
}


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


	if [ -f "$linkOfFileToCopy" ] && [ -e "$Destination/$fileName" ]
	then
		echo -ne "Le fichier $INVERTED$fileName$RESET existe déjà, voulez-vous continuer ? [O/n] "
		read choice
		


		while [ "$choice" != "" ] && [ "$choice" != "n" ] && [ "$choice" != "N" ] && [ "$choice" != "O" ] && [ "$choice" != "o" ]
		do
			echo -e $RED"Argument invalide ! |$choice|"$COLOR_OFF
			echo -ne "Le fichier $INVERTED$fileName$RESET existe déjà, voulez-vous continuer ? [O/n] "
			read choice
		done

		if [ "$choice" != "" ] || [ "$choice" = "n" ] ||  [ "$choice" = "N" ]
		then
			echo -e $RED"Action annulée"$COLOR_OFF
			return 4
		fi
		
		rm "$Destination/$fileName"

	elif [ -d "$linkOfFileToCopy" ] && [ -d "$Destination/$fileName" ]
	then
		read -p "Le dossier $fileName existe déjà, voulez-vous continuer ? [O/n] " choice

		while [ "$choice" != "" ] && [ "$choice" != "n" ] && [ "$choice" != "N" ] && [ "$choice" != "O" ] && [ "$choice" != "o" ]
		do
			echo -e $RED"Argument invalide !"$COLOR_OFF
			read -p "Le dossier $INVERTED$fileName$RESET existe déjà, voulez-vous continuer ? [O/n] " choice
		done

		if [ "$choice" != "" ] || [ "$choice" = "n" ] || [ "$choice" = "N" ]
		then
			echo -e $RED"Action annulée"$COLOR_OFF
			return 4
		fi

		rm -r "$Destination/$fileName/"
	fi


	if [ -f "$linkOfFileToCopy" ]
	then
		echo -e "Copie de $INVERTED$fileName$RESET en cours..."
		
		cp "$linkOfFileToCopy" "$Destination"

		local exitCode=$?

		if [ "$exitCode" = "0" ]
		then
			echo -e $GREEN"Fichier copié avec succès !"$COLOR_OFF
		else
			echo -e $RED"Il y a eu un soucis au moment de la copie...\n""Erreur $?"$COLOR_OFF
		fi

	elif [ -d "$linkOfFileToCopy" ]
	then
		echo -e "Copie de $INVERTED$fileName$RESET en cours..."

		cp -R "$linkOfFileToCopy" "$Destination"

		local exitCode=$?

		if [ "$exitCode" = "0" ]
		then
			echo -e $GREEN"Dossier copié avec succès !"$COLOR_OFF
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
	if [ $exitCode = 130 ]
	then
		echo -e $CYAN"$prevCmd $COLOR_OFFà retourné $RED$exitCode$COLOR_OFF \0033[2;4marrêté par l'utilisateur$RESET 😱😡😭"
        else
		echo -e $CYAN"$prevCmd $COLOR_OFFà retourné $RED$exitCode$COLOR_OFF 😱😡😭"
	fi
    fi
}

# PATH
#export PATH=/chemin:$PATH

# ALIAS
 ## CMD
alias lsf='ls_custom_full'
alias lsc='ls_custom'
alias cpd='cp_to_desktop "/mnt/c/Users/Julien/Desktop/"'
alias cpc='cp_to_desktop "/mnt/c/Users/Julien/OneDrive\ -\ Ynov/Cours/B2/"'
alias cps='cp_to_desktop "/mnt/c/Users/Julien/OneDrive\ -\ Ynov/Cours/B2/Scripting"'
alias where='pwd'
alias why='prompt_error'
alias cls='clear'
alias cc='clear && clear'
alias cx='chmod +x'
alias ww='file' #pour connaitre le poid d'un fichier

## CD
alias cdy='cd /mnt/c/Users/Julien/OneDrive\ -\ Ynov/Cours/B2/'
alias cdd='cd /mnt/c/Users/Julien/Desktop/'
alias cdw='cd /mnt/c/Users/Julien/'


# TERMINAL THEME
export CLICOLOR=1

# ls COLOR (utilisé pour ls --color=auto)
export LSCOLORS=XXXCXXXXBXX


# PS1
export PS1="\n\e[m\$(prompt_idle)\e[94m\u \e[92m\W\e[33m\$(prompt_git_branch) \e[39m\$ "
