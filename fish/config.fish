if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Created by `pipx` on 2024-01-20 00:28:35
set PATH $PATH /home/diego/.local/bin

alias publicip='wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1'
alias syncthingweb='kitty sh -c "firefox http://127.0.0.1:8080"'
alias syncdrive='grive -s ~/Desktop/GoodNotes'
alias vncstart='x11vnc -display :0 -rfbauth ~/.vnc/passwd'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/diego/.conda/bin/conda
    eval /home/diego/.conda/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/diego/.conda/etc/fish/conf.d/conda.fish"
        . "/home/diego/.conda/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/diego/.conda/bin" $PATH
    end
end
# <<< conda initialize <<<

