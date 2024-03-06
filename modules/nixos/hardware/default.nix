{ config, pkgs, lib, ... }: {
  imports = [
    ./boot.nix ./disks.nix
  ];
  config = {
    hardware = {
      sensor.iio.enable = true;
      opengl.enable = true;
      opengl.driSupport = true;
      nvidia.modesetting.enable = true;
      bluetooth.enable = true;
      bluetooth.powerOnBoot = true;
      opentabletdriver.enable = true;
    };
  };
}
