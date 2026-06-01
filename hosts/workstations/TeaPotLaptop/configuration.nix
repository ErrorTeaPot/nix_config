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

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

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
      shell = pkgs.zsh;
      packages = with pkgs; [ ];
      openssh.authorizedKeys.keys = [ ];
    };
  };

  systemd_hardening.enable = true;
  wm-setup.enable = true;
  fonts.fontDir.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    alacritty
    brightnessctl
    ripgrep
    hyprpolkitagent
  ];

  programs = {
  };

  # Fingerprint auth
  services.fprintd.enable = true;
  services.fprintd.tod = {
    enable = true;
    driver = pkgs.libfprint-2-tod1-goodix;
  };
  security.pam.services.hyprlock.fprintAuth = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
