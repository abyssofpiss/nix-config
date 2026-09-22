# niri-desktop.nix
{ inputs, pkgs, ... }: {

  # System packages go at the top level, NOT inside programs.niri
  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default 
    pkgs.brightnessctl
    pkgs.kitty
    pkgs.fuzzel
    pkgs.xwayland-satellite
  ];

  programs.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.default;
  };
 
  # Config
  environment.etc."niri/config.kdl".text = ''
    input {
      keyboard {
        xkb {
          layout "us"
        }
      }
      touchpad {
        tap
        natural-scroll
      }
    }

    binds {
      Mod+Return { spawn "kitty"; }
      Mod+Q { close-window; }
    }
  '';
}
