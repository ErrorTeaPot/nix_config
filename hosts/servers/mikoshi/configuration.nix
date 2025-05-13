{
  pkgs,
  config,
  modulesPath,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # For nixos-anywhere to add non-free drivers in hardware-config.nix
    (modulesPath + "/installer/scan/not-detected.nix")
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

  #reverse_proxy.enable = true;

  # RSS server
  /*
  sops.secrets."rss" = {
      owner = "miniflux";
      group = "miniflux";
      mode = "0400";
  };

  rss= {
    enable = true;
    authFile = config.sops.secrets.rss.path;
  };
  */

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
