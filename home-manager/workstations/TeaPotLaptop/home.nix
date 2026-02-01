{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ../default.nix
  ];

  nixpkgs = {
    overlays = [ ];
    config = {
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "errorteapot";
    homeDirectory = "/home/errorteapot";
    packages = with pkgs; [ ];
  };

  programs = {
    home-manager.enable = true;
    git = {
      settings = {
        user.name = "ErrorTeaPot";
        user.email = "github.z5tea@passinbox.com";
      };
    };
  };

  wofi.enable = true;
  waybar.enable = true;
  hyprland.enable = true;
  hyprlock.enable = true;
  dunst.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
