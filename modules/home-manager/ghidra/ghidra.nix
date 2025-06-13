{ pkgs, lib, config, ... }:
{
  options = {
    ghidra = {
      enable = lib.mkEnableOption "Enables Ghidra";
    };
  };

  config = lib.mkIf config.ghidra.enable {
    programs.ghidra = {
      enable = true;
      package = pkgs.ghidra.withExtensions (p: with p; [
        ret-sync
	machinelearning
      ]);
    };
  };
}

