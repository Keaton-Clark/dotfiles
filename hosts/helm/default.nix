{ inputs, globals, overlays, ... }:
inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    globals
    inputs.home-manager.nixosModules.home-manager
    ../../configuration.nix 
    ../../modules/nixos 
    ../../modules/common
    {
      nixpkgs.overlays = overlays;
      gui.enable = true;
      passwordHash = inputs.nixpkgs.lib.fileContents ../../misc/password.sha512;
      hardware.enableRedistributableFirmware = true;
    }
  ];
}
