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
}
