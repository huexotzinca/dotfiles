HUXBASHRC_PATH="${BASH_ARGV[0]}"
HUXBASHRC_DIRNAME="$(dirname $HUXBASHRC_PATH)"
HUXBASH_DIRNAME="$HUXBASHRC_DIRNAME/bash"
HUXSCM_DIRNAME="$HUXBASHRC_DIRNAME/scm"
HUXSERVER_NAME="huexotzin.ca"

if [ -f $HUXBASH_DIRNAME/colors ]; then
    . $HUXBASH_DIRNAME/colors
fi

if [ -f $HUXBASH_DIRNAME/config ]; then
    . $HUXBASH_DIRNAME/config
fi

if [ -f $HUXBASH_DIRNAME/env ]; then
    . $HUXBASH_DIRNAME/env
fi

if [ -f $HUXBASH_DIRNAME/aliases ]; then
    . $HUXBASH_DIRNAME/aliases
fi

if [ -f $HUXBASH_DIRNAME/functions ]; then
    . $HUXBASH_DIRNAME/functions
fi

if [ -f $HUXSCM_DIRNAME/git-completion.bash ]; then
    . $HUXSCM_DIRNAME/git-completion.bash
fi
