{ pkgs, lib, config, ... }:

{
  options = {
    fish = {
      enable = lib.mkEnableOption "Enables fish";
    };
  };

  config = lib.mkIf config.fish.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
	starship init fish | source
      '';
    };
  };
}

