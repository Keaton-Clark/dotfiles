{ config, pkgs, lib, ... }: {
  config = lib.mkIf config.gui.enable {
    services.xserver = {
      enable = config.gui.enable;
      libinput.enable = true;
      displayManager.startx = {
	enable = config.services.xserver.enable;
      };
    };
  };
}
