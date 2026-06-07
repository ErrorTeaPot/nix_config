{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    hyprpaper = {
      enable = lib.mkEnableOption "Enables hyprpaper";
    };
  };

  config = lib.mkIf config.hyprpaper.enable {
    services.hyprpaper = {
      enable = true;
      settings = {
        wallpaper = [
          {
            monitor = "";
            path = "~/Images/Wallpapers/idktf.png";
          }
        ];
      };
    };
  };
}
