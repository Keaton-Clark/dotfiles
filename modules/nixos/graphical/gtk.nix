{pkgs, config, lib, ...}: {
  home-manager.users.${config.user} = lib.mkIf config.gui.enable {
    home = {
      packages = with pkgs; [
        dconf
        gnome.adwaita-icon-theme
      ];
      sessionVariables = {
        GTK_THEME = "Gruvbox-Dark";
      };
    };
    services = {
      dunst = {
        enable = false;
      };
    };
    gtk = 
    let 
      theme = pkgs.gruvbox-gtk-theme.overrideAttrs(o: { 
        preInstall = ''
          mkdir -p $out/share
          cp -r ./icons $out/share
        '';
      });
    in 
    {
      enable = true;
      font = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
        size = 8;
      };
      iconTheme = {
        package = theme;
        name = "Gruvbox-Dark";
      };
      theme = {
        package = theme;
        name = "Gruvbox-Dark";
      };
    };
  };
}
