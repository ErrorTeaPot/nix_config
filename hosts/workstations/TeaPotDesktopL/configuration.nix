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
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
  };
  networking.hostName = "TeaPotDesktopL";
  networking.networkmanager.enable = true;

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.gnome.gnome-keyring.enable = true;

  security.pam.services = {
	sddm.enableGnomeKeyring = true;
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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.users = {
    errorteapot = {
      isNormalUser = true;
      description = "ErrorTeaPot";
      extraGroups = ["wheel" "networkmanager"];
      shell = pkgs.fish;
      packages = with pkgs; [
      ];
    };
  };

  fonts.fontDir.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # brave
    networkmanagerapplet
  ];

  programs = {
	neovim.enable = true;
	hyprland.enable = true;
	fish.enable = true;
	ssh = {
		startAgent = false;
    		enableAskPassword = true;
	};
  };

  

  # This setups a SSH server
  /*
  services.openssh = {
    enable = true;
    settings = {
      # Opinionated: forbid root login through SSH.
      PermitRootLogin = "no";
      # Opinionated: use keys only.
      # Remove if you want to SSH using passwords
      PasswordAuthentication = false;
    };
  };
  */

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "24.11";
}
