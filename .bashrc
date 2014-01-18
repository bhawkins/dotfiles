# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Might source this file as a different user, so don't depend on HOME.
MYHOME=~bhawkins

# source the .alias file if it exists
test -s ~/.alias && . ~/.alias || true

# Interactive prompt.
if [ -n "$PS1" ]; then
    if [ -f $MYHOME/.bash_prompt ]; then
        source $MYHOME/.bash_prompt
    else
        export PS1="[\!] \h:\W> "
    fi
fi

# Make directory listings colorful.
# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then
    # GNU `ls`
    alias ls="ls --color=auto"
elif ls -G > /dev/null 2>&1 ; then
    # OS X `ls`
    alias ls="ls -G"
elif [ -s $MYHOME/gnu/bin/ls ] ; then
    # Check to see if I compiled GNU coreutils before giving up.
    alias ls="$MYHOME/gnu/bin/ls --color=auto"
fi
# Change directory coloring from dark blue to grey for better readability on
# dark backgrounds.
export LS_COLORS="ow=01;90:di=01;90"

# Use my vim settings even as another user.
alias vi="vim -u $MYHOME/.vimrc"

# Use sensible units for memory totals in top (too many KB!).
alias top="top -M"

function vw {
   vi `which $1`
}

# Default permissions.
#umask 002

# Variables for git commits.  Useful to override defaults in case I'm on
# another account.
export GIT_AUTHOR_NAME="Brian Hawkins"
export GIT_AUTHOR_EMAIL="Brian.P.Hawkins@jpl.nasa.gov"

export EDITOR=/usr/bin/vim

function whoson {
    who | awk '{print $1}' | sort | uniq
}

# Run these commands for interactive python sessions.
export PYTHONSTARTUP=$MYHOME/.pythonstartup
