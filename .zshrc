###########
# PLUG
export PATH=$HOME/bin:$PATH
export ZPLUG_HOME=/usr/local/opt/zplug

if [ $(uname) = "Linux" ]; then
  export PATH=$HOME/.linuxbrew/bin:$PATH
  export MANPATH=$HOME/.linuxbrew/share/man:$MANPATH
  export INFOPATH=$HOME/.linuxbrew/share/info:$INFOPATH
else
  export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/TeX/texbin:$HOME/.dotfiles/.tex
  # JAVA
  export PATH=$JAVA_HOME/jre/bin:$PATH
  # Tcl/tk for RST analysis
  export PATH=/usr/local/opt/tcl-tk/bin:$PATH
fi

if [ $(brew --prefix) ]; then
  source $ZPLUG_HOME/init.zsh

  zplug "mafredri/zsh-async", from:github

  zplug "zsh-users/zsh-completions"
  zplug "lib/completion", from:oh-my-zsh
  zplug "psprint/zsh-navigation-tools"
  zplug "djui/alias-tips"
  zplug "zsh-users/zsh-autosuggestions"
  bindkey '^k' autosuggest-accept
  bindkey '^j' autosuggest-execute
  zplug "zsh-users/zsh-syntax-highlighting"
  zplug "zsh-users/zsh-history-substring-search"
  bindkey '^R' history-incremental-search-backward
  zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

  zplug load
fi

###########
# ZSH
  HYPHEN_INSENSITIVE='true'
  ENABLE_CORRECTION='true'
  COMPLETION_WAITING_DOTS='true'
  HIST_STAMPS='dd/mm/yyyy'
  ZSH_AUTOSUGGEST_USE_ASYNC='true'

  autoload -U colors zsh-mime-setup select-word-style
  autoload colors
  colors          # colors
  zsh-mime-setup  # run everything as if it's an executable
  select-word-style bash # ctrl+w on words

  # COMPLETION
  autoload -U compinit
  compinit
  zmodload -i zsh/complist
  setopt hash_list_all            # hash everything before completion
  setopt completealiases          # complete alisases
  setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word    
  setopt complete_in_word         # allow completion from within a word/phrase
  setopt correct                  # spelling correction for commands
  setopt list_ambiguous           # complete as much of a completion until it gets ambiguous.

  # HISTORY
  HISTFILE=~/.zsh_history         # where to store zsh config
  HISTSIZE=100000                 # big history
  SAVEHIST=100000                 # big history
  setopt append_history           # append
  setopt hist_reduce_blanks       # trim blanks
  setopt hist_verify              # show before executing history commands
  setopt inc_append_history       # add commands as they are typed, dont wait until shell exit
  setopt share_history            # share hist between sessions
  setopt bang_hist                # !keyword

  fpath=(/usr/local/share/zsh-completions $fpath)

  setopt NO_BEEP
  setopt SHARE_HISTORY
  setopt APPEND_HISTORY

#########
# ALIASES
  alias zshconfig='s ~/.zshrc'
  alias finder='open -R'
  alias op='openn'
  alias s='subl'
  alias sn='subl -n'
  alias sm='s --project /Users/oguzserbetci/Library/Mobile\ Documents/com~apple~CloudDocs/note-taking.sublime-project'
  alias j='tmux new -s jupyter -d;tmux send-keys -t jupyter "cd ~; jupyter notebook" C-m'

  alias llt='ls -1t | head -5'

  alias vim='nvim'
  alias wim='vim -c VimwikiIndex'
  alias ipython='ipython --TerminalInteractiveShell.editing_mode=vi'
  alias ipython3='ipython3 --TerminalInteractiveShell.editing_mode=vi'
  alias cleanswp='rm ~/.local/share/nvim/swap/*'
  alias d='dirs -v'
  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
  alias ls='command ls -G'

  # GIT
  alias gs='git status -s'
  alias ga='git add--interactive'
  alias go='git checkout'
  alias gc='git clone'

  # PYTHON
  alias p3='python3'
  alias p='python'

  # Show/hide hidden files in Finder
  alias show='defaults write com.apple.finder AppleShowAllFiles YES && killall Finder'
  alias hide='defaults write com.apple.finder AppleShowAllFiles NO && killall Finder'

  # Hide/show all desktop icons (useful when presenting)
  alias hidedesktop='defaults write com.apple.finder CreateDesktop -bool false && killall Finder'
  alias showdesktop='defaults write com.apple.finder CreateDesktop -bool true && killall Finder'

  # WORKFLOWS
  alias doml='open "https://isis.tu-berlin.de/course/view.php?id=8410"; open ~/University/Machine\ Learning\ 1; atom -n ~/University/Machine\ Learning\ 1/exercises'

  # FIX
  alias ssh='TERM=screen-256color ssh'


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
  #if [ '$TMUX' = '' ]; then tmux; fi
  export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

  export ZSH=~/.oh-my-zsh
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8 LANGUAGE=en.UTF-8
  export PYTHONIOENCODING=utf-8
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
  export PYENV_ROOT=~/.pyenv

  export EDITOR='vim'

  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

##########
# ENV VARS
  export HOMEBREW_CASK_OPTS='--appdir=/Applications --fontdir=/Library/Fonts'

############
# EXTENSIONS

  # https://michael.stapelberg.de/Artikel/zsh_recent_completion
  # 'ctrl-x r' will complete the 12 last modified (mtime) files/directories
  zle -C newest-files complete-word _generic
  bindkey '^Xr' newest-files
  zstyle ':completion:newest-files:*' completer _files
  zstyle ':completion:newest-files:*' file-patterns '*~.*(omN[1,12])'
  zstyle ':completion:newest-files:*' menu select yes
  zstyle ':completion:newest-files:*' sort false
  zstyle ':completion:newest-files:*' matcher-list 'b:=*' # important
export PATH=/usr/local/opt/icu4c/bin:$PATH
