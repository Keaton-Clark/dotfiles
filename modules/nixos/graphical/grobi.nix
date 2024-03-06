{ pkgs, config, ...}:
{
  home-manager.users.${config.user}.services.grobi = {
    enable = true;
    rules = [
      {
        name = "Home";
        outputs_connected = [ "DP-3-1-5" ];
        configure_single = "DP-3-1-5";
        primary = true;
        atomic = true;
      }
      {
        name = "Mobile";
        outputs_disconnected = [ "DP-3-1-5" ];
        configure_single = "eDP-1";
        primary = true;
        atomic = true;
      }
    ];
  };
}
