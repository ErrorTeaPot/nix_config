{
  pkgs,
  ...
}:
{
  imports = [
    ./disk-config.nix
    ./hardware-configuration.nix
    ../default.nix
  ];

  nixpkgs = {
    overlays = [ ];
  };
  networking.hostName = "TeaPotLaptop";
  networking.networkmanager.enable = true;

  services.xserver.enable = true;

  services.displayManager.gdm = {
    enable = true;
  };

  services.gnome = {
    gnome-keyring.enable = true;
    gcr-ssh-agent.enable = true;
  };

  security.pam.services = {
    gdm.enableGnomeKeyring = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "intl";
  };

  # Configure console keymap
  console.keyMap = "us-acentos";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users = {
    errorteapot = {
      isNormalUser = true;
      description = "ErrorTeaPot";
      extraGroups = [
        "wheel"
        "networkmanager"
      ];
      shell = pkgs.fish;
      packages = with pkgs; [ ];
      openssh.authorizedKeys.keys = [ ];
    };
  };

  systemd_hardening.enable = true;
  fonts.fontDir.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    alacritty
  ];

  programs = {
    neovim.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
    };
    fish.enable = true;
    ssh = {
      startAgent = false;
      enableAskPassword = true;
    };
  };

  services.hypridle.enable = true;
  ssh_hardening.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
