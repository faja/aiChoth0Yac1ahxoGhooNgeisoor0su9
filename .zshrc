# path
typeset -U path                             # set path variable as UNIQUE, run 'typeset +U' to check unique variables
path=(
  /home/mc/.tfenv/bin
  /home/mc/.pyenv/bin
  /home/mc/.gem/ruby/3.0.0/bin
  /home/mc/bin
  /home/mc/bin2

  /home/mc/GitRepos/PERSONAL/shell-helpers/chef
  /home/mc/GitRepos/PERSONAL/shell-helpers/container
  /home/mc/GitRepos/PERSONAL/shell-helpers/k8s
  /home/mc/GitRepos/PERSONAL/shell-helpers/tmux
  /home/mc/GitRepos/PERSONAL/shell-helpers/terraform

  /usr/local/go/bin
  $GOPATH/bin
  $path
)

# prompt
#PS1='%B%F{2}idontcare..%~%f%b %# '
setopt PROMPT_SUBST
PS1='%B%F{2}%~%f%b %# '
RPS1='%(?.[%?].[%F{1}%B%?%f%b])'

# aliases
if [[ -r ~/.zsh/zshaliasrc ]]; then
  . ~/.zsh/zshaliasrc
fi
# bindkeys
bindkey -e
if [[ -r ~/.zsh/zshbindkeys ]]; then
  . ~/.zsh/zshbindkeys
fi

# functions autoload
fpath=(~/.zsh/functions $fpath)
autoload -U ${fpath[1]}/*(:t)

# history
HISTSIZE=1001
SAVEHIST=1000
HISTFILE=~/.history
set -o INC_APPEND_HISTORY
set -o SHARE_HISTORY
set -o HIST_IGNORE_SPACE                    # don't add command to history if it starts with SPACE
set -o HIST_IGNORE_ALL_DUPS

# other options
set -o NO_BEEP
set -o AUTO_CD
set -o EXTENDED_GLOB
typeset -gx GOPATH=~/workspace/gopath

# autocompletion
autoload -U compinit
compinit
zstyle ':completion:*' menu select

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

# environment variables
export EDITOR='vim'
export TERM=xterm-256color

# ssh-agent
if [[ -S /home/mc/.ssh/ssh-agent-i-m-the-only-one ]]; then
  typeset -gx SSH_AUTH_SOCK=/home/mc/.ssh/ssh-agent-i-m-the-only-one
fi

source /home/mc/.zsh/zsh-syntax-highlighting-master/zsh-syntax-highlighting.zsh

# export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export RUBYOPT="-W0"
export JAVA_HOME='/usr/lib/jvm/java-8-openjdk'

# terraform
export TF_PLUGIN_CACHE_DIR=~/.terraform.d
export TF_VAR_infra_secrets_repo=/home/mc/GitRepos/AS/INFRA/infra-secrets/master

# pyenv
export PYENV_ROOT=${HOME}/.pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

# SWITCH
export SWITCH_LINK_DIR=~/bin2

# AS EXPORTS
export AMSDARD_SECRETS_REPO=/home/mc/GitRepos/AS/AMSDARD/amsdard-secrets/master
export AMSDARD_INFRA_REPO=/home/mc/GitRepos/AS/AMSDARD/amsdard-infra/master

export INFRA_SECRETS_REPO=/home/mc/GitRepos/AS/INFRA/infra-secrets
export INFRA_TOOLS_REPO=/home/mc/GitRepos/AS/INFRA/infra-tools
export INFRA_TERRAFORM_REPO=/home/mc/GitRepos/AS/INFRA/infra-terraform

export TF_VAR_infra_secrets_repo=${INFRA_SECRETS_REPO}

export INFRA_USER=${USER}
