# GENERAL
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8 LANGUAGE=en.UTF-8
set -x HOMEBREW_CASK_OPTS '--appdir=/Applications --fontdir=/Library/Fonts'

set PROMPT_TITLE 'echo -ne "\033]0;$USER@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'

set -x PROMPT_COMMAND "$PROMPT_TITLE; $PROMPT_COMMAND"

. $HOME/.alias

register-python-argcomplete --shell fish pipx | .

egrep "^export " ~/.profile | while read e
	  set var (echo $e | sed -E "s/^export ([A-Za-z_]+)=(.*)\$/\1/")
	  set value (echo $e | sed -E "s/^export ([A-Za-z_]+)=(.*)\$/\2/")

	  # remove surrounding quotes if existing
	  set value (echo $value | sed -E "s/^\"(.*)\"\$/\1/")

	  if test $var = "PATH"
		    # replace ":" by spaces. this is how PATH looks for Fish
		    set value (echo $value | sed -E "s/:/ /g")

		    # use eval because we need to expand the value
		    eval set -xg $var $value

		    continue
	  end

	  # evaluate variables. we can use eval because we most likely just used "$var"
	  set value (eval echo $value)

	  #echo "set -xg '$var' '$value' (via '$e')"
	  set -xg $var $value
end

status --is-interactive; and pyenv init - | source
status --is-interactive; and pyenv virtualenv-init - | source

set -U FZF_LEGACY_KEYBINDINGS 0

kitty + complete setup fish | source
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths

set -g GTK_DEBUG interactive waybar
