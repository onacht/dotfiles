source $ZSH/oh-my-zsh.sh
#export PATH=$PATH:$HOME/bin:/usr/local/bin:$PATH:~/Library/Python/2.7/bin:~/bin:~/.npm-global/bin:${KREW_ROOT:-$HOME/.krew}/bin
export PATH="$HOME/.bin:${KREW_ROOT:-$HOME/.krew}/bin:$HOME/.local/alt/shims:$PATH"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="mosherussell"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="false"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Set Locale
export LANG=en_US
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# History settings
HISTSIZE=5000
SAVEHIST=5000
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
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

plugins=(
  ag
  ansible
  autoupdate
  aws
  colored-man-pages
  common-aliases
  dircycle
  docker
  git
  git-auto-fetch
  helm
  kubectl
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Load zsh-completions
if type brew &>/dev/null; then
  fpath=( $(brew --prefix)/share/zsh-completions $fpath )

  # rm -f ~/.zcompdump* &>/dev/null || :
  autoload -Uz compinit
  compinit
fi

# Source kube_ps1
if [[ -f /usr/local/opt/kube-ps1/share/kube-ps1.sh ]];then
  source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
  function get_cluster_short() {
    echo "$1" | gsed -e 's?arn:aws:eks:[a-zA-Z0-9\-]*:[0-9]*:cluster/??g' -e 's?\.k8s\.local??g'
  }
KUBE_PS1_CLUSTER_FUNCTION=get_cluster_short
fi

if [[ -f ~/aliases.sh ]];then
  source ~/aliases.sh
fi

autoload -U +X bashcompinit && bashcompinit
alias vim="nvim"
export EDITOR="nvim"
alias sudoedit="nvim"
alias sed=gsed
alias mdl='mdless README.md'
alias tf='terraform'
alias dotfiles='cd ~/Repos/dotfiles'
alias kgnol='kgno -l'
alias v='vim'
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
alias -g Wt='while :;do '
alias -g Wr=' | while read -r line;do '
alias -g D=';done'
alias -g Sa='--sort-by=.metadata.creationTimestamp'
alias -g SECRET='-ojson | jq ".data | with_entries(.value |= @base64d)"'
function get_pods_of_svc() {
  svc_name=$1
  shift
  label_selectors=$(kubectl get svc $svc_name $* -ojsonpath="{.spec.selector}" | jq -r "to_entries|map(\"\(.key)=\(.value|tostring)\")|.[]" | paste -s -d "," -)
  kubectl get pod $* -l $label_selectors
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Kubectl contexts
alias cinfo='kubectl cluster-info'
alias ctx='kubectx '
export KUBECONFIG=~/.kube/config
for ctx in ~/.kube/contexts/*.config;do
  export KUBECONFIG=${KUBECONFIG}:${ctx}
done

cnf() { open "https://command-not-found.com/$*" }

export KUBECTL_EXTERNAL_DIFF="kdiff"

bookitmeinit() {
  cd ~/Repos/bookitme
  export KUBECONFIG=~/Repos/bookitme/bookitme-k8s.yaml
  source ~/Repos/bookitme/bookitme-terraform/.env
  kgp
}

# argocd
if command -v argocd > /dev/null;then
  source <(argocd completion zsh)
fi
