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
		git = {
			enable = true;
			extraConfig = {
				pull.rebase = false;
			};
		};
		home-manager.enable = true;
	};

	home.packages = with pkgs; [
		lazygit
		#lf
		btop
		nerd-fonts.caskaydia-cove
		tree
	];

	# Modules
	starship.enable = true;
	#alacritty.enable = true;
}
