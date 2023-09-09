# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

ZSH_DISABLE_COMPFIX="true"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode)

source $ZSH/oh-my-zsh.sh


# ENV secrets
export DOGFOOD_WRITEKEY=""
source ~/secrets.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.bin:$PATH"

export EDITOR='nvim'
export GIT_EDITOR='nvim'

# jump jump!
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# ----- ALIAS -----
# to ignore the alias and run actual vim '\vim'
alias vim="nvim"
alias edit="nvim"
alias now="vercel"
alias editzsh="vim ~/.zshrc && source ~/.zshrc"
alias catzsh="cat ~/.zshrc"
alias :qall="exit"
alias xit="exit"

alias at="tmux at"

# copy last command run 
alias copy_cmd="fc -ln -1 | pbcopy"


# --- git helpers ----
alias prune="git branch | grep -v 'main' | xargs git branch -D"
alias amendit="git commit --amend --no-edit"
alias gpof="git push origin head --force-with-lease"
alias rewind="git reset HEAD~1"

alias list_branches="git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format='%(refname:short) %(committerdate:relative)'"

#

alias saveaudio="youtube-dl -o '~/Desktop/music/%(title)s-%(id)s.%(ext)s' --restrict-filenames --add-metadata -x --audio-format m4a"
alias savevideo="youtube-dl -o '~/Desktop/videos/%(title)s-%(id)s.%(ext)s' --restrict-filenames --add-metadata --write-sub"

alias cat="bat"

# so sudo vim actually runs sudo nvim
# https://unix.stackexchange.com/questions/710187/how-do-i-make-an-alias-for-a-command-with-sudo
alias sudo="sudo "

# ----------------------
#  Note taking assists 
# ----------------------

alias notes="t notes"

# TODO: add optional project/tag
# use template depending on project/tag?
# could also do some checking to see if a file exists w/in same week, and use
# that instead of whipping up a new one
function note() {
  if [ -z "$1" ]; then 
    vim ~/notes/$(date -v -Mon "+%Y-%m-%d").md -c w
  else 
    vim ~/notes/$(date "+%Y-%m-%d")-$1.md -c w
  fi

}


alias w_date="$(print date -v -Mon "+%Y-%m-%d")"
function qn() {
  if [ -z "$1" ]; then 
    vim ./$(date -v -Mon "+%Y-%m-%d").md -c w
  else 
    vim ./$(date "+%Y-%m-%d")-$1.md -c w
  fi

}

function todo {
    vim ~/notes/todo/$(date -v -Mon "+%Y-%m-%d").md -c w
}

function git-todo {
  project=$(basename $PWD)
  branch=$(eval git rev-parse --abbrev-ref HEAD)

  vim ~/notes/todo/$(date -v -Mon "+%Y-%m-%d")-$project-$branch.md -c w

}

#TODO add PR when it is opened?
function branch-notes() {
  project=$(basename $PWD)
  branch_file=$(eval git rev-parse --abbrev-ref HEAD).md

  mkdir -p ~/notes/repos/$project
  cd ~/notes/repos/$project

  existing_note=$(ls | grep $branch_file)

  if [ ! -z "$existing_note" ]; then
    echo -e "\n\n$(date "+%Y-%m-%d")" >> $existing_note

    vim $existing_note
  else
    vim $(date "+%Y-%m-%d")-${branch_file}
  fi

  cd $OLDPWD
}


# ----------------------
#  Tmuxinator helpers
# ----------------------

function t() {
  if [ -z "$1" ]; then
    project=$(basename $PWD)
    # if [ project = "doximity-client-vue" ]; then
      # project="vue"
    # fi
    launch_tmux_project "$project"
  else
    launch_tmux_project "$1"
  fi
}

function launch_tmux_project() {
  # if there is a tmuxinator project file that matches 
  # the directory name, use it. otherwise launch w/ scaffolding
  if tmuxinator list | grep "$1"; then
    tmuxinator start "$1" && exit
  else
    tmuxinator start scaffold -n "$1" workspace=$PWD && exit
  fi
}



# ----------------------
#  Honeycomb specific things
#  TODO move to own file; export in
# ----------------------

