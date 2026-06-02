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
    };
  };
}
