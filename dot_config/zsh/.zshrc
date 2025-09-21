# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="ys"

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

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
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
plugins=(
git
zsh-syntax-highlighting
zsh-completions
zsh-autosuggestions
zsh-history-substring-search
)

source $ZSH/oh-my-zsh.sh

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

# peco
function peco-select-history() {
local tac
if which tac > /dev/null; then
tac="tac"
else
tac="tail -r"
fi
BUFFER=$(\history -n 1 | \
eval $tac | \
peco --query "$LBUFFER")
CURSOR=$#BUFFER
zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

[[ -d ~/.rbenv  ]] && \
  export PATH=${HOME}/.rbenv/bin:${PATH} && \
  eval "$(rbenv init -)"

export PATH="$(brew --prefix python)/libexec/bin:$PATH"

export PATH="$PATH:/Users/shimizutoorushin/fvm/default/bin"

export PATH="/usr/local/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/usr/local/opt/openjdk/include"
export JAVA_HOME=$(/usr/libexec/java_home -v 17.0.13)

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/shimizutoorushin/.dart-cli-completion/zsh-config.zsh ]] && . /Users/shimizutoorushin/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]


# pnpm
export PNPM_HOME="/Users/shimizutoorushin/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
eval "$(starship init zsh)"


# bun completions
[ -s "/Users/shimizutoorushin/.bun/_bun" ] && source "/Users/shimizutoorushin/.bun/_bun"

alias lg='lazygit'
export PATH="/opt/homebrew/opt/postgresql@12/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

export GOENV_ROOT=$HOME/.goenv
export PATH=$GOENV_ROOT/bin:$PATH
eval "$(goenv init -)"

export PATH="/Users/shimizutoorushin/.local/bin:$PATH"

alias gitmc="gitmoji -c"
alias cat="bat"
alias ls="eza -aal --icons"
alias ghq="ghq 2>/dev/null"
setopt AUTO_CD
cdpath=(.. ~ ~/src)

# githubのリポジトリを検索して移動
ghfd() {
  local src=$(ghq list 2>/dev/null | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")
  if [ -n "$src" ]; then
    cd "$(ghq root)/$src"
  fi
}

# 現在のフォルダ配下のフォルダを検索して移動
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# gitリポジトリ配下のフォルダを検索して移動
fdgit() {
  local top_dir
  top_dir="$(git rev-parse --show-toplevel 2>/dev/null)"
  if [ -z "$top_dir" ]; then
    echo "Not in a Git repository."
    return 1
  fi
  local dir
  dir="$(
    cd "$top_dir" || return 1
    find . -type d -not -path '*/.git/*' 2>/dev/null | fzf
  )"
  [ -z "$dir" ] && return
  cd "$top_dir/$dir"
}

# githubのissueを検索してブラウザで表示
ghi() {
  local issues issue number
  issues="$(gh issue list)" || return 1
  issue="$(echo "$issues" | fzf --preview 'gh issue view {1}' \
    --preview-window=right:60% \
    --preview-window=wrap)" || return 1
  number="${issue%%[[:space:]]*}"
  number="${number#'#'}"
  gh issue view --web "$number"
}

# githubリポジトリをcloneして移動
ghcl() {
  local repo_name="$1"
  if [ -z "$repo_name" ]; then
    echo "Usage: ghcl <repo_name>"
    return 1
  fi
  ghq get "$repo_name" || {
    echo "Error: could not ghq get '$repo_name'"
    return 1
  }
  local repo_path
  repo_path="$(ghq list -p "$repo_name")"
  if [ -n "$repo_path" ]; then
    cd "$repo_path" || {
      echo "Error: could not cd to '$repo_path'"
      return 1
    }
  else
    echo "Error: could not find repository path for '$repo_name'"
    return 1
  fi
}

# githubリポジトリを作成してcloneして移動
ghcr() {
  local repo_name="$1"
  local visibility="${2:-private}"  # private default
  if [ -z "$repo_name" ]; then
    echo "Usage: ghcr <repo_name> [public|private]"
    return 1
  fi
  gh repo create "$repo_name" --"$visibility" --confirm || {
    echo "Error: could not create repository '$repo_name'"
    return 1
  }
  ghq get "$repo_name" || {
    echo "Error: could not ghq get '$repo_name'"
    return 1
  }
  local repo_path
  repo_path="$(ghq list -p "$repo_name")"
  if [ -n "$repo_path" ]; then
    cd "$repo_path" || {
      echo "Error: could not cd to '$repo_path'"
      return 1
    }
  else
    echo "Error: could not find repository path for '$repo_name'"
    return 1
  fi
}

