{
	imports = [
		./systemd_hardening/systemd_hardening.nix
		./locale/locale.nix
		./boot/boot.nix
		./ssh_hardening/ssh_hardening.nix
		./reverse_proxy/reverse_proxy.nix
		#./rss/rss.nix
	];
}
