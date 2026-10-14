{ pkgs, ... }:

{
  # Display / session
  services.xserver.enable = true;
  services.xserver.xkb.layout = "us";
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  programs.hyprland.enable = true;
  programs.waybar.enable = true;

  # Hyprland tooling
  environment.systemPackages = with pkgs; [
    hyprpaper
    swaynotificationcenter
    libnotify
    rofi
    grim
    slurp
    wl-clipboard
    brightnessctl
  ];

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-color-emoji
    font-awesome
    nerd-fonts.jetbrains-mono
  ];
}
