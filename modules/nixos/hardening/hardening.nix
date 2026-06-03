{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  # Shorter name to access a final setting
  cfg = config.hardening;
in
{
  options.hardening = {
    enable = mkEnableOption "Harden things";
  };

  config = mkIf cfg.enable {
  };
}
