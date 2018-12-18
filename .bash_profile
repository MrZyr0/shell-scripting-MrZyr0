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
	if [ $ERROR != 0 ]
	then
		if [ $ERROR == 130 ]
		then
			echo "($ERROR : STOP by user) "
		else
			echo "($ERROR) "
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
export PS1="$RED\$(prompt_error_code)$CYAN\\u $GREEN\\W$YELLOW\$(prompt_git_branch)$COLOR_OFF\$ "

