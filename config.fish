switch (uname)
case Linux
  set -x PATH $HOME/.linuxbrew/bin $PATH
  set -x MANPATH $HOME/.linuxbrew/share/man $MANPATH
  set -x INFOPATH $HOME/.linuxbrew/share/info $INFOPATH
case Darwin
  set -x PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin /Library/TeX/texbin $HOME/.dotfiles/tex $HOME/.bin $PATH
  # JAVA
  set -x PATH $JAVA_HOME/jre/bin $PATH
end

# GENERAL
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8 LANGUAGE=en.UTF-8
set -x HOMEBREW_CASK_OPTS '--appdir=/Applications --fontdir=/Library/Fonts'

set PROMPT_TITLE 'echo -ne "\033]0;$USER@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
set -x PROMPT_COMMAND "$PROMPT_TITLE; $PROMPT_COMMAND"

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

bind \cj "commandline -f accept-autosuggestion execute"

. $HOME/.alias

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
eval (/Users/oguzserbetci/.pyenv/versions/3.7.2/envs/tools/bin/python -m virtualfish projects auto_activation compat_aliases)

set -U FZF_LEGACY_KEYBINDINGS 0
