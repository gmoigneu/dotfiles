#!/bin/bash

USER_HOME=$HOME

mkdir -p $USER_HOME/.config
ln -s $USER_HOME/dotfiles/starship/starship.toml $USER_HOME/.config/starship.toml
ln -s $USER_HOME/dotfiles/ghostty $USER_HOME/.config/ghostty
ln -s $USER_HOME/dotfiles/fish $USER_HOME/.config/fish
ln -s $USER_HOME/dotfiles/fuzzel $USER_HOME/.config/fuzzel
ln -s $USER_HOME/dotfiles/waybar $USER_HOME/.config/waybar