# OS detection and home directory
set -gx USER_HOME $HOME
set -gx OS_NAME (uname)

# Homebrew setup based on OS
if test "$OS_NAME" = "Darwin"
    # macOS - try Apple Silicon first, then Intel
    if test -f /opt/homebrew/bin/brew
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else if test -f /usr/local/bin/brew
        eval "$(/usr/local/bin/brew shellenv)"
    end
else if test "$OS_NAME" = "Linux"
    # Linux - try Linuxbrew
    if test -f /home/linuxbrew/.linuxbrew/bin/brew
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    end
end

if status is-interactive

    # Commands to run in interactive sessions can go here
    set -gx STARSHIP_CONFIG "$USER_HOME/.config/starship.toml"
    starship init fish | source

    # File system
    if command -v eza &> /dev/null
        alias ls='eza -lh --group-directories-first --icons=auto'
        alias lsa='ls -a'
        alias lt='eza --tree --level=2 --long --icons --git'
        alias lta='lt -a'
    end

    alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
    
    # Upsun
    alias up="upsun push -y"

    alias aigw='eval "$(ai-gateway env)" && set OPENCODE_CONFIG_CONTENT (echo $OPENCODE_CONFIG_CONTENT | jq "del(.enabled_providers)")'
    aigw

    # node.js
    function nvm
        bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
    end

    set -x NVM_DIR "$USER_HOME/.nvm"
    nvm use default --silent

    if command -v zoxide &> /dev/null
        zoxide init fish | source
        alias cd="z"
    end

    function open
        xdg-open $argv >/dev/null 2>&1 &
    end

    # Directories
    alias ..='cd ..'
    alias ...='cd ../..'
    alias ....='cd ../../..'

    # Tools
    alias d='docker'
    alias v='nvim'

    # Git
    alias g='git'
    alias gcm='git commit -m'
    alias gcam='git commit -a -m'
    alias gcad='git commit -a --amend'

    # Upsun
    alias u='upsun'
    alias ud='git push upsun && upsun deploy'

    # pnpm
    if test "$OS_NAME" = "Darwin"
        set -gx PNPM_HOME "$USER_HOME/Library/pnpm"
    else
        set -gx PNPM_HOME "$USER_HOME/.local/share/pnpm"
    end
    fish_add_path $PNPM_HOME
    # pnpm end

    fish_add_path $USER_HOME/.platformsh-stg/bin/
    fish_add_path $USER_HOME/google-cloud-sdk/bin/
    fish_add_path $USER_HOME/.cargo/bin

    # The next line updates PATH for the Google Cloud SDK.
    if test -f "$USER_HOME/google-cloud-sdk/path.fish.inc"
        source "$USER_HOME/google-cloud-sdk/path.fish.inc"
    end

    # The next line enables shell command completion for gcloud.
    if test -f "$USER_HOME/google-cloud-sdk/completion.fish.inc"
        source "$USER_HOME/google-cloud-sdk/completion.fish.inc"
    end

    fish_add_path "$USER_HOME/.local/bin"
    
    # go
    fish_add_path /usr/local/go/bin

    fzf --fish | source

    source "$USER_HOME/secrets"
end


# opencode
fish_add_path /home/nls/.opencode/bin

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# AI Gateway
#eval "$(ai-gateway env)"
