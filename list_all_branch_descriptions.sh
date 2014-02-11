branch_descriptions () {
    get_branch_names | sanitize_names | pretty_print_branch_descriptions
}

get_branch_names () {
    echo "$(git branch | grep '\w')"
}

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