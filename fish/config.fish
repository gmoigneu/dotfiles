fish_add_path "/opt/homebrew/bin/"

if status is-interactive

    # Commands to run in interactive sessions can go here
    set -gx STARSHIP_CONFIG ~/.config/starship.toml
    starship init fish | source

    # File system
    if command -v eza &> /dev/null
        alias ls='eza -lh --group-directories-first --icons=auto'
        alias lsa='ls -a'
        alias lt='eza --tree --level=2 --long --icons --git'
        alias lta='lt -a'
    end

    alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

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
    set -gx PNPM_HOME "~/Library/pnpm"
    fish_add_path $PNPM_HOME
    # pnpm end

    # The next line updates PATH for the Google Cloud SDK.
    if test -f '~/google-cloud-sdk/path.fish.inc'
        source '~/google-cloud-sdk/path.fish.inc'
    end

    # The next line enables shell command completion for gcloud.
    if test -f '~/google-cloud-sdk/completion.fish.inc'
        source '~/google-cloud-sdk/completion.fish.inc'
    end

    fish_add_path ~/.local/bin

    # Added by Antigravity
    fish_add_path ~/.antigravity/antigravity/bin

    fzf --fish | source
end

