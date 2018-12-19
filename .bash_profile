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


# FUNCTIONS
function prompt_error_code
{
	local ERROR=$?
	
	if [ $ERROR == 0 ]
	then
		echo "$GREEN(OK)"
	else
		if [ $ERROR == 130 ]
		then
			echo "$RED\($ERROR : STOP by user)"
		else
			echo "$RED\($ERROR)"
		fi
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


function ls_custom
{
	lsOut=`ls -GFlah`
	
	for item in $lsOut
	do
		echo "a"
		#grepOut=`$item | grep ^.`
		
		#if [ $grepOut != "" ]
		#then
		#	echo -e "\e[37m$item"
		#else
		#	echo $item
		#fi
	done
}


function cp_to_desktop
{
	if [ $# != 0 ] && [ $1 != "" ] && [ -f $1 ]
	then
		$file2copy=$1
	else
		echo "\[\033[0;31m\]Aucun arguments ! Il me faut le fichier à copier !\[\033[0m\]"
		exit 1
	fi

	# Récupérer le chemin où l'utilisateur veux qu'on copie
	# si c'est égal à d le chemin doit être /mnt/c/Users/Julien/Desktop

	exit 0
}

# PATH
#export PATH=/chemin:$PATH

# ALIAS
alias lsc='$(ls_custom)'

 ## CD
alias cdy='cd /mnt/c/Users/Julien/OneDrive\ -\ Ynov/Cours/B2/'
alias cdw='cd /mnt/c/Users/Julien/'

# TERMINAL THEME
export CLICOLOR=1
export LSCOLORS=XXXCXXXXBXX

#PS1
export PS1="$(prompt_error_code) $CYAN\\u $GREEN\\W$YELLOW\$(prompt_git_branch)$COLOR_OFF\$ "

