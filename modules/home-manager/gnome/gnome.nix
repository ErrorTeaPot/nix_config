{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    gnome = {
      enable = lib.mkEnableOption "Enables gnome settings application";
    };
  };

  config = lib.mkIf config.gnome.enable {
    # Change GNOME settings
    dconf.settings = {
      ## Change keybinds
      "org/gnome/desktop/wm/keybindings" = {
        ### Windows manipulations
        close = [ "<Super>q" ];
        maximize = [ "<Alt>k" ];
        minimize = [ "<Alt>j" ];

        ### Move windows across monitors
        move-to-monitor-down = [ "<Super><Shift>Down" ];
        move-to-monitor-left = [ "<Super><Shift>Left" ];
        move-to-monitor-right = [ "<Super><Shift>Right" ];
        move-to-monitor-up = [ "<Super><Shift>Up" ];

        ### Move windows across workspaces
        move-to-workspace-1 = [ "<Shift><Super>1" ];
        move-to-workspace-2 = [ "<Shift><Super>2" ];
        move-to-workspace-3 = [ "<Shift><Super>3" ];
        move-to-workspace-4 = [ "<Shift><Super>4" ];

        ### Switch across workspaces
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-to-workspace-left = [ "<Super>Left" ];
        switch-to-workspace-right = [ "<Super>Right" ];
      };
      ## Change interface
      "org/gnome/desktop/interface" = {
        show-battery-percentage = true;
      };
    };
  };
}
