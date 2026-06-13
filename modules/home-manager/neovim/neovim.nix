{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    neovim = {
      enable = lib.mkEnableOption "Enables neovim";
    };
  };

  config = lib.mkIf config.neovim.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
      sideloadInitLua = true;
      withRuby = false; # Port for state 26.05
      withPython3 = false; # Same
    };
    home.packages = with pkgs; [
      nodejs
      unzip
    ];
  };
}
