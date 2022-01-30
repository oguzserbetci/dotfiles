set -g fish_key_bindings fish_default_key_bindings  # emacs like

source $HOME/.alias

# GENERAL
set -x LC_ALL en_US.UTF-8
set -x LANG en_US.UTF-8 LANGUAGE=en.UTF-8
set -x HOMEBREW_CASK_OPTS '--appdir=/Applications --fontdir=/Library/Fonts'

eval (direnv hook fish)

# Latex

# Development
# set -g PROJECT_HOME $HOME/Workspace
# sient

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/oguz/.local/share/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

eval (pyenv init --path) | source

starship init fish | source

#function ssh
#  /usr/bin/ssh -t $argv "tmux attach || tmux new";
#end

# https://github.com/fish-shell/fish-shell/issues/1511
# Ask if removing more than 5 files
function rm
    set -l threshold 5
    if test (count $argv) -gt $threshold
        echo Do you want to delete (count $argv) files'? [yn] '
        read -l -n1 ans
        string match -qi y -- $ans; or return 0
    end
    command rm $argv
end

# test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

# Created by `userpath` on 2021-03-16 12:33:49
set PATH $PATH /home/oguz/.local/bin
