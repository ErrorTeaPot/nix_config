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

      cursor = {
        enable = lib.mkEnableOption "Custom cursor theme" // {
          default = true;
        };
        name = lib.mkOption {
          type = lib.types.str;
          default = "BreezeX-RosePineDawn-Linux";
          description = "Cursor theme name";
        };
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.rose-pine-cursor;
          description = "Cursor theme package";
        };
        size = lib.mkOption {
          type = lib.types.int;
          default = 24;
          description = "Cursor size";
        };
      };
    };
  };

  config = lib.mkIf config.wm-setup.enable {
    hyprland.enable = true;
    hyprlock.enable = true;
    hyprpaper.enable = true;
    dunst.enable = true;
    waybar.enable = true;
    wofi.enable = true;

    # Icon theming
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };
    };

    xdg = {
      portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = with pkgs; [
          #kdePackages.xdg-desktop-portal-kde
          xdg-desktop-portal-gtk
        ];
      };
      mime.defaultApplications = {
        "x-scheme-handler/http" = "brave-browser.desktop";
        "x-scheme-handler/https" = "brave-browser.desktop";
        "x-scheme-handler/pdf" = "org.gnome.Papers.desktop";
        "x-scheme-handler/about" = "brave-browser.desktop";
        "x-scheme-handler/unknow" = "brave-browser.desktop";

        "image/*" = "pix.desktop";
      };
    };

    home.pointerCursor = lib.mkIf config.wm-setup.cursor.enable {
      name = config.wm-setup.cursor.name;
      package = config.wm-setup.cursor.package;
      size = config.wm-setup.cursor.size;
      gtk.enable = true;
      x11.enable = true;
    };

    home.sessionVariables = lib.mkIf config.wm-setup.cursor.enable {
      XCURSOR_THEME = config.wm-setup.cursor.name;
      XCURSOR_SIZE = toString config.wm-setup.cursor.size;
    };
  };
}
