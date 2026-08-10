# niri-desktop.nix
{ inputs, pkgs, ... }: {

  programs.niri.enable = true;

  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.alacritty 
    pkgs.brightnessctl
  ];
}
