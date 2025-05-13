{ pkgs, lib, config, ... }:
{
  options = {
    hyprlock = {
      enable = lib.mkEnableOption "Enables Hyprlock";
    };
  };

  config = lib.mkIf config.hyprlock.enable {
    programs.hyprlock = {
      enable = true;
    };
  };
}

