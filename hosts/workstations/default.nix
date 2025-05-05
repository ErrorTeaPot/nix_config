{
  imports = [
    ../default.nix
  ];

  boot = {
    enable = true;
    osProber = true;
    latestGenerationMax = 10;
  };

  locale.enable = true;
}
