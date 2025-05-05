{
  imports = [
    ../default.nix
  ];

  boot = {
    enable = true;
    osProber = false;
    latestGenerationMax = 5;
  };
}
