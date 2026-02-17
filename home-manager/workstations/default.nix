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
      settings = {
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

  # Change GNOME settings
  dconf.settings = {
    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Terminal";
      command = "ptyxis --new-window";
      binding = "<Super>Return";
    };
  };

  # Modules
  starship.enable = true;
}
