{ pkgs, ... }:
{
  imports = [
    ../modules/home-manager/default.nix
  ];

  programs = {
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

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  # Modules
  #fish.enable = true;
  zsh.enable = true;
}
