{pkgs, config, lib, inputs, outputs, ...}: {
  config = lib.mkIf pkgs.stdenv.isLinux {
    programs.hyprland.enable = true;
    home-manager.users.${config.user} = {
      home.file."${config.home-manager.users.${config.user}.home.homeDirectory}/.config/wallpapers" = {
        source = ../../../misc/wallpapers;
        recursive = true;
      };
      services = {
        kanshi = {
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
        hyprpaper = {
          enable = true;
          settings = {
            ipc = "on";
            preload = [ 
              "${config.home-manager.users.${config.user}.home.homeDirectory}/.config/wallpapers/Kojiro.png" 
            ];
            wallpaper = [
              ",${config.home-manager.users.${config.user}.home.homeDirectory}/.config/wallpapers/Kojiro.png" 
            ];
          };
        };
      };
      wayland.windowManager.hyprland = let
        palette = config.home-manager.users.${config.user}.colorScheme.palette;
        terminal = "${pkgs.kitty}/bin/kitty";
        menu = "${pkgs.rofi}/bin/rofi -show drun";
        mainMod = "ALT";
        workspaceMovements = mainMod: (map (i: 
          "${mainMod}, ${toString i}, workspace, ${toString (if i == 0 then 10 else i)}"
        ) [1 2 3 4 5 6 7 8 9 0]);
        moveToWorkspaceMovements = mainMod: (map (i: 
          "${mainMod} SHIFT, ${toString i}, movetoworkspace, ${toString (if i == 0 then 10 else i)}"
        ) [1 2 3 4 5 6 7 8 9 0]);
      in {
        enable = true;
        systemd.enable = true;
        xwayland.enable = true;
        settings = {
          "$terminal" = "${terminal}";
          monitor = ", preferred, auto, 1";
          bind = [
            "${mainMod}, Return, exec, ${terminal}"
            "${mainMod}, P, exec, ${menu}"
            "${mainMod}, X, killactive"
            # tmux move
            "${mainMod}, Z, fullscreen"
            # vim move
            "${mainMod}, h, movefocus, l"
            "${mainMod}, l, movefocus, r"
            "${mainMod}, k, movefocus, u"
            "${mainMod}, j, movefocus, d"
            # special workspace
            "${mainMod}, S, togglespecialworkspace, launcher"
          ] 
          # workspace move
          ++ workspaceMovements "${mainMod}"
          ++ moveToWorkspaceMovements "${mainMod}";

          workspace = [
            "1,persistent:true,defaultName:一"
            "2,persistent:true,defaultName:二"
            "3,persistent:true,defaultName:三"
            "4,persistent:true,defaultName:四"
            "5,persistent:true,defaultName:五"
            "6,persistent:true,defaultName:六"
            "7,persistent:true,defaultName:七"
            "8,persistent:true,defaultName:八"
            "9,persistent:true,defaultName:九"
            "10,persistent:true,defaultName:十"
            "special:launcher, on-created-empty:${terminal}"
          ];

          general = {
            gaps_in = 0;
            gaps_out = 0;
            border_size = 2;
            "col.active_border" = "0xff${palette.base0B}";
            "col.inactive_border" = "0xff${palette.base00}";
            layout = "master";
            allow_tearing = false;
          };
          input = {
            kb_layout = "us";
          };
          master = {
            new_status = "master";
          };
          windowrulev2 = [
            "suppressevent maximize, class:.*"
          ];
          exec = [
            "${inputs.astal.packages.x86_64-linux.io}/bin/astal -q || true && ${inputs.self.packages.x86_64-linux.astal-lua}/bin/astal-lua"
          ];
        };
        extraConfig = ''
          #exec-once=kill $(pidof gjs) && ags -c ~/.config/ags/config.js
          #exec-once = ${pkgs.swww}/bin/swww-daemon & sleep 0.1 && ${pkgs.swww}/bin/swww img ~/.config/nix/misc/wallpapers/Kojiro.png
        '';
      };
    };
  };
}
