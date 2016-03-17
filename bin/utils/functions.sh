
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
	local unversioned_script_name="${script_dir}/${script_name}local";

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
