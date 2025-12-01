{ config, lib, ... }:
with lib;
let
  cfg = config.arr;
  url = "jellyfin.teapot.eu.org";
  port = 8096;
in
{
  options.arr = {
    enable = mkEnableOption "Enables the *arr stack";
    vpnConf = mkOption { type = types.path; };
  };

  config = mkIf cfg.enable {
    nixarr = {
      enable = true;
      mediaDir = "/data/media";
      stateDir = "/data/media/.state/nixarr";

      vpn = {
        enable = true;
        wgConf = config.arr.vpnConf; # Fix: utilise config au lieu de cfg
      };

      jellyfin.enable = true;

      # Retire services.caddy d'ici ! Il va en bas

      transmission = {
        enable = true;
        vpn.enable = true;
        peerPort = 51820;
      };

      recyclarr.enable = true;
      bazarr.enable = true;
      prowlarr.enable = true;
      radarr.enable = true;
      sonarr.enable = true;
      jellyseerr.enable = true;
    };

    services.caddy.virtualHosts."jellyfin.teapot.eu.org" = {
      extraConfig = ''
        reverse_proxy http://localhost:${toString port}
      '';
      useACMEHost = "teapot.eu.org";
    };
  };
}
