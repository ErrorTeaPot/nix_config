{ config, lib, ... }:
with lib;
let
  # Shorter name to access a final setting
  cfg = config.reverse_proxy;
in {
  options.reverse_proxy = {
    enable = mkEnableOption "Enables Caddy as a reverse proxy";
  };

  config = mkIf cfg.enable {
    services.caddy = {
      enable = true;
    };
    networking.firewall.allowedTCPPorts = [80 443];
    security.acme = {
      acceptTerms = true;
      defaults.email = "nic.eu.org.tylc8@passinbox.com";
      certs."teapot.eu.org" = {
        extraDomainNames = [ "*.teapot.eu.org" ];
        #dnsProvider = "cloudflare";
        #dnsResolver = "1.1.1.1:53";
        #dnsPropagationCheck = true;
        #environmentFile = cfg.cloudflareKeyFile;
      };
    };
  };
}
