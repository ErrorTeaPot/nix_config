{ pkgs, lib, config, ... }:

{
  options = {
    starship = {
      enable = lib.mkEnableOption "Enables Starship";
    };
  };

  config = lib.mkIf config.starship.enable {
    programs.starship = {
      enable = true;
      settings = {
        palette = "material";
        character = {
          error_symbol = "[🌶️](bold #ff5555)";
          success_symbol = "[🌶️](bold #50fa7b)";
        };
        username = {
          format = "[$user]($style) on ";
        };
        palettes.material = {
          black   = "#666666";
          red     = "#eb606b";
          green   = "#c3e88d";
          yellow  = "#f7eb95";
          blue    = "#80cbc4";
          magenta = "#ff2f90";
          cyan    = "#aeddff";
          white   = "#ffffff";
        };
        #};
      };
    };
  };
}

