{
  imports = [
    ../default.nix
  ];

  # Enables OsProber for dual boot, set a good amount of generations
  boot.loader.grub = {
    useOSProber = true;
    configurationLimit = 10;
  };

  locale.enable = true;
}
