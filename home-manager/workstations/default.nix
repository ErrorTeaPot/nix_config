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

  home = {
    packages = with pkgs; [
      lazygit
      btop
      nerd-fonts.caskaydia-cove
      tree
      nixfmt-rfc-style
    ];
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.config/cargo/bin"
    ];
    sessionVariables = {
      RUSTUP_HOME = "$HOME/.config/rustup";
      XDG_CONFIG_HOME = "$HOME/.config";
      CARGO_HOME = "$HOME/.config/cargo";
    };
  };

  # Modules
  starship.enable = true;
}
