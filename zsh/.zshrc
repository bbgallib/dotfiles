export LANG=ja_JP.UTF-8

if [ -e /opt/homebrew/share/zsh-completions ]; then
  fpath=(/opt/homebrew/share/zsh-completions $fpath)
fi

if command -v brew >/dev/null 2>&1; then
  source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

autoload -Uz compinit
compinit -u

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export JAVA_HOME=$(/usr/libexec/java_home -v "21" 2>/dev/null || true)
if [ -n "$JAVA_HOME" ]; then
  PATH="${JAVA_HOME}/bin:${PATH}"
fi
export PATH="$HOME/Library/Android/sdk/platform-tools:$PATH"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

eval "$(anyenv init -)"
eval "$(gh completion -s zsh)"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'    # 補完候補で、大文字・小文字を区別しないで補完出来るようにするが、大文字を入力した場合は区別する
zstyle ':completion:*' ignore-parents parent pwd ..    # ../ の後は今いるディレクトリを補間しない
zstyle ':completion:*:default' menu select=1           # 補間候補一覧上で移動できるように
zstyle ':completion:*:cd:*' ignore-parents parent pwd  # 補間候補にカレントディレクトリは含めない

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=1000000

setopt share_history           # 履歴を他のシェルとリアルタイム共有する
setopt hist_ignore_dups        # 重複を記録しない
setopt hist_ignore_all_dups    # 同じコマンドをhistoryに残さない
setopt hist_ignore_space       # historyに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks      # historyに保存するときに余分なスペースを削除する
setopt hist_save_no_dups       # 重複するコマンドが保存されるとき、古い方を削除する
setopt inc_append_history      # 実行時に履歴をファイルに追加していく
setopt print_eight_bit         # 日本語ファイル名を表示可能にする
setopt no_flow_control         # フローコントロールを無効にする
setopt auto_cd                 # ディレクトリ名だけでcdする
setopt auto_menu               # 補完候補が複数ある時に自動的に一覧表示する
setopt list_packed             # 補完候補を詰めて表示
setopt correct                 # コマンドのスペルを訂正

# 補完候補一覧をカラー表示
autoload colors
zstyle ':completion:*' list-colors ''

# git
autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

# prompt
PROMPT='[%B%F{red}%n@%m%f%b:%F{green}%~%f]%F{cyan}$vcs_info_msg_0_%f
%F{yellow}$%f '

bindkey -e

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end

# コマンド履歴をインクリメンタルサーチして実行
function select-history() {
  BUFFER=$(history -n -r 1 | fzf --exact --reverse --query="$LBUFFER" --prompt="History > ")
  CURSOR=${#BUFFER}
  zle accept-line
}
zle -N select-history       # ZLEのウィジェットとして関数を登録
bindkey '^r' select-history # `Ctrl+r` で登録したselect-historyウィジェットを呼び出す

# alias
alias ls='ls -FG'
alias ll='ls -alFG'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias vi='vim'

alias dk='docker'
alias dc='docker compose'
alias dcu='docker compose up -d'
alias dcd='docker compose down'

alias nr='npm run'
alias ni='npm install'
alias nu='npm uninstall'

alias ya='yarn add'
alias yr='yarn remove'
alias yi='yarn install'

alias pn='pnpm'
alias pnr='pnpm run'
alias pni='pnpm install'
alias pnu='pnpm uninstall'

alias vz='vim ~/.zshrc'
alias sz='source ~/.zshrc'
alias vh='sudo vi /private/etc/hosts'

alias g='git'
alias gb='git branch'
alias gbd='git branch -D'
alias gs='git status'
alias gf='git fetch'
alias gad='git add'
alias gch='git checkout'
alias gch-b='git checkout -b'
alias gc-m='git commit -m'
alias gph='git push'
alias gph-f='git push --force-with-lease'
alias gpl='git pull'
alias gr='git rebase'
alias grc='git rebase --continue'
alias grd='git pull --rebase origin develop'
alias gt='git tag'
alias grs-s='git reset --soft'
alias grs-h='git reset --hard'

alias k='kubectl'
alias kg='kubectl get'
alias kgpo='kubectl get po'
alias kgpow='kubectl get po -w'
alias kd='kubectl describe'
alias kdpo='kubectl describe po'
alias kdde='kubectl describe deploy'
alias kdcm='kubectl describe configmap'

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=("$HOME/.docker/completions" $fpath)
# End of Docker CLI completions
