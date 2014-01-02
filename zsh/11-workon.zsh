#
# Generic "move me to my project dir" function/alias.
#
# Tries to "workon" a Python virtualenv, then (either way) switches to the
# directory in question.
#
# This means that we can A) use this for non-Python projects, and B) avoid
# having to add the 'cd' call to every. single. virtualenv's postactivate
# script.
#
# Also deactivates any currently active virtualenv, just for neatness' sake.
#

FOLDERS=(
    ~/dev/
    /Volumes/dev/
    ~/Dropbox/Dev/
)

RCFILE=".wkrc"

function wk() {
    # deactivate/workon will fail silently if project is not a virtualenv.
    deactivate 2>/dev/null
    workon $1 2>/dev/null

    # Try to find the given folder and cd to it.
    for folder in $FOLDERS; do
        target=$folder/$1
        if [[ -d $target ]]; then
            $target
            # Also execute any project init file
            if [[ -f $RCFILE ]]; then
                source $RCFILE
            fi
            # Set terminal window title
            echo -n -e "\033]0;$1\007"
            return 0
        fi
    done
    return 1
}

# Completion
function _wk() {
    compadd $(find $FOLDERS -mindepth 1 -maxdepth 1 -type d -exec basename {} \; 2>/dev/null)
}
compdef _wk wk
