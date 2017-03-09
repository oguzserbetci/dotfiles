if [ "$(uname 2> /dev/null)" != "Linux" ]; then
  export PATH="$HOME/.linuxbrew/bin:$PATH"
  export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
  export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
else
  export PATH=$PATH/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$JAVA_HOME/jre/bin:~/anaconda3/bin:/Applications/Postgres.app/Contents/Versions/latest/bin:/Library/TeX/texbin
fi

source $(brew --prefix)/share/antigen/antigen.zsh

antigen use oh-my-zsh

antigen bundle git
antigen bundle brew
antigen bundle python
antigen bundle sublime
antigen bundle colorize
antigen bundle brew-cask
antigen bundle gitignore

antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

antigen bundle zsh-users/zsh-completions
antigen bundle psprint/zsh-navigation-tools
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search

antigen apply


#########
# OHMYZSH

HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd/mm/yyyy"
setopt NO_BEEP
setopt SHARE_HISTORY
setopt APPEND_HISTORY

#########
# ALIASES

alias zshconfig="s ~/.zshrc"
alias finder="open -R"
alias s="subl"
alias sn="subl -n"
alias sm="s --project /Users/oguzserbetci/Library/Mobile\ Documents/com~apple~CloudDocs/note-taking.sublime-project"
alias j="tmux new -s jupyter -d;tmux send-keys -t jupyter 'jupyter notebook' C-m"

alias vim="nvim"
alias d="dirs -v"
alias -g S="| subl -"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls="command ls -G"

# GIT
alias gs="git status -s"
alias ga="git add--interactive"
alias gc="git checkout"

# PYTHON
alias p3="python3"
alias p="python"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles YES && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles NO && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# WORKFLOWS
alias doml="open 'https://isis.tu-berlin.de/course/view.php?id=8410'; open ~/University/Machine\ Learning\ 1; atom -n ~/University/Machine\ Learning\ 1/exercises"


######
# KEYS

bindkey '^[[1;9D' backward-word # iterm
bindkey '^[^[[D' backward-word # tmux os x
bindkey '^[[1;3D' backward-word # tmux ubuntu

bindkey '^[[1;9C' forward-word # iterm
bindkey '^[^[[C' forward-word # tmux os x
bindkey '^[[1;3C' forward-word # tmux ubuntu

bindkey '^[[H' beginning-of-line # iterm
bindkey '^[[1~' beginning-of-line # tmux

bindkey '^[[F' end-of-line # iterm
bindkey '^[[4~' end-of-line # tmux


########
# OTHERS

autoload -U colors
colors
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

export ZSH=~/.oh-my-zsh
export JAVA_HOME=$(/usr/libexec/java_home)

export LC_ALL=C
export LANG=en_US.UTF-8
export PYTHONIOENCODING=utf-8


if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='atom'
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
