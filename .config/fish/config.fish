if status is-interactive
    keychain --eval --quiet ~/.ssh/id_ed25519 | source
end

function fish_greeting

end

# opencode
fish_add_path /home/chris/.opencode/bin

# sling
set --export SLING_INSTALL "/home/chris/.sling"
set --export PATH "$SLING_INSTALL/bin" $PATH
fish_add_path /home/chris/.local/bin

# dbt aliases
alias dbtf=/home/chris/.local/bin/dbt
