{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.wm-setup;
  custom-sddm-astronaut = pkgs.sddm-astronaut.override {
    embeddedTheme = "jake_the_dog";
    #themeConfig = {
    #  Background = "path/to/background.jpg";
    #  Font = "M+1 Nerd Font";
    #};
  };
in
{
  options.wm-setup = {
    enable = mkEnableOption "Window manager setup";
  };

  config = mkIf cfg.enable {

    # Enables SDDM
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;

      extraPackages = with pkgs; [
        custom-sddm-astronaut
      ];
      theme = "sddm-astronaut-theme";
      settings = {
        Theme = {
          Current = "sddm-astronaut-theme";
        };
      };
    };

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

    environment.systemPackages = with pkgs; [
      custom-sddm-astronaut
    ];
  };
}
