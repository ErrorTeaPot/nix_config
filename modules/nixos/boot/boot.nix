{ lib, config, ... }:
{
  options = {
    boot = {
      enable = lib.mkEnableOption "Defines GRUB as UEFI bootloader";
      osProber = lib.mkOption {
        default = true;
        type = lib.types.bool;
        description = "Whether to enable the discovery of other OSes";
      };
      latestGenerationMax = lib.mkOption {
        default = 10;
        type = lib.types.int;
        description = "Maximum number of latest generations in the boot menu";
      };
    };
  };

  config = lib.mkIf config.boot.enable {
    boot.loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev"; # Mandatory for UEFI installations
      useOSProber = config.boot.osProber;
      configurationLimit = config.boot.latestGenerationMax;
    };
  };
}

