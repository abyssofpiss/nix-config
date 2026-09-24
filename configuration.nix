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
  services.xserver.excludePackages = [ pkgs.xterm ];
  # Enable SDDM
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    extraPackages = with pkgs; [
      bibata-cursors
    ];
    settings = {
      Theme = {
        CursorTheme = "Bibata-Modern-Classic";
        CursorSize = "24";
      };
    };
  };

  # Set GStreamer plugin path globally so SDDM and QtMultimedia can find codecs
  environment.sessionVariables = {
    GST_PLUGIN_SYSTEM_PATH_1_0 = "${pkgs.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-bad}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-ugly}/lib/gstreamer-1.0";
  }; 

 #  Keyboard Layout
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  #  Printing Services
  services.printing.enable = false;

  #  Audio Processing Stack (Pipewire Framework)
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    
    extraConfig.pipewire."99-lowlatency" = {
    "context.properties" = {
      "default.clock.rate" = 48000;
      "default.clock.quantum" = 128; 
      "default.clock.min-quantum" = 32;
      "default.clock.max-quantum" = 1024;
      };
    };
  };  

  # Music player daemon
  services.mpd = {
  enable = true;
  user = "abyss";
  
  settings = {
    music_directory = "/home/abyss/Music";
    audio_output = [
      {
        type = "pipewire";
        name = "PipeWire Sound Server";
      }
    ];
  };
};

  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/1000";
  };

  # Bootloader configurations
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber =  true;

  # Theme
  theme = pkgs.stdenv.mkDerivation {
    pname = "evangelion-grub-theme";
    version = "1.0";

    src = pkgs.fetchFromGitHub {
      owner = "Aleph1-9012";
      repo = "Evangelion";
      rev = "fb785c3009a9346173d4b893d6aa36dd22052335";
      hash = "sha256-ZZS0ke8OKHBKuSbRKBHNp+L12UjHD3wqnVGL9OylV5M=";
   };

  installPhase = ''
     mkdir -p $out
     cp -r themes/eva01/720p/* $out/
     '';
    };
  };

  services.upower.enable = true;

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
  networking.networkmanager = {
    enable = true;
  };

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
    extraGroups = [ "networkmanager" "wheel" "audio" ];
  };

  
  # For the DAWs to work optimally
  security.pam.loginLimits = [
    {
      domain = "@audio";
      type = "-";
      item = "rtprio";
      value = "99";
    }
    {
      domain = "@audio";
      type = "-";
      item = "memlock";
      value = "unlimited";
    }
  ];

  # Core Tools (Always available even if modules fail to load)
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    btop
    bluez
    bluetui
    bibata-cursors
    zenity
    shared-mime-info
  ];

  # Cursor
  environment.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    HYPRCURSOR_THEME = "Bibata-Modern-Classic";
    HYPRCURSOR_SIZE = "24";  
  };

  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-cursor-theme-name=Bibata-Modern-Classic
    gtk-cursor-theme-size=24
  '';

  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xsetroot}/bin/xsetroot -xcf ${pkgs.bibata-cursors}/share/icons/Bibata-Modern-Classic/cursors/left_ptr 24
  '';

  # zenity ssh prompt 
  programs.ssh.askPassword = pkgs.lib.mkForce "${pkgs.writeShellScript "zenity-askpass" ''
    ${pkgs.zenity}/bin/zenity --password --title="Authentication Required" --text="$1"
  ''}";

  # stuffs for the files app
  services.gvfs.enable = true;
  services.dbus.enable = true;
  
  programs.dconf = {
    enable = true;
    profiles.user.databases = [
      {
        settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            icon-theme = "Adwaita";
          };
        }; 
      }
    ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  # System-wide shell shortcuts
  environment.shellAliases = {
    nixos-switch = "sudo nixos-rebuild switch --flake ~/nix-flake/#nixos";
  };

  
  # Automatic cleanup 
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  nix.settings.auto-optimise-store = true;

  # System State Version
  system.stateVersion = "26.05";
}
