{ config, pkgs, lib, ... }:
{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.enableRedistributableFirmware = true;
  nixpkgs.config.allowUnfree = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  networking.useDHCP = lib.mkDefault true;

  networking.hostName = "x12";
  networking.networkmanager = {
    enable = true;
  };


  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    useXkbConfig = true;
    colors = [
      "282828"
      "cc241d"
      "98971a"
      "d79921"
      "458588"
      "b16286"
      "689d6a"
      "a89984"
      "928374"
      "fb4934"
      "b8bb26"
      "fabd2f"
      "83a598"
      "d3869b"
      "8ec07c"
      "ebdbb2"
    ];
  };
  security.rtkit.enable = true;
  services.openssh.enable = true;
  services.tlp.enable = true;
  services.hardware.bolt.enable = true;
  services.logind.extraConfig = ''
    HandlePowerKey=suspend
    HandlePowerKeyLongPress=suspend
  '';

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}

