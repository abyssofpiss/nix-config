{ config, pkgs, ... }:

{
  # Fonts
  fonts = {
    enableDefaultPackages = true;
    
    packages = with pkgs; [
     nerd-fonts.mononoki
     nerd-fonts.agave
     nerd-fonts.symbols-only
     font-awesome
     noto-fonts
     noto-fonts-color-emoji
    ];
  };

  # Firefox with Telemetry Disabled
  programs.firefox = {
    enable = true;
    policies = {
      DisableTelemetry = true;
    };
  };

  # Zsh 
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;

    interactiveShellInit = ''
      # Quality of life & History
      HISTFILE=~/.zsh_history
      HISTSIZE=10000
      SAVEHIST=10000
      setopt SHARE_HISTORY
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_SPACE
      setopt AUTO_CD

      # Kitty Integration
      if test -n "$KITTY_INSTALLATION_DIR"; then
          export KITTY_SHELL_INTEGRATION="enabled"
          source "$KITTY_INSTALLATION_DIR/shell-integration/zsh/kitty.zsh"
      fi
    '';
  };

  # Starship
programs.starship = {
  enable = true;

  settings = {
    format = "[](#36a166)[  $username ](bg:seafoam fg:black)[](bg:blue fg:seafoam)[ $directory ](bg:blue fg:black)[](bg:black fg:blue)[ $git_branch $git_status ](bg:black fg:seafoam)[ $nodejs$rust$golang$php ](bg:black fg:green)[](bg:black fg:black)[  $time ](bg:black fg:light_grey)[](fg:black)\n$character";

    palette = "estuary_light";

    palettes.estuary_light = {
      seafoam    = "#36a166"; # Active highlight / primary pill
      green      = "#5b9d48"; # Secondary accents / dev icons
      blue       = "#5f9182"; # Secondary pill background
      black      = "#22221b"; # Base dark background / high-contrast text
      light_grey = "#929181"; # Muted text & time indicator
    };

    username = {
      show_always = true;
      style_user = "bg:seafoam fg:black bold";
      style_root = "bg:seafoam fg:black bold";
      format = "[$user]($style)";
    };

    directory = {
      style = "bg:blue fg:black bold";
      format = "[$path]($style)";
      truncation_length = 3;
      truncation_symbol = "…/";
    };

    git_branch = {
      symbol = "";
      style = "bg:black fg:seafoam";
      format = "[ $symbol $branch ]($style)";
    };

    git_status = {
      style = "bg:black fg:green";
      format = "[$all_status$ahead_behind]($style)";
    };

    nodejs = {
      symbol = "";
      style = "bg:black fg:green";
      format = "[ $symbol ($version) ]($style)";
    };

    rust = {
      symbol = "";
      style = "bg:black fg:green";
      format = "[ $symbol ($version) ]($style)";
    };

    golang = {
      symbol = "";
      style = "bg:black fg:green";
      format = "[ $symbol ($version) ]($style)";
    };

    php = {
      symbol = "🐘";
      style = "bg:black fg:green";
      format = "[ $symbol ($version) ]($style)";
    };

    time = {
      disabled = false;
      time_format = "%R";
      style = "bg:black fg:light_grey";
      format = "[  $time ]($style)";
    };

    character = {
      disabled = false;
      success_symbol = "[❯](bold #36a166)";
      error_symbol = "[❯](bold #5b9d48)";
    };
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
    kitty
    peaclock

    # icons and stuff
    adwaita-icon-theme

    # Utilities
    yt-dlp
    unrar
    p7zip
    killall
    qbittorrent
    loupe
    nautilus
    file-roller
    zathura
    yazi
    bat
    wiremix
    fzf
    trash-cli
    glib

    # Audio & music
    easyeffects
    ardour
    neural-amp-modeler-lv2
    zrythm
    rmpc
    mpd

    #Stuff for quickshell wallpapers
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
  ];
}
