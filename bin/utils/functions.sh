# Relying on the assumption that you have installed the script the right way.
_listDotFilesScripts(){
    local cur=${COMP_WORDS[COMP_CWORD]}
    COMPREPLY=( $(compgen -W "$(cd $DOTFILE_DIR/dotfiles && git ls-files ../ | cut -b 4-)" -- $cur) )
}

editShellScript() {
    if [ "$#" -lt 1 ]; then
        echo "You did not provide the correct number of parameters"
        echo "Correct usage: $FUNCNAME <dotfile>"
        echo "Example: $FUNCNAME .bashrc"
        return
    fi

    pushd $DOTFILE_DIR > /dev/null
    	$EDITOR_CMD $1
    popd > /dev/null
}
complete -F _listDotFilesScripts editShellScript

# This function allows us to load up cooresponding unversioned copies of
# various shell scripts. This unversioned files should contain overrides to
# variables to account for different platforms and/or perhaps secret keys
# which you do not want to version.
loadLocalCopyOfScript() {
    if [ "$#" -lt 1 ]; then
        echo "Incorrect usage of command"
        echo "Usage:"
        echo "$FUNCNAME <PATH TO FILE>"
        echo "e.g. $FUNCNAME ~/.bashrc"
        return
    fi
	local script_path="$1";
	local script_dir="$(dirname "$1")"
	local script_name="$(basename "$1")"
	local unversioned_script_name="${script_dir}/${script_name}.local_unversioned";

	if [ -f $unversioned_script_name ]; then
		echo "File existed. Loading.";
		. $unversioned_script_name
	else
		echo "File did not exist, creating it: $unversioned_script_name";
		touch $unversioned_script_name
	fi
}

shuffle() {
    awk 'BEGIN{srand();} {printf "%06d %s\n", rand()*1000000, $0;}' | sort -n | cut -c8-
}

function debugPrint() {
    echo -e "LOG::: $@"
}

function debugPrintWithArg() {
    local msg="${@:2}"
    if $1 ; then
        debugPrint "$msg"
    fi
}

# Sometimes you need to run a command from a very different place to where you are.
# Provide this command with a directory and the command you want to run, and it will jump there
# run it and return.
function runCmdFrom() {
    if [ -z "${DEBUG_RUN_CMD_FROM+x}" ]; then
        DEBUG_RUN_CMD_FROM=false
    fi

    function localDebugPrint() {
        if $DEBUG_RUN_CMD_FROM ; then
            debugPrint "$@"
        fi
    }

    if [[ "$#" -lt 2 ]]; then
        echo "You did not provide the correct number of parameters"
        echo "Correct usage: $FUNCNAME <PATH> <COMMAND>"
        echo "Example: $FUNCNAME $(svnbasedir.sh) svn up"
        return
    fi

    local pathToRunFrom=$1;
    local cmdToRun="${@:2}"

    localDebugPrint "Path to run from: $pathToRunFrom";
    localDebugPrint "Cmd to run there: $cmdToRun\n";

    pushd $pathToRunFrom > /dev/null
    	eval $cmdToRun
    popd > /dev/null
}

# return {Number}
_checkForHelpFlag() {
    local callingFuncName=$1;
    local param=$2;

    if [ "$param" == "--help" ]; then
        _displayHelpText "$callingFuncName";
        return 1;
    fi

    return 0;
}

_displayHelpText() {
    local callingFuncName=$1;
    local helpFuncName="_${callingFuncName}Help"
    local helpText=${!helpFuncName}

    # Going to eventually convert the help text into different format (styling/coloring)
    echo "$helpText";
}
