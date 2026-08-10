{
  description = "Niri, Hyprland, and KDE NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgsveryold.url = "github:nixos/nixpkgs?ref=nixos-21.11";
    
    # niri
    niri.url = "github:epireyn/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";
    
    # noctalia
    noctalia.url = "github:noctalia-dev/noctalia";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, ... } @ inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    pkgsold = inputs.nixpkgsveryold.legacyPackages.${system};
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; }; 
      modules = [
        inputs.niri.nixosModules.niri 
        ./hardware-configuration.nix   
        ./configuration.nix           
        
        # --- Desktop Modules ---
        ./hyprland-desktop.nix         
        ./kde-desktop.nix
        ./niri-desktop.nix              
        
        # --- Modules ---
        ./apps.nix                     
        ./gaming.nix                   
        ./security.nix                 
      ];
    };
        # Change from packages.${system}... to this:
    packages.x86_64-linux.hello = pkgs.hello;
    packages.x86_64-linux.default = pkgs.hello;

    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [ pkgs.neovim pkgsold.vim ];
    };
  };
}
