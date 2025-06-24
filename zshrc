autoload -U colors
autoload -U compinit
autoload -U edit-command-line

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt APPEND_HISTORY            # append to history file (Default)
setopt HIST_NO_STORE             # Don't store history commands
# setopt HIST_STAMPS="yyyy-mm-dd"

plugins=(git fzf)

setopt COMPLETE_IN_WORD
setopt AUTO_CD
setopt NO_BEEP
setopt prompt_subst
setopt autopushd
setopt pushdminus
setopt pushdsilent
setopt pushdtohome

colors
compinit

DIRSTACKSIZE=8
MAILCHECK=0

EDITOR=vim

# source "$HOME/.zsh/aliases.zsh"
# source "$HOME/.zsh/completion.zsh"
# source "$HOME/.zsh/edit_command_line.zsh"
# source "$HOME/.zsh/tmux.zsh"
# source "$HOME/.zsh/git.zsh"
# source "$HOME/.zsh/prompt.zsh"
# source "$HOME/.zsh/rbenv.zsh"
# source "$HOME/.zsh/rust.zsh"
# source "$HOME/.zsh/rsvm.zsh"
# source "$HOME/.zsh/golang.zsh"
# source "$HOME/.zsh/rust.zsh"
# source "$HOME/.zsh/less.zsh"

# # Source any extra config that should not be
# # in the public dotfiles repo
# if [ -f "$HOME/.zsh/extras.zsh" ]; then
#   source "$HOME/.zsh/extras.zsh"
# fi
# 
# if (( $+commands[direnv] )); then
#   eval "$(direnv hook zsh)"
# fi

# Up/Down history completion
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# This makes virtualenvs work
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
# eval "$(pyenv init -)"
# eval "$(pyenv init --path)"
# eval "$(pyenv virtualenv-init -)"

# This makes some of the pip3 builds work
# export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/bzip2/lib" # BZIP
export LDFLAGS="-L/usr/local/opt/zlib/lib -L/usr/local/opt/openssl@1.1/lib"
export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig:/usr/local/opt/openssl@1.1/lib/pkgconfig:/usr/local/opt/zlib/lib/pkgconfig"
export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/openssl@1.1/include"
# export CPPFLAGS="-I/usr/local/opt/zlib/include -I/usr/local/opt/bzip2/include" # BZIP
export GRPC_PYTHON_BUILD_SYSTEM_OPENSSL=1
export GRPC_PYTHON_BUILD_SYSTEM_ZLIB=1

export VAULT_ADDR='https://vault.hellofresh.io'

alias vault_login='vault login -method=oidc'
alias k='kubectl'
alias grep='grep --color=auto -I' # Use color where sensible, ignore binary files
blackdiff(){
    vimdiff $1 <(black - < $1)
}
alias jsbeautify='python3 -c "import jsbeautifier, sys; print(jsbeautifier.beautify(sys.stdin.read()))"'

# K8s config. Installed by ~/hf-kubernetes/eks/eksconfig.sh
resetkube(){
    pushd ~/hf-kubernetes/
    git checkout master && git pull
    bash eks/eksconfig.sh
    popd
}

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"

# Fun function to enable piping to and from paste buffer
pbfilter() {
  if [ $# -gt 0 ]; then
      pbpaste | "$@" | pbcopy
  else
      pbpaste | pbcopy
  fi
} 

tmpenv(){
    version=$(ls ~/.pyenv/versions | grep '\.' | fzf)
    echo 'Name for env?'
    read name
    pyenv virtualenv $version $name
    pyenv activate $name
}

alias yless="jless --yaml"
alias aws-whoami="aws sts get-caller-identity"
fixcreds(){
    pbpaste | sed 's/^\[.*$/[default]/g' > ~/.aws/credentials
    echo "Saved credentials to ~/.aws/credentials"
}

# Not sure what this does
export GO111MODULE=on

# Really nice side-by-side log of changes
alias nicelog="git log -p | ydiff -s -w 0"

#
# Some git aliases
#
alias ga="git add"
alias gd="git diff"
alias gp="git push"
alias gck="git checkout"
alias gs="git status"
alias gcm="git commit"
alias gdt="git difftool"
alias jpath="jq -r 'paths(scalars | true) as \$p  | [ ( [ \$p[] | tostring ] | join(\".\") ), ( getpath(\$p) | tojson )] | join(\": \")'"
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --"


export KUBECONFIG=$HOME/.kube/config:$HOME/.kube/eksconfig

cd $HOME
