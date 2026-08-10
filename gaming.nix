{ config, pkgs, ... }:

{
  # PlayStation controller kernel support
  boot.kernelModules = [ "hid-playstation" ];

  # Controller Bluetooth stability fix
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        JustWorksRepairing = "always"; 
      };
    };
  };

  # Gaming Launcher
  environment.systemPackages = with pkgs; [
    lutris
    eden
  ];
}
