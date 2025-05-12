#!/bin/fish
nix --extra-experimental-features "nix-command flakes" \
	run github:nix-community/nixos-anywhere -- \
	#--generate-hardware-config nixos-generate-config ./hosts/servers/agwe/hardware-configuration.nix/hardware-configuration.nix \
	--flake .#agwe \
	-i ~/.ssh/agwe \
	--no-substitute-on-destination \
	--target-host errorteapot@vm2.teapot.eu.org
