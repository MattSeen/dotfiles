# bash command to list all git branch descriptions for you current repository
#
# INSTALL
#
# 1) Download and place in your home directory.
# 2) Create a git alias like follows:
#     describeall = !~/list_all_branch_descriptions.sh
# 
# USAGE
#
# execute "git describeall" (or whatever your alias is) to see a list of all 
# the branch descriptions.

branch_descriptions () {
    get_branch_names | sanitize_names | pretty_print_branch_descriptions
}

get_branch_names () {
    echo "$(git branch | grep '\w')"
}

# Remove the special character for the branch you are currently in and trim
# any whitespace on the branch names.
# Needs to be a clean set of strings to work with pretty print function
sanitize_names () {
    echo "$(sed -e 's/\*//' -e 's/[ ]*//' $1)"
}

pretty_print_branch_descriptions () {
    while IFS= read -r BRANCH_NAME; do
        echo "Branch: $BRANCH_NAME";
        echo "Description:"
        echo "$(git config branch."$BRANCH_NAME".description)";
        echo ""
    done
}

branch_descriptions
