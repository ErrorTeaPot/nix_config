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
  networking = {
    hostName = "mikoshi";
    interfaces.ens18.ipv4.addresses = [{
      address = "192.168.67.5";
      prefixLength = 24;
    }];
    defaultGateway = {
      address = "192.168.67.1";
      interface = "ens18";
    };
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  users.users.errorteapot.hashedPassword = "$y$j9T$N5RyYEtWyLQLDXM/S8PnP.$uOUfunQ/Q4dFmM7jhb9uGKOKXZ4eYDknfsNRfVXTTZB";

  environment.systemPackages = with pkgs; [
  ];

  programs = {
	neovim.enable = true;
	fish.enable = true;
  };

/*
  sops.secrets."dns-provider-api-key" = {
    owner = config.services.caddy.user;
    group = config.services.caddy.group;
    mode = "0400";
  };

  reverse_proxy = {
    enable = true;
    DNSProviderApiKeyFile = config.sops.secrets.dns-provider-api-key.path;
  };
*/

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

  sops.secrets."nextcloud" = {
      owner = "nextcloud";
      group = "nextcloud";
      mode = "0400";
  };

  nextcloud = {
    enable = true;
    authFile = config.sops.secrets."nextcloud".path;
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
