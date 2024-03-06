{ config, pkgs, lib, ... }: {
  imports = [
    ./user.nix
  ];
  config = lib.mkIf pkgs.stdenv.isLinux {
    system.stateVersion = config.home-manager.users.${config.user}.home.stateVersion;
  };
}
