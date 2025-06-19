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
      # 	starship init fish | source
      interactiveShellInit = ''
	if test -e ~/.nix-profile/etc/profile.d/nix.fish
        . ~/.nix-profile/etc/profile.d/nix.fish
      end
      '';
      functions = {
        fish_greeting = "";
      };
    };
  };
}

