{ pkgs, lib, config, ... }:

{
  options = {
    waybar = {
      enable = lib.mkEnableOption "Enables waybar";
    };
  };

  config = lib.mkIf config.waybar.enable {
    programs.waybar = {
      enable = true;
      settings = {
	topBar = {
        layer = "top";
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ ];
        modules-right = [ "custom/nm-applet" "wireplumber" "backlight" "battery" "tray" "clock" ];
        "custom/nm-applet" = {
            exec = "nm-applet";
        };
        network = {
          format-ethernet = "󰈁 {ifname}";
          format-wifi = "  {essid}";
          format-disconnected = " Disconnected";
          on-click = "nm-applet";
        };
        backlight = {
          device = "aspci_video";
          format = "{percent}% {icon}";
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
        };
        wireplumber = {
          format = "{volume}% {icon}";
          format-muted = "";
          format-icons = [ "" "" "" ];
        };
        battery = {
          bat = "BAT0";
          interval = 2;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = [ "" "" "" "" "" ];
          max-length = 25;
        };
        tray = {
          spacing = 10;
        };
      };
      };
      style = ''
      	/*
	* Variant: Rosé Pine Dawn
	* Maintainer: DankChoir
	*/

	@define-color base            #faf4ed;
	@define-color surface         #fffaf3;
	@define-color overlay         #f2e9e1;

	@define-color muted           #9893a5;
	@define-color subtle          #797593;
	@define-color text            #575279;

	@define-color love            #b4637a;
	@define-color gold            #ea9d34;
	@define-color rose            #d7827e;
	@define-color pine            #286983;
	@define-color foam            #56949f;
	@define-color iris            #907aa9;

	@define-color highlightLow    #f4ede8;
	@define-color highlightMed    #dfdad9;
	@define-color highlightHigh   #cecacd;

        * {
          border: none;
          border-radius: 0;
          font-family: CaskaydiaCove Nerd Font;
          font-size: 13px;
          min-height: 20px;
        }

        window#waybar {
          background: transparent;
        }

        window#waybar.hidden {
          opacity: 0.2;
        }

        #window {
          margin-top: 8px;
          padding-left: 16px;
          padding-right: 16px;
          border-radius: 26px;
          transition: none;
          color: transparent;
          background: transparent;
        }

        #workspaces {
          margin-top: 8px;
          margin-left: 12px;
          margin-bottom: 0;
          border-radius: 26px;
          background: @base;
          transition: none;
        }

        #workspaces button {
          transition: none;
          color: @text;
          background: transparent;
          font-size: 16px;
        }

        #workspaces button.focused {
          color: @highlightMed;
        }

        #workspaces button:hover {
          transition: none;
          box-shadow: inherit;
          text-shadow: inherit;
          color: @love;
        }

        #network {
          margin-top: 8px;
          margin-left: 8px;
          padding-left: 16px;
          padding-right: 16px;
          margin-bottom: 0;
          border-radius: 26px;
          transition: none;
          color: @surface;
          background: @gold;
        }

        #wireplumber {
          margin-top: 8px;
          margin-left: 8px;
          padding-left: 16px;
          padding-right: 16px;
          margin-bottom: 0;
          border-radius: 26px;
          transition: none;
          color: @surface;
          background: @love;
        }

        #backlight {
          margin-top: 8px;
          margin-left: 8px;
          padding-left: 16px;
          padding-right: 16px;
          margin-bottom: 0;
          border-radius: 26px;
          transition: none;
          color: @surface;
          background: @rose;
        }

        #battery {
          margin-top: 8px;
          margin-left: 8px;
          padding-left: 16px;
          padding-right: 16px;
          margin-bottom: 0;
          border-radius: 26px;
          transition: none;
          color: @surface;
          background: @pine;
        }

        #tray {
          margin-top: 8px;
          margin-left: 8px;
          padding-left: 16px;
          padding-right: 16px;
          margin-bottom: 0;
          border-radius: 26px;
          transition: none;
          color: @surface;
          background: @iris;
        }

        #clock {
          margin-top: 8px;
          margin-left: 8px;
          margin-right: 12px;
          padding-left: 16px;
          padding-right: 16px;
          margin-bottom: 0;
          border-radius: 26px;
          transition: none;
          color: @surface;
          background: @foam;
        }
      '';
    };
  };
}

