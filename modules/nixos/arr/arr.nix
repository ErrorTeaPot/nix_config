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
    /*
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
                include = [
                  # Movie
                  { template = "radarr-quality-definition-movie"; }
                  { template = "radarr-quality-profile-remux-web-1080p"; }
                  { template = "radarr-custom-formats-remux-web-1080p"; }

                  # Anime
                  { template = "radarr-quality-definition-anime"; }
                  { template = "radarr-quality-profile-anime"; }
                  { template = "radarr-custom-formats-anime"; }
                ];
                custom_formats = [
                  {
                    trash_ids = [
                      "064af5f084a0a24458cc8ecd3220f93f" # Uncensored
                      "9172b2f683f6223e3a1846427b417a3d" # VOSTFR
                    ];
                    assign_scores_to = [
                      {
                        name = "Remux-1080p - Anime";
                      }
                    ];
                  }
                ];
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
    */
  };
}
