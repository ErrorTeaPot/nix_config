#!/bin/sh

nix --experimental-features 'nix-command flakes' build .#nixosConfigurations.TeaPotDesktopL.config.system.build.toplevel --dry-run
