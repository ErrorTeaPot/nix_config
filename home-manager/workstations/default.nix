{
	pkgs,
	...
}:
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

	home.packages = with pkgs; [
		lazygit
		lf
		btop
		nerd-fonts.caskaydia-cove
		tree
	];

	# Modules
	starship.enable = true;
	alacritty.enable = true;
}
