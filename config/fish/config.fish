
# GENERAL
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8 LANGUAGE=en.UTF-8
set -x HOMEBREW_CASK_OPTS '--appdir=/Applications --fontdir=/Library/Fonts'

set PROMPT_TITLE 'echo -ne "\033]0;$USER@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'

set -x PROMPT_COMMAND "$PROMPT_TITLE; $PROMPT_COMMAND"

. $HOME/.alias

register-python-argcomplete --shell fish pipx | .

# egrep "^export " ~/.profile | while read e
# 	  set var (echo $e | sed -E "s/^export ([A-Za-z_]+)=(.*)\$/\1/")
# 	  set value (echo $e | sed -E "s/^export ([A-Za-z_]+)=(.*)\$/\2/")

# 	  # remove surrounding quotes if existing
# 	  set value (echo $value | sed -E "s/^\"(.*)\"\$/\1/")

# 	  if test $var = "PATH"
# 		    # replace ":" by spaces. this is how PATH looks for Fish
# 		    set value (echo $value | sed -E "s/:/ /g")

# 		    # use eval because we need to expand the value
# 		    eval set -xg $var $value

# 		    continue
# 	  end

# 	  # evaluate variables. we can use eval because we most likely just used "$var"
# 	  set value (eval echo $value)

# 	  #echo "set -xg '$var' '$value' (via '$e')"
# 	  set -xg $var $value
# end

# status --is-interactive; and pyenv init - | source
# status --is-interactive; and pyenv virtualenv-init - | source

kitty + complete setup fish | source
set -g fish_user_paths /usr/local/sbin $fish_user_paths
set -g fish_user_paths ~/.dotfiles/bin /usr/local/Caskroom/miniconda/base/bin /usr/local/Caskroom/miniconda/base/condabin $HOME/.local/bin $fish_user_paths

# set -g GTK_DEBUG interactive waybar

# eval (ssh-agent -c)

eval (direnv hook fish)

# vterm for emacs
function vterm_printf;
    if [ -n "$TMUX" ]
        # tell tmux to pass the escape sequences through
        # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
        printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
    else if string match -q -- "screen*" "$TERM"
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$argv"
    else
        printf "\e]%s\e\\" "$argv"
    end
end

function vterm_prompt_end;
    vterm_printf '51;A'(whoami)'@'(hostname)':'(pwd)
end
functions -c fish_prompt vterm_old_fish_prompt
function fish_prompt --description 'Write out the prompt; do not replace this. Instead, put this at end of your file.'
    # Remove the trailing newline from the original prompt. This is done
    # using the string builtin from fish, but to make sure any escape codes
    # are correctly interpreted, use %b for printf.
    printf "%b" (string join "\n" (vterm_old_fish_prompt))
    vterm_prompt_end
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /usr/local/Caskroom/miniconda/base/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
