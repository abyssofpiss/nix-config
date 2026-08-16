# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).


{ config, pkgs, ... }:

{
  #  Base System Imports
  imports = [
    ./hardware-configuration.nix
  ];

  #  Graphics and Display Managers
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true; # SDDM will detect and list Hyprland, KDE, and Niri

  #  Keyboard Layout
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  #  Printing Services
  services.printing.enable = true;

  #  Audio Processing Stack (Pipewire Framework)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Bootloader configurations
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelParams = [
    "quiet"
    "splash"
    "amd_pstate=active"
  ];

  # System Swap Space
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 8 * 1024;
  } ];

  # Network & Identity Settings
  networking.hostName = "nixos"; 
  networking.networkmanager.enable = true;

  # Localisation & Time
  time.timeZone = "Asia/Kuala_Lumpur";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Global Nix Configuration
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # User Account Management
  users.users."abyss" = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "abyss";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Core Tools (Always available even if modules fail to load)
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    btop
    kdePackages.bluez-qt
    kdePackages.bluedevil
    bluez
  ];

  # System-wide shell shortcuts
  environment.shellAliases = {
    nixos-switch = "sudo nixos-rebuild switch --flake ~/nix-flake/#nixos";
    list = "ls -l";
  };

  # System State Version
  system.stateVersion = "26.05";
}
