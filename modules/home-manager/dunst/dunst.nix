{ pkgs, lib, config, ... }:

{
  options = {
    dunst = {
      enable = lib.mkEnableOption "Enables Dunst";
    };
  };

  config = lib.mkIf config.dunst.enable {
    services.dunst = {
      enable = true;
      settings = {
      global = {
        monitor = 0;
	follow = "mouse";
        width = 400;
        offset = "5x5";
        progress_bar_min_width = 380;
        progress_bar_max_width = 380;
        progress_bar_corner_radius = 2;
        padding = 10;
        horizontal_padding = 10;
        frame_width = 1;
        gap_size = 3;
        font = "Monospace 14";
        icon_theme = "rose-pine-icons";
        enable_recursive_icon_lookup = true;
        corner_radius = 2;
        background = "#f2e9e1";
        foreground = "#575279";
      };

      urgency_low = {
        background = "#e7e0da";
        highlight = "#286983";
        frame_color = "#286983";
        default_icon = "dialog-information";
        #format = "<b><span foreground='#286983'>%s</span></b>\n%b";
      };

      urgency_normal = {
        background = "#f1e3d7";
        highlight = "#ea9d34";
        frame_color = "#ea9d34";
        default_icon = "dialog-warning";
        #format = "<b><span foreground='#ea9d34'>%s</span></b>\n%b";
      };

      urgency_critical = {
        background = "#ede0d9";
        highlight = "#b4637a";
        frame_color = "#b4637a";
        default_icon = "dialog-error";
        #format = "<b><span foreground='#b4637a'>%s</span></b>\n%b";
      };
      };
    };
  };
}

