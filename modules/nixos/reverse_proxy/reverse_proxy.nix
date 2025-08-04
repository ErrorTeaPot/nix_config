{ config, lib, ... }:
with lib;
let
  # Shorter name to access a final setting
  cfg = config.reverse_proxy;
  srv = config.services.caddy;
in
{
  options.reverse_proxy = {
    enable = mkEnableOption "Enables Caddy as a reverse proxy";
    DNSProviderApiKeyFile = mkOption { type = types.path; };
  };

  config = mkIf cfg.enable {
    services.caddy = {
      enable = true;
    };

    networking.firewall.allowedTCPPorts = [
      80
      443
    ];
    networking.firewall.allowedUDPPorts = [
      80
      443
    ];

    security.acme = {
      acceptTerms = true;
      defaults.email = "nic.eu.org.tylc8@passinbox.com";
      certs."teapot.eu.org" = {
        extraDomainNames = [ "*.teapot.eu.org" ];
        dnsProvider = "desec";
        dnsPropagationCheck = true;
        environmentFile = cfg.DNSProviderApiKeyFile;
      };
    };
  };
}
