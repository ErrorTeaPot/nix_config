{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    hyprpaper = {
      enable = lib.mkEnableOption "Enables Hyprpaper";
    };
  };

  config = lib.mkIf config.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
    };
  };
}
