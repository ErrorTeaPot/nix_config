# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    ../default.nix
  ];

  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
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
      #swww
      fastfetch
      stremio
      #evince
    ];
  };

  programs = {
    git = {
      settings = {
        user.name = "ErrorTeaPot";
        user.email = "github.z5tea@passinbox.com";
      };
    };
  };

  /*
    xdg.mimeApps = {
      enable = true;
      associations.added = {
        "application/pdf" = ["org.gnome.Evince.desktop"];
      };
      defaultApplications = {
        "application/pdf" = ["org.gnome.Evince.desktop"];
      };
    };
  */

  wofi.enable = true;
  waybar.enable = true;
  hyprland.enable = true;
  hyprlock.enable = true;
  dunst.enable = true;

  alacritty.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
