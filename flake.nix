{
  description = "System flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    utils.url = "github:numtide/flake-utils";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags.url = "github:Aylur/ags";
  };
  outputs = { self, nixpkgs, nixvim, utils, ... }@inputs: 
  let
    overlays = [
      (import ./overlays/rofi-menugen.nix { inherit nixpkgs system; })
    ];
    
    globals = {
      user = "kc";
      fullName = "Keaton Clark";
      email = "keatonclark2@gmail.com";
      timeZone = "America/Los_Angeles";
    };

    system = "x86_64-linux";

    nvim = nixvim.legacyPackages.${system}.makeNixvimWithModule {
      module = import ./packages/neovim;
    };
  in {
    nixosConfigurations = {
      helm = import ./hosts/helm { inherit inputs globals overlays; };
      hardtack = import ./hosts/hardtack { inherit inputs globals overlays; };
    };
    packages.${system} = {
      neovim = nvim;
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
