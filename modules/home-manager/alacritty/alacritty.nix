{ pkgs, lib, config, ... }:

{
  options = {
    alacritty = {
      enable = lib.mkEnableOption "Enables Alacritty";
    };
  };

  config = lib.mkIf config.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
      	window = {
	  opacity = 0.8;
	  padding = {
	    x = 5;
	    y = 5;
	  };
	  decorations = "None";
	};
	font = {
	  normal = {
	    family = "CaskaydiaCove Nerd Font";
	  };
	  size = 14.0;
	};
	env = {
          TERM = "xterm-256color";
        };
        cursor = {
          style = { shape = "Beam"; blinking = "On"; };
          vi_mode_style = { shape = "Block"; };
	};
	general = {
	  live_config_reload = true;
	};
      };
      #theme = "rose_pine_moon";
    };
  };
}

