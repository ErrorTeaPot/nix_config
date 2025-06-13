{
	imports = [
		../default.nix
	];

	# Programs
	programs = {
		neovim = {
			enable = true;
			viAlias = true;
			vimAlias = true;
		};
	};

	# Modules
	starship.enable = true;
	alacritty.enable = true;
}
