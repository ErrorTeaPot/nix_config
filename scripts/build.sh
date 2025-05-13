#!/bin/sh

nix --experimental-features 'nix-command flakes' build .#nixosConfigurations.mikoshi.config.system.build.toplevel --dry-run
