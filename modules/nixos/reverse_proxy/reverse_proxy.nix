{ config, lib, ... }:
with lib;
let
  cfg = config.reverse_proxy;
in
{
  options.reverse_proxy = {
    enable = mkEnableOption "Enables Caddy as a reverse proxy";
    DNSProviderApiKeyFile = mkOption { type = types.path; };
  };

  config = mkIf cfg.enable {

    # Add a service user
    users.users.reverse-proxy = {
      isSystemUser = true;
      group = "reverse-proxy";
    };

    # Add a service group
    users.groups.reverse-proxy = { };

    # Enables caddy web server to be used as a reverse proxy
    services.caddy = {
      enable = true;
      user = "reverse-proxy";
      group = "reverse-proxy";
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
