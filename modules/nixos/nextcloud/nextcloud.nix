{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  # Shorter name to access a final setting
  # All modules are under the custom attribute "def"
  cfg = config.nextcloud;
  srv = config.services.nextcloud;
  url = "nc.teapot.eu.org";
  port = 8003;
in
{
  options.nextcloud = {
    enable = mkEnableOption "Nextcloud suite";
    authFile = mkOption { type = types.path; };
  };

  config = mkIf cfg.enable {
    # Change default port
    services.nginx.virtualHosts.${toString url}.listen = [
      {
        addr = "127.0.0.1";
        port = port;
      }
    ];

    services.nextcloud = {
      enable = true;
      package = pkgs.nextcloud31;
      hostName = url;
      config.adminpassFile = cfg.authFile;
      https = true;

      # Install and configure database automatically
      database.createLocally = true;
      config.dbtype = "sqlite";

      # Applies recommended settings to Redis for small instances
      configureRedis = true;

      # Auto update apps installed from the app store regularly
      autoUpdateApps.enable = true;

      # Enables previews for those file types
      settings.enabledPreviewProviders = [
        "OC\\Preview\\BMP"
        "OC\\Preview\\GIF"
        "OC\\Preview\\JPEG"
        "OC\\Preview\\Krita"
        "OC\\Preview\\MarkDown"
        "OC\\Preview\\MP3"
        "OC\\Preview\\OpenDocument"
        "OC\\Preview\\PNG"
        "OC\\Preview\\TXT"
        "OC\\Preview\\XBitmap"
        "OC\\Preview\\HEIC"
      ];
      # Add trusted proxies to avoid spoffing
      settings.trusted_proxies = [
        "127.0.0.1"
      ];
    };

    ### REVERSE PROXY ###
    services.caddy = {
      virtualHosts.${url} = {
        extraConfig = ''
          reverse_proxy http://localhost:${toString port}
        '';
        useACMEHost = "teapot.eu.org";
      };
    };

    /*
      services.adguardhome.settings.filtering.rewrites = [{
        domain = url;
        answer =
          (builtins.elemAt (config.networking.interfaces.bond0.ipv4.addresses)
            0).address;
      }];

      ### HOMEPAGE ###
      def.homepage.categories."Other"."Miniflux " = {
        icon = "rsshub.png";
        description = "RSS feed handler";
        href = "https://${url}";
      };
    */
  };
}
