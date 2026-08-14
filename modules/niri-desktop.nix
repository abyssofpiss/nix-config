# niri-desktop.nix
{ inputs, pkgs, ... }: {

  # System packages go at the top level, NOT inside programs.niri
  environment.systemPackages = [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default 
    pkgs.brightnessctl
    pkgs.kitty
    pkgs.fuzzel
    pkgs.qt6.qtwayland
    pkgs.qt6.qtbase
    pkgs.libxcb-cursor
  ];

  environment.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_PLUGIN_PATH = "${pkgs.qt6.qtwayland}/lib/qt-6/plugins:${pkgs.qt6.qtbase}/lib/qt-6/plugins";
  };

  programs.niri = {
    enable = true;
    package = pkgs.niri;
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
