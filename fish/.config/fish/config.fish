if status is-interactive
    # Commands to run in interactive sessions can go here

    fish_vi_key_bindings
    set -Ux EDITOR nvim
    set -Ux VISUAL nvim

    alias python=python3
    alias vim="nvim"
end

# Conditional Homebrew setup for macOS only
if test (uname) = "Darwin"
    eval "$(/opt/homebrew/bin/brew shellenv)"
end
