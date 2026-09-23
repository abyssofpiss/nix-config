# /etc/nixos/flake.nix
{
  description = "Hyprland, KDE and Niri + other stuff";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgsveryold.url = "github:nixos/nixpkgs?ref=nixos-21.11";
    
    #Niri Flake
    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";

    # noctalia
    noctalia.url = "github:noctalia-dev/noctalia";
    noctalia.inputs.nixpkgs.follows = "nixpkgs";

    # Qylock SDDM lockscreen
    qylock.url = "github:Darkkal44/qylock";
    qylock.inputs.nixpkgs.follows = "nixpkgs";
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
        inputs.qylock.nixosModules.default
        ./hardware-configuration.nix   
        ./configuration.nix            
        
        # --- Desktop Modules ---
        ./modules/niri-desktop.nix
        
        # --- Modules ---
        ./modules/apps.nix                     
        ./modules/gaming.nix                    
        ./modules/security.nix
        
        # --- Qylock SDDM config ---
        ({ pkgs, ... }: {
          services.displayManager.sddm.enable = true;
          services.displayManager.sddm.wayland.enable = true;

          programs.qylock = {
            enable = true;
            theme = "pixel-munchlax";

            themeOptions = {
              terraria.backgroundMode = "time";
              Genshin.backgroundMode = "time";
              clockwork.orbital = { themeMode = "dark"; enableWindup = true; };
              osu.gameMode = "menu";
            };
          };
        }) 
      ];
    };

    packages.x86_64-linux.hello = pkgs.hello;
    packages.x86_64-linux.default = pkgs.hello;

    devShells.x86_64-linux.default = pkgs.mkShell {
      buildInputs = [ pkgs.neovim pkgsold.vim ];
    };
  };
}

