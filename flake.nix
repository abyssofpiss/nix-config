{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgsveryold.url = "github:nixos/nixpkgs?ref=nixos-21.11";
  };

  outputs = {nixpkgs, ... } @ inputs:
  let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
    pkgsold = inputs.nixpkgsveryold.legacyPackages.x86_64-linux;
  in
  {

   packages.x86_64-linux.hello = pkgs.hello;
   
   packages.x86_64-linux.default = pkgs.hello;

   devShells.x86_64-linux.default = pkgs.mkShell {
     buildInputs = [ pkgs.neovim pkgsold.vim ];
   };
  
  };
}
