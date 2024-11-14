{pkgs, config, lib, inputs, ...}: {
  services.upower.enable = true;
  systemd.user.services.ags = {
    enable = true;
    description = "Start ags";
    unitConfig = {
    };
    serviceConfig = {
      ExecStart = "kill $(pidof gjs) && ${pkgs.ags}/bin/ags -c /home/kc/.config/ags/config.js";
    };
    wantedBy = [ "graphical.target" ];
  };
  home-manager.users.${config.user} = lib.mkIf config.gui.enable {
    imports = [ inputs.ags.homeManagerModules.default ];
    #xdg.configFile."ags" = { source = ./config; recursive = true; };
    programs.ags = {
      enable = true;
      extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
        libdbusmenu-gtk3
      ];
    };
  };
}
