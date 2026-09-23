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

  # games and apps that make the games work
  environment.systemPackages = with pkgs; [
    lutris
    eden
    osu-lazer
  ];
}
