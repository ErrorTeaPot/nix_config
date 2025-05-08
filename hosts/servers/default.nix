{
  imports = [
    ../default.nix
  ];

  boot = {
    enable = true;
    osProber = false;
    latestGenerationMax = 5;
  };

  ssh_hardening = true;

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
      ];
    };
  };
}
