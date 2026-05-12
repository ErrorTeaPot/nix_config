{ pkgs, ... }:
{
  imports = [
    ../modules/home-manager/default.nix
  ];

  programs = {
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
    };
    ranger = {
      enable = true;
    };
  };

  nix = {
    package = pkgs.nix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 14d";
  };

  # Modules
  #fish.enable = true;
  zsh.enable = true;
}
