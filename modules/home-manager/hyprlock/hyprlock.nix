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
      settings = {
        general = {
          hide_input = false;
          no_fade_in = false;
        };

        background = [{
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }];

	auth = {
	  fingerprint = {
	    enabled = true;
	  };
	};

        input-field = [{
          size = "250, 60";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          outline_thickness = 3;
          placeholder_text = "Password...";
          shadow_passes = 2;
        }];
      };
    };
  };
}

