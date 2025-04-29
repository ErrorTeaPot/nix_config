{ pkgs, lib, config, ... }:
# Comes from https://www.reddit.com/r/NixOS/comments/1aqck9l/systemd_hardening_some_preconfigured_options_d/
{
  options = {
    systemd_hardening = {
      enable = lib.mkEnableOption "Enables Systemd hardening";
    };
  };

  config = lib.mkIf config.systemd_hardening.enable {
    systemd.services = {
      systemd-rfkill = {
	serviceConfig = {
	  ProtectSystem = "strict";
	  ProtectHome = true;
	  ProtectKernelTunables = true;
	  ProtectKernelModules = true;
	  ProtectControlGroups = true;
	  ProtectClock = true;
	  ProtectProc = "invisible"; 
	  ProcSubset = "pid"; 
	  PrivateTmp = true;
	  MemoryDenyWriteExecute = true; #
	  NoNewPrivileges = true;
	  LockPersonality = true; #
	  RestrictRealtime = true; #
	  SystemCallFilter = [ "write" "read" "openat" "close" "brk" "fstat" "lseek" "mmap" "mprotect" "munmap" "rt_sigaction" "rt_sigprocmask" "ioctl" "nanosleep" "select" "access" "execve" "getuid" "arch_prctl" "set_tid_address" "set_robust_list" "prlimit64" "pread64" "getrandom" ];
	  SystemCallArchitectures = "native";
	  UMask = "0077";
	  IPAddressDeny = "any";
	};
      };
    };
  };
}

