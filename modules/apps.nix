{ config, pkgs, ... }:

{
  # Firefox with Telemetry Disabled
  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
    };
  };

  # Daily Drivers and Terminal Utilities
  environment.systemPackages = with pkgs; [
    # Social/Office
    discord
    telegram-desktop
    obsidian
    onlyoffice-desktopeditors

    # CLI Rice & Visuals
    cbonsai
    cmatrix
    cava
    pipes
    fastfetch

    # Utilities
    stow
    yt-dlp
    unrar
    killall
  ];
}
