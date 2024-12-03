
if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Created by `pipx` on 2024-01-20 00:28:35
set PATH $PATH /home/diego/.local/bin

alias publicip='wget http://checkip.dyndns.org/ -O - -o /dev/null | cut -d: -f 2 | cut -d\< -f 1'
alias sync='rslsync && kitty sh -c "firefox http://localhost:8888"'
alias vncstart='x11vnc -display :0 -rfbauth ~/.vnc/passwd'
alias diffs='diff --side-by-side --suppress-common-lines'
alias clip='kitten clipboard'
alias docker-fix="export DOCKER_HOST='unix:///var/run/docker.sock'"
alias firefox='firefox-developer-edition'

# create backups to external hd
alias syncall="rsync -aAXHv --exclude='/dev/*' --exclude='/proc/*' --exclude='/sys/*' --exclude='/tmp/*' --exclude='/run/*' --exclude='/mnt/*' --exclude='/media/*' --exclude='/lost+found/' --exclude='/home/$USER/disks/*' / "
alias compress='tar -cJf folder.tar.xz'
alias decompress='tar -xJf'

# * run application using nvidia gpu
alias nvidia-run='__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia'
alias pkgsort="pacman -Qi | egrep '^(Name|Installed)' | cut -f2 -d':' | paste - - | column -t | sort -nrk 2 | grep MiB | less"
alias nv='nvim'
alias zen='zen-browser'
# * nvim like exit
alias :q='exit'

#  * Create missing directories in path when calling `mkdir`
alias mkdir='mkdir -pv'

#  * `cp` to ask when overwriting files
alias cp='cp -i'

#  * `mv` to ask when overwriting files
alias mv='mv -i'

#  * Human readable sizes for `df`, `du`, `free` (i.e. Mb, Gb etc)
alias df='df -h'
alias du='du -ch'
alias free='free -m'

#  * `sizeof` command to show size of file or directory
alias sizeof="du -hs"


#  * `wget` to save file with provided name
alias wget='wget --content-disposition'




# >>> mamba initialize >>>
# !! Contents within this block are managed by 'micromamba shell init' !!
set -gx MAMBA_EXE "/home/diego/.local/bin/micromamba"
set -gx MAMBA_ROOT_PREFIX /home/diego/micromamba
$MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<
alias mamba='micromamba'

