# niri-desktop.nix
{ inputs, pkgs, ... }: {

  programs.niri.enable = true;

  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    pkgs.alacritty 
    pkgs.brightnessctl
  ];

  systemd.user.tmpfiles.rules = [
    "d /home/abyss/.config/niri 0755 abyss users - -"
    "L+ /home/abyss/.config/niri/config.kdl - - - - ${pkgs.writeText "config.kdl" ''
      input { keyboard { xkb { layout "us"; }; }; }
      binds {
          "Super+T" { spawn "alacritty"; }
          "Super+D" { spawn "noctalia"; }
          "Super+Q" { close-window; }
      }
      spawn-at-startup "noctalia"
    ''}"
  ];
}
