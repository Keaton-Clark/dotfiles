{pkgs, config, lib, ...}: {
  home-manager.users.${config.user} = lib.mkIf config.gui.enable {
    home.packages = with pkgs; [
      eww
    ];
  };
}
