{pkgs, config, lib, inputs, ...}: {
  config = lib.mkIf pkgs.stdenv.isLinux {
    programs.hyprland.enable = true;
    home-manager.users.${config.user} = {
      services.kanshi = {
        enable = true;
        systemdTarget = "xdg-desktop-portal-hyprland.service";
        profiles = {
          undocked = {
            outputs = [
              {
                criteria = "eDP-1";
              }
            ];
          };
          docked = {
            outputs = [
              {
                criteria = "eDP-1";
                status = "disable";
              }
              {
                criteria = "Creatix Polymedia GmbH 315-DP 82282400300";
                mode = "2560x1440@59.95100";
                position = "0,0";
              }
            ];
          };
        };
      };
      wayland.windowManager.hyprland = let
        c0 = "#282828";
        c1 = "#cc241d";
        c2 = "#98971a";
        c3 = "#d7991a";
        c8 = "#928374";
        c15 = "#ebdbb2";
      in {
        enable = true;
        systemd.enable = true;
        xwayland.enable = true;
        extraConfig = ''
          # See https://wiki.hyprland.org/Configuring/Keywords/ for more

          # Execute your favorite apps at launch
          monitor=eDP-1,1920x1280@60,0x0,1
          debug:disable_logs=false
          debug:enable_stdout_logs=true
          #exec-once=kill $(pidof gjs) && ags -c ~/.config/ags/config.js
          #exec-once = ${pkgs.swww}/bin/swww-daemon & sleep 0.1 && ${pkgs.swww}/bin/swww img ~/.config/nix/misc/wallpapers/Kojiro.png
          # Source a file (multi-file configs)

          # Set programs that you use
          $terminal = kitty
          $menu = ${pkgs.rofi}/bin/rofi -show drun

          # Some default env vars.
          env = XCURSOR_SIZE,24
          env = QT_QPA_PLATFORMTHEME,qt5ct # change to qt6ct if you have that

          # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
          input {
              kb_layout = us
              kb_variant =
              kb_model =
              kb_options =
              kb_rules =

              follow_mouse = 1

              touchpad {
                  natural_scroll = no
              }

              sensitivity = 0 # -1.0 to 1.0, 0 means no modification.
          }

          general {
              # See https://wiki.hyprland.org/Configuring/Variables/ for more
              gaps_in = 5
              gaps_out = 10
              border_size = 2
              col.active_border = rgb(b8bb26) rgb(b8bb26)
              col.inactive_border = rgb(1d2021) rgb(1d2021)
              layout = dwindle
              # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
              allow_tearing = false
          }

          decoration {
              rounding = 0
              blur {
                  enabled = true
                  size = 3
                  passes = 1
              }
          }

          animations {
              enabled = yes

              # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

              bezier = myBezier, 0.05, 0.9, 0.1, 1.05

              animation = windows, 1, 7, myBezier
              animation = windowsOut, 1, 7, default, popin 80%
              animation = border, 1, 10, default
              animation = borderangle, 1, 8, default
              animation = fade, 1, 7, default
              animation = workspaces, 1, 6, default
          }

          dwindle {
              # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
              pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
              preserve_split = yes # you probably want this
          }

          master {
              # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
              new_is_master = true
          }

          gestures {
              # See https://wiki.hyprland.org/Configuring/Variables/ for more
              workspace_swipe = off
          }

          misc {
              # See https://wiki.hyprland.org/Configuring/Variables/ for more
              force_default_wallpaper = 0 # Set to 0 or 1 to disable the anime mascot wallpapers
          }

          # Example windowrule v1
          # windowrule = float, ^(kitty)$
          # Example windowrule v2
          # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
          # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
          windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.


          # See https://wiki.hyprland.org/Configuring/Keywords/ for more
          $mainMod = ALT

          # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
          bind = $mainMod, Return, exec, $terminal
          bind = $mainMod, X, killactive, 
          bind = $mainMod, V, togglefloating, 
          bind = $mainMod, P, exec, $menu
          #bind = $mainMod, P, pseudo, # dwindle
          bind = $mainMod, J, togglesplit, # dwindle

          # Move focus with mainMod + arrow keys
          bind = $mainMod, left, movefocus, l
          bind = $mainMod, right, movefocus, r
          bind = $mainMod, up, movefocus, u
          bind = $mainMod, down, movefocus, d

          # Switch workspaces with mainMod + [0-9]
          bind = $mainMod, 1, workspace, 1
          bind = $mainMod, 2, workspace, 2
          bind = $mainMod, 3, workspace, 3
          bind = $mainMod, 4, workspace, 4
          bind = $mainMod, 5, workspace, 5
          bind = $mainMod, 6, workspace, 6
          bind = $mainMod, 7, workspace, 7
          bind = $mainMod, 8, workspace, 8
          bind = $mainMod, 9, workspace, 9
          bind = $mainMod, 0, workspace, 10

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          workspace=1,persistent:true,defaultName:一
          workspace=2,persistent:true,defaultName:二
          workspace=3,persistent:true,defaultName:三
          workspace=4,persistent:true,defaultName:四
          workspace=5,persistent:true,defaultName:五
          workspace=6,persistent:true,defaultName:六
          workspace=7,persistent:true,defaultName:七
          workspace=8,persistent:true,defaultName:八
          workspace=9,persistent:true,defaultName:九
          workspace=10,persistent:true,defaultName:十


          bind = $mainMod SHIFT, 1, movetoworkspace, 1
          bind = $mainMod SHIFT, 2, movetoworkspace, 2
          bind = $mainMod SHIFT, 3, movetoworkspace, 3
          bind = $mainMod SHIFT, 4, movetoworkspace, 4
          bind = $mainMod SHIFT, 5, movetoworkspace, 5
          bind = $mainMod SHIFT, 6, movetoworkspace, 6
          bind = $mainMod SHIFT, 7, movetoworkspace, 7
          bind = $mainMod SHIFT, 8, movetoworkspace, 8
          bind = $mainMod SHIFT, 9, movetoworkspace, 9
          bind = $mainMod SHIFT, 0, movetoworkspace, 10

          # Example special workspace (scratchpad)
          bind = $mainMod, S, togglespecialworkspace, launcher
          workspace = special:launcher, on-created-empty:kitty

          # Scroll through existing workspaces with mainMod + scroll
          bind = $mainMod, mouse_down, workspace, e+1
          bind = $mainMod, mouse_up, workspace, e-1

          # Move/resize windows with mainMod + LMB/RMB and dragging
          bindm = $mainMod, mouse:272, movewindow
          bindm = $mainMod, mouse:273, resizewindow
        '';
      };
    };
  };
}
