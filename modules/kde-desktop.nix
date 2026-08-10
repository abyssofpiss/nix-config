# kde-desktop.nix
{ pkgs, ... }: {
  # Enable the full KDE Plasma 6 Desktop Environment
  services.desktopManager.plasma6.enable = true;
  
  # KDE-specific apps 
  environment.systemPackages = with pkgs; [
    kdePackages.kate  # Text editor
    kdePackages.dolphin #File manager
    kdePackages.elisa # Music player
  ];
}
