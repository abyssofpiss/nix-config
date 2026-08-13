# /etc/nixos/flake.nix
{
  description = "Hyprland and KDE NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgsveryold.url = "github:nixos/nixpkgs?ref=nixos-21.11";
    
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
        ./hardware-configuration.nix   
        ./configuration.nix            
        
        # --- Desktop Modules ---
        ./modules/hyprland-desktop.nix         
        ./modules/kde-desktop.nix
        
        # --- Modules ---
        ./modules/apps.nix                     
        ./modules/gaming.nix                    
        ./modules/security.nix                 
      ];
    };

    packages.x86_64-linux.hello = pkgs.hello;
    packages.x86_64-linux.default = pkgs.hello;

    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [ pkgs.neovim pkgsold.vim ];
    };
  };
}
