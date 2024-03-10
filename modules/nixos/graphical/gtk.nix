{pkgs, config, lib, ...}: {
  home-manager.users.${config.user} = lib.mkIf config.gui.enable {
    home.packages = with pkgs; [
      xournalpp
      dconf
      gnome.adwaita-icon-theme
      kicad
    ];
    gtk = lib.mkIf config.gui.enable {
      enable = true;
      font = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetBrainsMono Nerd Font";
        size = 8;
      };
      theme = {
        package = pkgs.gruvbox-dark-gtk;
        name = "gruvbox-dark";
      };
    };
  };
}
