# shellcheck disable=2148,2034,2155,1091,2086,1094
# ================ #
# Basic ZSH Config #
# ================ #

# Additional PATHs
export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/.bin:$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="$HOME/.cargo/bin:${PATH}"
export PATH="$HOME/.local/share/neovim/bin:$PATH" # for bob
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="mosherussell"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="false"
DISABLE_UNTRACKED_FILES_DIRTY="true"
export GPG_TTY=$(tty)

# Set Locale
export LANG=en_US
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# History settings
HISTSIZE=5000
SAVEHIST=5000
setopt BANG_HIST              # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY       # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY            # Don't execute immediately upon history expansion.
setopt HIST_BEEP              # Beep when accessing nonexistent history.
# setopt HIST_IGNORE_SPACE      # Don't record an entry starting with a space.

plugins=(
  ag
  aliases
  ansible
  asdf
  autoupdate
  aws
  branch
  colored-man-pages
  command-not-found
  common-aliases
  dircycle
  docker
  git
  git-auto-fetch
  helm
  kube-ps1
  kubectl
  terraform
  z
  zsh-autosuggestions
  zsh-github-copilot
  zsh-syntax-highlighting
)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh
[ -f $HOME/.fzf.zsh ] && source $HOME/.fzf.zsh

# =================== #
# Completions and PS1 #
# =================== #

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Terraform completion
complete -o nospace -C /usr/local/bin/terraform terraform
compdef tf='terraform'
compdef tg='terraform'
compdef terragrunt='terraform'

# Source azure-cli completion
[[ -f /opt/homebrew/etc/bash_completion.d/az ]] && source /opt/homebrew/etc/bash_completion.d/az

# ===================== #
# Aliases and Functions #
# ===================== #
if [[ -f $HOME/aliases.sh ]]; then
  source $HOME/aliases.sh
fi
[[ -f $HOME/corp-aliases.sh ]] && source $HOME/corp-aliases.sh

export EDITOR="nvim"
bindkey '^[|' zsh_gh_copilot_explain # bind Alt+shift+\ to explain
bindkey '^[\' zsh_gh_copilot_suggest # bind Alt+\ to suggest

# ================ #
# Kubectl Contexts #
# ================ #

# Load all contexts
export KUBECONFIG=$HOME/.kube/config
# context_files=$(
#   setopt nullglob dotglob
#   echo $HOME/.kube/contexts/*
# )
# if ((${#context_files})) && [[ -d $HOME/.kube/contexts/ ]]; then
#   ALL_CONTEXTS=$(awk -vRS=" " '{printf "%s%s",sep,$0;sep=":"}' <<<$(echo ~/.kube/contexts/*.yaml))
#   export KUBECONFIG=${KUBECONFIG}:${ALL_CONTEXTS}
# fi

export KUBECTL_EXTERNAL_DIFF="kdiff"
export KUBERNETES_EXEC_INFO='{"apiVersion": "client.authentication.k8s.io/v1beta1"}'

# Load starship last
eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
alias sub="/Users/ofekn/scripts/bash-scripts/deploy-spotdeploy/text_sub.sh"
alias addspc="/Users/ofekn/scripts/bash-scripts/spc-create.sh"
alias repos="cd /Users/ofekn/github"
alias scriptsb="cd /Users/ofekn/scripts/bash-scripts"
alias scriptspy="cd /Users/ofekn/scripts/python-scripts"
alias awsprod="export AWS_PROFILE=prod"
alias awsdev="export AWS_PROFILE=dev"
alias rmtgtrace="rm -f aws-provider.tf backend.tf terragrunt_variables.tf versions.tf .terraform.lock.hcl"
alias ssv=/usr/local/bin/ssv.sh
alias ssv=/usr/local/bin/ssv.sh
alias azure-ssm=/Users/ofekn/scripts/bash-scripts/add-parmas-azure.sh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ofekn/gcloudcli/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ofekn/gcloudcli/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ofekn/gcloudcli/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ofekn/gcloudcli/google-cloud-sdk/completion.zsh.inc'; fi
