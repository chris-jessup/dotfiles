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
eval "$(pyenv init -)"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

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
alias grep='grep --color=auto -I' # Use color where sensible, ignore binary files
blackdiff(){
    vimdiff $1 <(black - < $1)
}
alias jsbeautify='python3 -c "import jsbeautifier, sys; print(jsbeautifier.beautify(sys.stdin.read()))"'

# K8s config. Installed by ~/hf-kubernetes/eks/eksconfig.sh
export KUBECONFIG=$HOME/.kube/config:$HOME/.kube/eksconfig

cd $HOME
