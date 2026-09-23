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
      format = "[░▒▓](ayu_green)[  $username ](bg:ayu_green fg:ayu_bg)[](fg:ayu_green bg:ayu_subtle)[ $directory ](fg:ayu_fg bg:ayu_subtle)[](fg:ayu_subtle bg:ayu_subtle2)[ $git_branch$git_status ](fg:ayu_green bg:ayu_subtle2)[](fg:ayu_subtle2 bg:ayu_base)[ $nodejs$rust$golang$php ](fg:ayu_green bg:ayu_base)[](fg:ayu_base bg:ayu_dark)[ $time ](fg:ayu_fg bg:ayu_dark)[ ](fg:ayu_dark)\n$character";
      palette = "ayu_green";
      palettes.ayu_green = {
        ayu_bg      = "#0f1419"; # Base dark background
        ayu_dark    = "#131721"; # Slightly lighter dark for contrast
        ayu_base    = "#191e2a"; # Dark panel background
        ayu_subtle  = "#212733"; # Subtle section background
        ayu_subtle2 = "#2a3141"; # Secondary subtle background
        ayu_fg      = "#e6e1cf"; # Main text color
        ayu_green   = "#aad94c"; # Primary Ayu Green accent
        ayu_cyan    = "#95e6cb"; # Secondary Cyan/Teal accent
        ayu_orange  = "#ff8f40"; # Warning/Root accent
      };

      username = {
        show_always = true;
        style_user = "bg:ayu_green fg:ayu_bg bold";
        style_root = "bg:ayu_orange fg:ayu_bg bold";
        format = "[$user]($style)";
      };

      directory = {
        style = "fg:ayu_fg bg:ayu_subtle";
        format = "[$path]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      git_branch = {
        symbol = "";
        style = "bg:ayu_subtle2";
        format = "[[ $symbol $branch ](fg:ayu_green bg:ayu_subtle2)]($style)";
      };

      git_status = {
        style = "bg:ayu_subtle2";
        format = "[[($all_status$ahead_behind )](fg:ayu_green bg:ayu_subtle2)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:ayu_base";
        format = "[[ $symbol ($version) ](fg:ayu_green bg:ayu_base)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:ayu_base";
        format = "[[ $symbol ($version) ](fg:ayu_green bg:ayu_base)]($style)";
      };

      golang = {
        symbol = "";
        style = "bg:ayu_base";
        format = "[[ $symbol ($version) ](fg:ayu_green bg:ayu_base)]($style)";
      };

      php = {
        symbol = "🐘";
        style = "bg:ayu_base";
        format = "[[ $symbol ($version) ](fg:ayu_green bg:ayu_base)]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:ayu_dark";
        format = "[[  $time ](fg:ayu_fg bg:ayu_dark)]($style)";
      };

      character = {
        disabled = false;
        success_symbol = "[❯](bold #aad94c)";
        error_symbol = "[❯](bold #ff3333)";
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
    impala
    wiremix
    fzf
    iwd

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
