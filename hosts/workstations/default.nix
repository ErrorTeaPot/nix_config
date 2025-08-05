{
  imports = [
    ../default.nix
  ];
  boot.loader.grub = {
    useOSProber = true;
    configurationLimit = 10;
  };
  locale.enable = true;
}
