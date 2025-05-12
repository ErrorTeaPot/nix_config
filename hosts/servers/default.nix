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
	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEHnXHo03QDAr1wWMGeURKgNOkJsholGnzl+8w5O7oyl"
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
