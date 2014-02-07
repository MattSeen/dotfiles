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
    while IFS= read -r LINE; do
        echo "Branch: $LINE";
        echo "Description:"
        echo "$(git config branch."$LINE".description)";
        echo ""
    done
}