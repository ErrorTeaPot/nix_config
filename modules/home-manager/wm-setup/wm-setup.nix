{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    wm-setup = {
      enable = lib.mkEnableOption "Enables wm-setup settings application";
    };
  };

  config = lib.mkIf config.wm-setup.enable {
    hyprland.enable = true;
    dunst.enable = true;
    hyprlock.enable = true;
    waybar.enable = true;
    wofi.enable = true;
  };
}
