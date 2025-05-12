#!/bin/sh

nix --experimental-features 'nix-command flakes' build .#nixosConfigurations.agwe.config.system.build.toplevel --dry-run
