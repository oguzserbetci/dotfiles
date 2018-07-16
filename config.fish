switch (uname)
case Linux
  set -x PATH $HOME/.linuxbrew/bin $PATH
  set -x MANPATH $HOME/.linuxbrew/share/man $MANPATH
  set -x INFOPATH $HOME/.linuxbrew/share/info $INFOPATH
case Darwin
  set -x PATH /usr/local/bin /usr/bin /bin /usr/sbin /sbin /Library/TeX/texbin $HOME/.dotfiles/tex $PATH $HOME/.local/bin $HOME/.bin
  # JAVA
  set -x PATH $JAVA_HOME/jre/bin $PATH
end

# PYENV
status --is-interactive; and source (pyenv init -|psub)
status --is-interactive; and source (pyenv virtualenv-init -|psub)
set -x PYENV_ROOT $HOME/.pyenv

# GENERAL
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8 LANGUAGE=en.UTF-8
set -x EDITOR 'nvim'
set -x HOMEBREW_CASK_OPTS '--appdir=/Applications --fontdir=/Library/Fonts'

set PROMPT_TITLE 'echo -ne "\033]0;$USER@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
set -x PROMPT_COMMAND "$PROMPT_TITLE; $PROMPT_COMMAND"
set -x PIPSI_HOME $HOME/.local/venvs/pipsi/bin

test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

bind \cj "commandline -f accept-autosuggestion execute"

. $HOME/.alias

