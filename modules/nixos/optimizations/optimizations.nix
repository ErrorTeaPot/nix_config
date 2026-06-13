{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  # Shorter name to access a final setting
  cfg = config.optimization;
in
{
  options.optimization = {
    enable = mkEnableOption "Optimize stuff";
  };

  config = mkIf cfg.enable {
    # Idle daemon
    services.hypridle.enable = true;

    # Power management
    services.tlp.enable = true;
    services.tlp.pd.enable = true;
    powerManagement.enable = true;
    services.upower.enable = true;

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
