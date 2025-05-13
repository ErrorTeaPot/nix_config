#!/home/errorteapot/.nix-profile/bin/fish
nix --extra-experimental-features "nix-command flakes" \
	run github:nix-community/nixos-anywhere -- \
	--generate-hardware-config nixos-generate-config ./hosts/servers/mikoshi/hardware-configuration.nix \
	--flake .#mikoshi \
	#--no-substitute-on-destination \
	--target-host errorteapot@192.168.67.118