# alias to sparse-checkout of hound. only the docs. so can
# keep drafts as i work without attaching to specific branch
# later, should hook up w/ markdown preview and launch from there
# perhaps

alias "go-docs"=cd "$HOME/workbench/poodle-docs/cmd/poodle/docs"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
export BASENJI_ROOT="$HOME/workbench/basenji/"

alias tilt="cd ~/workbench/hound && tilt" 
alias besttilt="tilt args -- --webpack-dev-server"

unalias gsts # ohmyzsh has a git alias that smashes gsts cli tool

# gsts/aws fun
export AWS_PROFILE=sts
export GOOGLE_SP_ID=456279060050
export GOOGLE_IDP_ID=C01jgaetc
export HNYUSER="ashleyrobinson"
alias prodaccess="gsts --aws-role-arn arn:aws:iam::702835727665:role/product --username=$HNYUSER@honeycomb.io"


alias pdocs="cd ~/workbench/poodle-docs/cmd/poodle/docs/"


# strip off :line-number from the end of vim ,C output and start running yarn watch
function watch() {
  file=$1
  cd ~/workbench/hound/cmd/poodle/ && yarn jest --watch ${file/:*/}
}
#—-------------------------------
#
# Poodle Local Dev Aliases & Things
#
#—-—----------------—---------------

# satellite team
export DEV_WRITEKEY=$DOGFOOD_WRITEKEY
export SATELLITE_URL="https://api-dogfood.honeycomb.io"

# "normal" team
export FREE_API="aECV7VDfGHVCKieQZeKKxC"
export FREE_API_URL=http://localhost:8081

# Some of the code uses a lot of connections
# comment this out if you don't want things to be slow
# export LIBHONEY_URL=$FREE_API_URL
# export LIBHONEY_WRITE_KEY=$FREE_API

# export LIBHONEY_URL=$BASENJI_URL
# export LIBHONEY_WRITE_KEY=$BASENJI_KEY
ulimit -n 8192


# generate a ton of data:
# :qall
#

#prelint
prelint () {
LIST=`git diff-index --diff-filter=d --name-only HEAD | grep "\.[tj]s[x]\{0,1\}$" | perl -pe 's/cmd\/poodle\///g'`; 
if [ "$LIST" ]; then cd cmd/poodle; npx eslint --quiet $LIST; fi
}

eval "$(direnv hook zsh)"
. /usr/local/opt/asdf/libexec/asdf.sh



# ----------------------
#  
#  Markdown Preview Helpers
#  
# ----------------------


MARKDOWN_PREVIEW_DIR="~/workbench/markdown-preview"

# `sync_markdown`: copies `*.md` files from the current working directory over 
#     to markdown-preview and watches for changes, updating the copied files 
#     anytime they're modified
#
#     Symlinks unfortunately won't play nicely w/ webpack's hot reloading, and 
#     I failed to figure out a good way to watch files in another directory 
#     direcly, so we copy.

alias sync_markdown="node $MARKDOWN_PREVIEW_DIR/utils/sync -w $PWD"

# `preview_markdown`: starts up the next.js app from anywhere our heart desires
alias preview_markdown="yarn --cwd "$MARKDOWN_PREVIEW_DIR" dev"

# `sync_and_preview`: start syncing & launch the web server in one fell swoop
function sync_and_preview() {
  preview_markdown & sync_markdown
}

# `add_toc`: update toc for file
alias add_toc="yarn --cwd $MARKDOWN_PREVIEW_DIR markdown-toc -i $PWD/"

# `print_toc`: print to console the toc for file
alias print_toc="yarn --cwd $MARKDOWN_PREVIEW_DIR markdown-toc $PWD/"

 
 
#

# Kubectl
klogs () {
	kubectl logs $@ -f $(kubectl get pods $@ | tail -n +2 | fzf | cut -d' ' -f1)
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# git aliases
alias currentBranch="git rev-parse --abbrev-ref HEAD | pbcopy"
alias localBranches="git log --branches --not --remotes --no-walk --decorate"





alias weather="curl 'wttr.in/jersey+city?u'"
