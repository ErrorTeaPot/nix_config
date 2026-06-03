{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  # Shorter name to access a final setting
  cfg = config.wm-setup;
in
{
  options.wm-setup = {
    enable = mkEnableOption "Window manager setup";
  };

  config = mkIf cfg.enable {
    # Idle daemon
    services.hypridle.enable = true;

    # Power management
    services.tlp.enable = true;
    services.tlp.pd.enable = true;

    # ZRAM config
    ## Enables Out-Of-Memory handling
    systemd.oomd = {
      enable = true;
      enableUserSlices = true;
      enableSystemSlice = true;
      enableRootSlice = false;
    };

    zramSwap = {
      enable = true;
      memoryPercent = 50;
      algorithm = "zstd"; # Fast and efficient
    };

    programs = { };
    environment.systemPackages = with pkgs; [ ];
  };
}
