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

    # Enable keyring
    services.gnome = {
      gnome-keyring.enable = true;
      gcr-ssh-agent.enable = true;
    };

    security.pam.services = {
      sddm.enableGnomeKeyring = true;
      gnome-keyring = {
        name = "gnome-keyring";
        enableGnomeKeyring = true;
      };
    };

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

    # Enable programs
    programs = {
      hyprland = {
        enable = true;
        withUWSM = true;
      };
      ssh = {
        startAgent = false;
        enableAskPassword = true;
      };
      gnupg.agent = {
        enable = true;
        enableSSHSupport = false;
      };
    };

    environment.systemPackages = with pkgs; [
    ];
  };
}
