
source $(brew --prefix)/share/antigen/antigen.zsh

antigen use oh-my-zsh
antigen bundle sublime
antigen bundle gitignore
antigen bundle brew
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle git
antigen theme pure

antigen apply

plugins=(git sublime gitignore python brew colorize brew-cask)

# ALIASES
alias zshconfig="s ~/.zshrc"
alias finder="open -R"
alias s="subl"
alias sn="subl -n"
alias j="jupyter notebook"
alias sm="s --project /Users/oguzserbetci/Library/Mobile\ Documents/com~apple~CloudDocs/note-taking.sublime-project"
alias kbot="kibana -e https://c1ikqwa6:c2b3r0bieoetuzes@elm-9177573.eu-west-1.bonsai.io"
alias kbot-s="kibana -e https://tulndj3z:3xucczja3elbwlm3@birch-5017864.eu-west-1.bonsai.io"
alias d="dirs -v"
alias -g S="| subl -"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ls="command ls ${colorflag}"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# KEYS
bindkey -e
bindkey '^[[1;9C' forward-word
bindkey '^[[1;9D' backward-word

# TERMINAL OPTIONS
HYPHEN_INSENSITIVE="true"
# ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd/mm/yyyy"

export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'

export ZSH=/Users/oguzserbetci/.oh-my-zsh
export JAVA_HOME=$(/usr/libexec/java_home)

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH=~/Library/Developer/Toolchains/swift-DEVELOPMENT-SNAPSHOT-2016-05-09-a.xctoolchain/usr/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$JAVA_HOME/jre/bin:~/anaconda3/bin:/Applications/Postgres.app/Contents/Versions/latest/bin:/Users/oguzserbetci/dev/corpus/TreeTagger/cmd:/Users/oguzserbetci/dev/corpus/TreeTagger/bin

export STANFORDTOOLSDIR=/Users/oguzserbetci/dev/stanford-postagger-full-2015-12-09
export CLASSPATH=/Users/oguzserbetci/dev/stanford-postagger-full-2015-12-09/stanford-postagger-3.6.0.jar:/Users/oguzserbetci/dev/stanford-postagger-full-2015-12-09/stanford-postagger.jar
export STANFORD_MODELS=/Users/oguzserbetci/dev/stanford-postagger-full-2015-12-09/models

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='subl'
fi
