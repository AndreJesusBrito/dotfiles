#!/bin/bash
set -e
pushd ~/dotfiles/nixos/
sudo nix flake update
sudo nixos-rebuild switch --flake . --upgrade
popd
