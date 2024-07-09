#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "not provided"
    exit 1
fi

if [[ $1 == "fetch" ]]; then
    rm -rf /etc/nixos/*
    cp -r /home/diego/dotfiles/nixos/* /etc/nixos/
fi

if [[ $1 == "l" ]]; then
    rm -r /home/diego/dotfiles/awesome
    cp -r /home/diego/.config/awesome /home/diego/dotfiles/awesome
    rm -r /home/diego/dotfiles/nixos
    cp -r /etc/nixos /home/diego/dotfiles/nixos
fi

if [[ $1 == "d" ]]; then
    rm -r /home/diego/dotfiles/awesome-desktop
    cp -r /home/diego/.config/awesome /home/diego/dotfiles/awesome-desktop
    rm -r /home/diego/dotfiles/nixos
    cp -r /etc/nixos /home/diego/dotfiles/nixos
fi
