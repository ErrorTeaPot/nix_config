{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    fish = {
      enable = lib.mkEnableOption "Enables fish";
    };
  };

  config = lib.mkIf config.fish.enable {
    programs = {
      fish = {
        enable = true;
        interactiveShellInit = ''
          	if test -e ~/.nix-profile/etc/profile.d/nix.fish
                  . ~/.nix-profile/etc/profile.d/nix.fish
                end
        '';
        functions = {
          fish_greeting = "";
        };
        shellAliases = {
          "man" = "batman";
        };
      };
      bat = {
        enable = true;
        extraPackages = with pkgs.bat-extras; [
          batdiff
          batman
          batgrep
          batwatch
        ];
      };
    };
  };
}
