{ inputs, globals, overlays, ... }:
inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  specialArgs = {inherit inputs;};
  modules = [
    globals
    inputs.home-manager.nixosModules.home-manager
    inputs.wsl.nixosModules.wsl
    ../../modules/common
    {
      nixpkgs.overlays = overlays;
      gui.enable = false;
      #passwordHash = inputs.nixpkgs.lib.fileContents ../../misc/password.sha512;
      hardware.enableRedistributableFirmware = true;
      wsl = {
        enable = true;
        wslConf.automount.root = "/mnt";
        defaultUser = globals.user;
        startMenuLaunchers = true;
        nativeSystemd = true;
        wslConf.network.generateResolvConf = true; # Turn off if it breaks VPN
      };
    }
  ];
}
