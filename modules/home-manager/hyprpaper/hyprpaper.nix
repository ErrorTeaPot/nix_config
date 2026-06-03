{ pkgs, lib, config, ... }:
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
            monitor = "eDP-1";
            path = "~/Images/Wallpapers/idktf.png";
          }
        ];
      };
    };
  };
}

