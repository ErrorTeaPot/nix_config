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

  # Modules
  fish.enable = true;
}
