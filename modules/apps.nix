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
    # Pill format styled with custom Estuary palette
    format = "[░▒▓](estuary_seafoam)[  $username ](bg:estuary_seafoam fg:estuary_bg)[](fg:estuary_seafoam bg:estuary_subtle)[ $directory ](fg:estuary_green bg:estuary_subtle)[](fg:estuary_subtle bg:estuary_subtle2)[ $git_branch$git_status ](fg:estuary_blue bg:estuary_subtle2)[](fg:estuary_subtle2 bg:estuary_base)[ $nodejs$rust$golang$php ](fg:estuary_seafoam bg:estuary_base)[](fg:estuary_base bg:estuary_dark)[ $time ](fg:estuary_fg bg:estuary_dark)[ ](fg:estuary_dark)\n$character";

    palette = "atelier_estuary";

    # Palette with explicit user hex overrides
    palettes.atelier_estuary = {
      estuary_bg      = "#22221b"; # black
      estuary_dark    = "#2a2a22"; # Container / edge shade
      estuary_base    = "#302f27"; # Base section background
      estuary_subtle  = "#5f5e4e"; # Muted section background
      estuary_subtle2 = "#6c6b5a"; # Secondary muted background
      estuary_fg      = "#929181"; # light grey
      estuary_green   = "#5b9d48"; # green
      estuary_seafoam = "#36a166"; # seafoam
      estuary_blue    = "#5f9182"; # blue
      estuary_orange  = "#ba6236"; # Warning/Root accent
    };

    # Username module configuration
    username = {
      show_always = true;
      style_user = "bg:estuary_seafoam fg:estuary_bg bold";
      style_root = "bg:estuary_orange fg:estuary_bg bold";
      format = "[$user]($style)";
    };

    directory = {
      style = "fg:estuary_green bg:estuary_subtle";
      format = "[$path]($style)";
      truncation_length = 3;
      truncation_symbol = "…/";
    };

    git_branch = {
      symbol = "";
      style = "bg:estuary_subtle2";
      format = "[[ $symbol $branch ](fg:estuary_blue bg:estuary_subtle2)]($style)";
    };

    git_status = {
      style = "bg:estuary_subtle2";
      format = "[[($all_status$ahead_behind )](fg:estuary_seafoam bg:estuary_subtle2)]($style)";
    };

    nodejs = {
      symbol = "";
      style = "bg:estuary_base";
      format = "[[ $symbol ($version) ](fg:estuary_seafoam bg:estuary_base)]($style)";
    };

    rust = {
      symbol = "";
      style = "bg:estuary_base";
      format = "[[ $symbol ($version) ](fg:estuary_seafoam bg:estuary_base)]($style)";
    };

    golang = {
      symbol = "";
      style = "bg:estuary_base";
      format = "[[ $symbol ($version) ](fg:estuary_seafoam bg:estuary_base)]($style)";
    };

    php = {
      symbol = "🐘";
      style = "bg:estuary_base";
      format = "[[ $symbol ($version) ](fg:estuary_seafoam bg:estuary_base)]($style)";
    };

    time = {
      disabled = false;
      time_format = "%R";
      style = "bg:estuary_dark";
      format = "[[  $time ](fg:estuary_fg bg:estuary_dark)]($style)";
    };

    character = {
      disabled = false;
      success_symbol = "[❯](bold #36a166)";
      error_symbol = "[❯](bold #ba6236)";
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
