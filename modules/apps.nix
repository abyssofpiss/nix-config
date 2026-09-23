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
      format = "[ ](tokyo_blue)[ $username ](bg:tokyo_blue fg:tokyo_black)[](fg:tokyo_blue bg:tokyo_subtle)[ $directory ](fg:tokyo_black bg:tokyo_subtle)[](fg:tokyo_subtle bg:tokyo_subtle2)[ $git_branch$git_status ](fg:tokyo_blue bg:tokyo_subtle2)[](fg:tokyo_subtle2 bg:tokyo_base)[ $nodejs$rust$golang$php ](fg:tokyo_blue bg:tokyo_base)[](fg:tokyo_base bg:tokyo_dark)[ $time ](fg:tokyo_subtle bg:tokyo_dark)[ ](fg:tokyo_dark)\n$character";
      palette = "tokyo_night";
      palettes.tokyo_night = {
        tokyo_black = "#22221b";
        tokyo_blue = "#36a166";
        tokyo_white = "#929181";
        tokyo_subtle = "#5b9d48";
        tokyo_subtle2 = "#5f9182";
        tokyo_base = "#a5980d";
        tokyo_dark = "#7d9726";
      };

      directory = {
        style = "fg:tokyo_white bg:tokyo_subtle";
        format = "[$path]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };
     
      git_branch = {
        symbol = "";
        style = "bg:tokyo_subtle2";
        format = "[[ $symbol $branch ](fg:tokyo_blue bg:tokyo_subtle2)]($style)";
      };

      git_status = {
        style = "bg:tokyo_subtle2";
        format = "[[($all_status$ahead_behind )](fg:tokyo_blue bg:tokyo_subtle2)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:tokyo_base";
        format = "[[ $symbol ($version) ](fg:tokyo_blue bg:tokyo_base)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:tokyo_base";
        format = "[[ $symbol ($version) ](fg:tokyo_blue bg:tokyo_base)]($style)";
      };

      golang = {
        symbol = "";
        style = "bg:tokyo_base";
        format = "[[ $symbol ($version) ](fg:tokyo_blue bg:tokyo_base)]($style)";
      };

      php = {
        symbol = "🐘";
        style = "bg:tokyo_base";
        format = "[[ $symbol ($version) ](fg:tokyo_blue bg:tokyo_base)]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R"; # Hour:Minute Format
        style = "bg:tokyo_dark";
        format = "[[  $time ](fg:tokyo_white bg:tokyo_dark)]($style)";
      };

      character = {
        disabled = false;
        success_symbol = "[❯](bold green)";
        error_symbol = "[❯](bold red)";
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
