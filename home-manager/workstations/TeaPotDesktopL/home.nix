# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    ../default.nix
  ];

  nixpkgs = {
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
    # Configure your nixpkgs instance
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "errorteapot";
    homeDirectory = "/home/errorteapot";
    packages = with pkgs; [
	vesktop
	signal-desktop
	brave
	swww
	nerd-fonts.caskaydia-cove
	fastfetch
	btop
	stremio
	lazygit
	lf
	tree
	evince
    ];
  };

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "ErrorTeaPot";
      userEmail = "github.z5tea@passinbox.com";
      extraConfig = {
	pull.rebase = false;
      };
    };
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/pdf" = ["org.gnome.Evince.desktop"];
    };
    defaultApplications = {
      "application/pdf" = ["org.gnome.Evince.desktop"];
    };
  };

  wofi.enable = true;
  waybar.enable = true;
  starship.enable = true;
  hyprland.enable = true;
  hyprlock.enable = true;
  alacritty.enable = true;
  fish.enable = true;
  dunst.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
