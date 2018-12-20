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
	if [ "$#" != 0 ] && [ "$1" != "" ] && [ -f $1 ]
	then
		file2copy=$1
		cp $file2copy /mnt/c/Users/Julien/Desktop/
	else
		echo -e $RED"Aucun arguments ! Il me faut le fichier à copier !$COLOR_OFF"
	fi
}


function prompt_error
{
    local exitCode=$?
    local prevCmd=$(history | tail -1 | cut -c8-)

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
alias cpd='cp_to_desktop'
alias where='pwd'
alias why='prompt_error'

 ## CD
alias cdy='cd /mnt/c/Users/Julien/OneDrive\ -\ Ynov/Cours/B2/'
alias cdw='cd /mnt/c/Users/Julien/'


# TERMINAL THEME
export CLICOLOR=1
export LSCOLORS=XXXCXXXXBXX


# PS1
export PS1="\$(prompt_idle)$BLUE\\u $GREEN\\W$YELLOW\$(prompt_git_branch) $COLOR_OFF\$ "
