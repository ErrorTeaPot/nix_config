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
    programs.seahorse.enable = true;
    services.gnome = {
      gnome-keyring.enable = true;
      gcr-ssh-agent.enable = true;
    };

    # Enables auto-unlock
    security.pam.services = {
      sddm.enableGnomeKeyring = true;
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
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

    environment.systemPackages = with pkgs; [ ];
  };
}
