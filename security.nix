{ config, pkgs, ... }:

{
  # ClamAV Antivirus Daemon
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
    updater.interval = "daily";
  };

  # Security Apps
  environment.systemPackages = with pkgs; [
    clamav
    proton-vpn
  ];
}
