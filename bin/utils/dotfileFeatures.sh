FEATURE_FILE_PATH="${DOTFILE_DIR}/.FEATURES"
if [ -f $FEATURE_FILE_PATH ]; then
	echo "Found the .FEATURES file"
else
	echo "Did not find the .FEATURES file"

	touch $FEATURE_FILE_PATH;

	echo "USING_GIT=false;" >> "$FEATURE_FILE_PATH";
	echo "USING_SVN=false;" >> "$FEATURE_FILE_PATH";
	echo "USING_LIBS=false;" >> "$FEATURE_FILE_PATH";
	echo "USING_AUTOCOMPLETE=false;" >> "$FEATURE_FILE_PATH";
fi

echo "Loading the feature files";
. $FEATURE_FILE_PATH;

if $USING_LIBS; then
	source $DOTFILE_DIR/bin/libs/.using
fi

if $USING_GIT; then
	source $DOTFILE_DIR/bin/git_scripts/.using
fi

if $USING_SVN; then
	source $DOTFILE_DIR/bin/svn_scripts/.using
fi

if $USING_AUTOCOMPLETE; then
	source $DOTFILE_DIR/bin/auto_complete/.using
fi
