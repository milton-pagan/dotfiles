if status is-interactive
    # Interactive session setup
    fish_vi_key_bindings
    set -Ux EDITOR nvim
    set -Ux VISUAL nvim

    alias python=python3
    alias vim="nvim"
end

# Only run on macOS
if test (uname) = "Darwin"
    eval "$(/opt/homebrew/bin/brew shellenv)"
end

