{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    tooling = {
      enable = lib.mkEnableOption "Enables cybersecurity tooling";
    };
  };

  config = lib.mkIf config.tooling.enable {
    home = {
      packages = with pkgs; [
        pwntools
        hashcat
        wordlists
        ghidra
        gef
      ];
    };
  };
}
