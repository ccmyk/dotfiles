# Fig integrations
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"

# Environment Variables
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export DOTFILES="$HOME/.dotfiles"
export PAGER='less'
export EDITOR='vim'
export TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*U\nsystem\t%*S\ntotal\t%*E'
export PATH_MODIFIED="true"

# Prevent file overwrites using `>`
set -o noclobber

# Extend $PATH without duplicates
_extend_path() {
    [[ -d "$1" ]] || return
    if ! echo "$PATH" | tr ":" "\n" | grep -qx "$1"; then
        export PATH="$1:$PATH"
    fi
}

# Add custom bin to $PATH
_extend_path "$HOME/.local/bin"
_extend_path "$DOTFILES/bin"
_extend_path "$HOME/.npm-global/bin"
_extend_path "$HOME/.rvm/bin"
_extend_path "$HOME/.yarn/bin"
_extend_path "$HOME/.config/yarn/global/node_modules/.bin"
_extend_path "$HOME/.bun/bin"
_extend_path "$HOME/.pyenv/shims"

# Extend $NODE_PATH
if [ -d ~/.npm-global ]; then
  export NODE_PATH="$NODE_PATH:$HOME/.npm-global/lib/node_modules"
fi

# Default pager options
less_opts=(
  -FX # Quit if the entire file fits on the first screen
  --ignore-case # Ignore case in searches that do not contain uppercase
  --RAW-CONTROL-CHARS # Allow ANSI color escapes, but no other escapes
  --quiet # Quiet the terminal bell
  --dumb # Do not complain on a dumb terminal
)
export LESS="${less_opts[*]}"

# Default editor for local and remote sessions
if [[ -n "$SSH_CONNECTION" ]]; then
  export EDITOR='vim'
else
  export EDITOR='nano'
fi

# Oh My Zsh and zgen setup
ZSH_DISABLE_COMPFIX="true"
source "$HOME/.zgen/zgen.zsh"

# Load zgen plugins
if ! zgen saved; then
    echo "Creating a zgen save"
    zgen oh-my-zsh

    # Plugins from oh-my-zsh
    zgen oh-my-zsh plugins/git
    zgen oh-my-zsh plugins/history-substring-search
    zgen oh-my-zsh plugins/npm
    zgen oh-my-zsh plugins/sudo
    zgen oh-my-zsh plugins/command-not-found
    zgen oh-my-zsh plugins/yarn
    zgen oh-my-zsh plugins/nvm
    zgen oh-my-zsh plugins/extract
    zgen oh-my-zsh plugins/ssh-agent
    zgen oh-my-zsh plugins/gpg-agent
    zgen oh-my-zsh plugins/vscode
    zgen oh-my-zsh plugins/gh
    zgen oh-my-zsh plugins/common-aliases
    zgen oh-my-zsh plugins/docker

    # Custom plugins
    zgen load chriskempson/base16-shell
    zgen load agkozak/zsh-z
    zgen load hlissner/zsh-autopair
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-autosuggestions
    
    # ... add other custom plugins here ...

    # Source local files
    zgen load "$DOTFILES/lib"
    zgen load "$DOTFILES/custom"
    
    # Completions
    zgen load zsh-users/zsh-completions src

    zgen save
fi

# Direnv configuration
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# Bun completions
if [ -s "$HOME/.bun/_bun" ]; then
  source "$HOME/.bun/_bun"
  export BUN_INSTALL="$HOME/.bun"
  export PATH="$BUN_INSTALL/bin:$PATH"
fi

# Fuzzy finder bindings
if [ -f "$HOME/.fzf.zsh" ]; then
  source "$HOME/.fzf.zsh"
fi
export FZF_DEFAULT_OPTS="--extended"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Override section
if [[ -f "$HOME/.zshlocal" ]]; then
  source "$HOME/.zshlocal"
fi

# Additional configurations
# Append any custom PATH directories
export PATH="$HOME/Qt/6.6.1/gcc_64/bin:$PATH"
# Define Qt6_DIR if needed
export Qt6_DIR="$HOME/Qt/6.6.1/gcc_64/lib/cmake/Qt6"

# Starship prompt initialization
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion


# Post-shell integration for Fig
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

