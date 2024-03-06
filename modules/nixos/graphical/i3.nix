{pkgs, config, lib, ...}: {
  config = lib.mkIf pkgs.stdenv.isLinux {
    services.xserver.windowManager = {
      i3 = { enable = config.services.xserver.enable; };
    };
    home-manager.users.${config.user}.xsession = let
	c0 = "#282828";
	c1 = "#cc241d";
	c2 = "#98971a";
	c3 = "#d7991a";
	c8 = "#928374";
	c15 = "#ebdbb2";
in {
	enable = true;
	initExtra = ''
		systemctl --user import-environment
	'';
	windowManager.i3 = {
		enable = true;
		config = {
			startup = [
				{ command = "systemctl --user import-environment"; }
				{ command = "${pkgs.feh}/bin/feh --bg-scale ~/Wallpapers/Tranquility.png"; always = true; notification = false; }
				{ command = "systemctl --user restart polybar"; always = true; notification = false; }
				#{ command = "${home-script}/bin/home-script screen_rotation"; always = false; notification = false; }
			];
			terminal = "kitty";
			workspaceAutoBackAndForth = true;
			window = {
				titlebar = false;
			};
			bars = [];
			assigns = {
				"2" = [{ class = "Google-chrome"; }];
				"3" = [{ class = "Xournalpp"; }];
				"8" = [{ class = "FreeCAD"; }];
				"9" = [{ class = "KiCad"; }];
			};
			colors = {
				focused = {
					background = c2;
					border = c2;
					childBorder = c2;
					indicator = c0;
					text = c0;
				};
				unfocused = {
					background = c0;
					border = c0;
					childBorder = c0;
					indicator = c0;
					text = c15;
				};
				focusedInactive = {
					background = c0;
					border = c0;
					childBorder = c0;
					indicator = c0;
					text = c15;
				};
				urgent = {
					background = c1;
					border = c1;
					childBorder = c1;
					indicator = c0;
					text = c0;
				};
			};
			gaps = {
				top = 50;
				inner = 10;
				smartBorders = "on";
			};
			keybindings = let
				modifier = config.home-manager.users.${config.user}.xsession.windowManager.i3.config.modifier;
			in lib.mkOptionDefault {
				"${modifier}+Return" 	= 	"exec ${pkgs.kitty}/bin/kitty";
				"${modifier}+f" 	= 	"exec ${pkgs.kitty}/bin/kitty -e ${pkgs.lf}/bin/lf";
				"${modifier}+x" 	=	"kill";
				"${modifier}+p" 	=	"exec ${pkgs.rofi-menugen}/bin/rofi-menugen $(which home-script)";
			};
		};
	};
};
  };
}
