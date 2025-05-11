#!/bin/fish
nix --extra-experimental-features "nix-command flakes" \
	run github:nix-community/nixos-anywhere -- \
	--generate-hardware-config nixos-generate-config ./hosts/servers/mikoshi/hardware-configuration.nix \
	--flake .#agwe \
	--target-host errorteapot@193.122.12.251
