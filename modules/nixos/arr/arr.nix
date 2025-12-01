{ config, lib, ... }:
with lib;
let
  cfg = config.arr;
  url = "jellyfin.teapot.eu.org";
  jellyfin_port = 8096;
  radarr_port = 7878;
  sonarr_port = 8989;
  vpn_forwarded_port = 51820;
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
        wgConf = config.arr.vpnConf;
      };

      jellyfin.enable = true;

      transmission = {
        enable = true;
        vpn.enable = true;
        peerPort = vpn_forwarded_port;
      };

      recyclarr = {
        enable = true;
        configuration = {
          sonarr = {
            series = {
              base_url = "http://localhost:${toString sonarr_port}";
              api_key = "!env_var SONARR_API_KEY";
              quality_definition = {
                type = "series";
              };
              delete_old_custom_formats = true;
            };
          };
          radarr = {
            movies = {
              base_url = "http://localhost:${toString radarr_port}";
              api_key = "!env_var RADARR_API_KEY";
              quality_definition = {
                type = "movie";
              };
              delete_old_custom_formats = true;
            };
          };
        };
      };
      bazarr.enable = true;
      prowlarr.enable = true;
      radarr.enable = true;
      sonarr.enable = true;
      jellyseerr.enable = true;
    };

    services.caddy.virtualHosts.${toString url} = {
      extraConfig = ''
        reverse_proxy http://localhost:${toString jellyfin_port}
      '';
      useACMEHost = "teapot.eu.org";
    };
  };
}
