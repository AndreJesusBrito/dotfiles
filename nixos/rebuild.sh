#!/bin/bash
set -e
pushd ~/dotfiles/nixos/
sudo nixos-rebuild switch --flake . # -I nixos-config=/home/andre/dotfiles/nixos/flake.nix
popd
