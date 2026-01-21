#!/bin/sh

# Format disk
read -p "Do we format using TeaPotDesktopL disk config ? (y/n)" -n 1 -r
echo
 
## If prompt is yes then quit
if [[ ! $REPLY =~ ^[Nn]$ ]]
then
	[[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode zap_create_mount /tmp/nix_config/hosts/workstations/TeaPotDesktopL/disk-config.nix

# Generate config 
sudo nixos-generate-config --root /mnt --no-filesystems

# Remove generated configuration.nix
sudo rm /mnt/etc/nixos/configuration.nix

# Move hardware-configuration.nix to cloned config
sudo mv /mnt/etc/nixos/hardware-configuration.nix /tmp/nix_config/hosts/workstations/TeaPotDesktopL/

# Move our config to destination disk
sudo mv /tmp/nix_config/{.,}* /mnt/etc/nixos/

# Install new config on disk
sudo nixos-install --flake /mnt/etc/nixos#TeaPotDesktopL

# Add password to our user
sudo nixos-enter --root /mnt -c 'passwd errorteapot'
