if status is-interactive
    keychain --eval --quiet ~/.ssh/id_ed25519 | source
end

function fish_greeting

end

# opencode
fish_add_path /home/chris/.opencode/bin
