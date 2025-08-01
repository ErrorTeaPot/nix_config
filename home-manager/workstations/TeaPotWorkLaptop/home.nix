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
    username = "glesaout";
    homeDirectory = "/home/glesaout";
    packages = with pkgs; [
      typst
    ];
  };

  tooling.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
