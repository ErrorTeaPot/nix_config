{
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
    ../default.nix
  ];

  nixpkgs = {
    overlays = [];
  };
  networking.hostName = "mikoshi";

  # Configure console keymap
  console.keyMap = "us-acentos";

  environment.systemPackages = with pkgs; [
  ];

  programs = {
	neovim.enable = true;
	fish.enable = true;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowedUDPPorts = [ 22 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
