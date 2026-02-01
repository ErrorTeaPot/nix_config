{
  pkgs,
  lib,
  config,
  ...
}:

{
  options = {
    hyprland = {
      enable = lib.mkEnableOption "Enables Hyprland";
    };
  };

  config = lib.mkIf config.hyprland.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;
      settings = {
        # Monitors configuration
        monitor = [
          "DP-2, 1920x1080@144, auto, 1"
          "eDP-1, 1920x1080@60.00300, auto, 1"
          ",preferred,auto,1"
        ];

        # Execute commands at launch
        exec-once = [
          "systemctl --user start hyprpolkitagent"
          #"swww-daemon; sleep 0.05; swww img $HOME/Pictures/Wallpapers/mario_8_bit.gif"
          "uwsm app -- waybar"
          "uwsm app -- dbus-update-activation-environment --all"
          #"uwsm app -- gammastep -l 48.8:2.3"
        ];

        # Set programs
        "$terminal" = "alacritty";
        "$fileManager" = "nautilus";
        "$menu" = "uwsm app -- $(wofi --show drun --define=drun-print_desktop_file=true)";

        # Environment variables
        env = [
          "XCURSOR_SIZE,24;"
          "QT_QPA_PLATFORMTHEME,qt5ct;"
        ];

        # Input settings
        input = {
          kb_layout = "us";
          kb_variant = "intl";
          follow_mouse = true;
          touchpad = {
            natural_scroll = true;
          };
          sensitivity = 0;
        };

        # General settings
        general = {
          gaps_in = 5;
          gaps_out = 5;
          border_size = 2;
          "col.active_border" = "rgb(44475a) rgb(bd93f9) 90deg";
          "col.inactive_border" = "rgba(44475aaa)";
          "col.nogroup_border" = "rgba(282a36dd)";
          "col.nogroup_border_active" = "rgb(bd93f9) rgb(44475a) 90deg";
          resize_on_border = true;
          no_border_on_floating = false;
          layout = "dwindle";
          allow_tearing = false;
        };

        # Decoration settings
        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1E202966)";
          };
        };

        # Animations settings
        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        # Dwindle layout settings
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        # Master layout settings
        master = {
          # new_is_master = true;
        };

        # Gestures settings
        gesture = "3, horizontal, workspace";

        # Group settings
        group = {
          groupbar = {
            "col.active" = "rgb(bd93f9) rgb(44475a) 90deg";
            "col.inactive" = "rgba(282a36dd)";
          };
        };

        # Miscellaneous settings
        misc = {
          force_default_wallpaper = -1;
        };

        # Window rules
        windowrulev2 = [
          "opacity 0.8 0.8, class:(kitty),title:(kitty)"
          "bordercolor rgb(ff5555),xwayland:1"
        ];

        # Key bindings
        "$mainMod" = "SUPER";
        bind = [
          "$mainMod, RETURN, exec, $terminal"
          "$mainMod, Q, killactive,"
          "$mainMod, M, exit,"
          "$mainMod, E, exec, $fileManager"
          "$mainMod, V, togglefloating,"
          "$mainMod, D, exec, $menu"
          "$mainMod, P, pseudo,"
          "$mainMod, J, togglesplit,"
          "$mainMod, L, exec, hyprlock"
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ", XF86MonBrightnessUp, exec, brightnessctl set 5%+"
          "$mainMod SHIFT , S, exec, grim -g \"$(slurp)\" - | wl-copy"
        ];

        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        binde = [
          ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"
        ];
      };
    };
  };
}
