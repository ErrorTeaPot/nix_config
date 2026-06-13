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

  # Try to enable ROCm
  hardware.graphics.enable = true;
  nixpkgs.config.rocmSupport = true;
  hardware.amdgpu.opencl.enable = true;

  # Enable virt
  virtualisation.libvirtd.enable = true;

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
        "libvirtd"
      ];
      shell = pkgs.zsh;
      packages = with pkgs; [
        file-roller
        yazi
        veracrypt
        bluetui
      ];
      openssh.authorizedKeys.keys = [ ];
    };
  };

  systemd_hardening.enable = true;
  wm-setup.enable = true;
  optimization.enable = true;
  hardening.enable = true;
  fonts.fontDir.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    networkmanagerapplet
    brightnessctl
    ripgrep
    hyprpolkitagent
    gdb
    file
    proton-vpn
    qemu
    pavucontrol
    python3
    (ghidra.withExtensions (
      extensions: with extensions; [
        ghidra-golanganalyzerextension
        wasm
      ]
    ))
  ];

  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs; [
        thunar-volman
        thunar-archive-plugin
      ];
    };
    xfconf.enable = true; # XFCE save preferences
    nix-ld.enable = true;
    virt-manager = {
      enable = true;
    };
    steam.enable = true;
    gamemode.enable = true;
  };

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };
  services.blueman.enable = true;

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
  #system.stateVersion = "24.11";
  system.stateVersion = "26.05";
}
