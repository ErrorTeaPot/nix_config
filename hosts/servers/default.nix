{
  pkgs,
  ...
}:
{
  imports = [
    ../default.nix
  ];

  boot = {
    enable = true;
    osProber = false;
    latestGenerationMax = 5;
  };

  ssh_hardening.enable = true;

  users.users = {
    errorteapot = {
      isNormalUser = true;
      description = "ErrorTeaPot";
      extraGroups = ["wheel"];
      shell = pkgs.fish;
      packages = with pkgs; [
      ];
      openssh.authorizedKeys.keys = [
	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP1KhwTRJecS2kYGqAeHXvivJ2iGaKVM/okZql+oJ+Vr errorteapot@TeaPotDesktopL"
	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBPQLLFjq1/8alUiLTT1JPSzODrI+dWl0ljf9GmzPd7I errorteapot@TeaPotLaptop"
	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJyyAfU0petElWTiMR+tm9+ohErzlYYm0hlKwflrmfe+"
      ];
    };
    /*
    root = {
      openssh.authorizedKeys.keys = [
	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP1KhwTRJecS2kYGqAeHXvivJ2iGaKVM/okZql+oJ+Vr errorteapot@TeaPotDesktopL"
	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBPQLLFjq1/8alUiLTT1JPSzODrI+dWl0ljf9GmzPd7I errorteapot@TeaPotLaptop"
      ];
    };
    */
  };
}
