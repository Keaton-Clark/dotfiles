{
  description = "System flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim/nixos-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixvim, ... }@inputs: 
  let
    overlays = [
      (import ./overlays/rofi-menugen.nix)
    ];
    
    globals = {
      user = "kc";
      fullName = "Keaton Clark";
      email = "keatonclark2@gmail.com";
      timeZone = "America/Los_Angeles";
    };

    system = "x86_64-linux";

    nixvim' = nixvim.legacyPackages.${system};
    nixvimModule = {
      module = import ./modules/common/shell/neovim;
    };
    nvim = nixvim'.makeNixvimWithModule nixvimModule;
  in rec
  {
    nixosConfigurations = {
      helm = import ./hosts/helm { inherit inputs globals overlays; };
    };
    packages = {
      x86_64-linux.neovim = nvim;
    };
    templates = {
      latex = {
        path = ./templates/latex;
        description = "latex template with bells and whistles";
        welcomeText = "latex flake created";
      };
    };
  };
}
