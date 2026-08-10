# hyprland-desktop.nix
{ pkgs, ... }: {
  # Enable Hyprland window manager
  programs.hyprland.enable = true;
  
  # Crucial for scaling Electron/Chromium apps on Wayland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Hyprland UI/Rice ecosystem packages
  environment.systemPackages = with pkgs; [
    kitty       # Terminal emulator
    eww         # Widget/Bar builder
    quickshell  # Modern Qt shell runner
    rofi        # Application launcher
    matugen     # Material You color generator
  ];
}
