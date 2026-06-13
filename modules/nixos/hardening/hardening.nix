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
  # Based on https://wiki.nixos.org/wiki/NixOS_Hardening
  options.hardening = {
    enable = mkEnableOption "Harden things";
  };

  config = mkIf cfg.enable {
    # Allow only users to connect to the Nix daemon
    nix.settings.allowed-users = [ "@users" ];

    # Use graphene allocator
    environment.memoryAllocator.provider = "graphene-hardened";
  };
}
