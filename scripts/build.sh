#!/bin/sh

nix --experimental-features 'nix-command flakes' build .#nixosConfigurations.TeaPotLaptop.config.system.build.toplevel --dry-run
