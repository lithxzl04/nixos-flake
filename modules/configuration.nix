{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/desktop.nix
    ./modules/gaming.nix
    ./modules/memory.nix
  ];

  # Boot
  boot = {
    loader.grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  # Networking
  networking = {
    hostName = "3301-nix";
    networkmanager.enable = true;
  };

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Locale
  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  # User
  users.users.lith = {
    isNormalUser = true;
    description = "lith";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      kdePackages.kate
      discord-ptb
    ];
  };

  # Shell
  programs.zsh = {
    enable = true;
    enableGlobalCompInit = false; # let Zim run compinit instead
  };

  # Packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    fastfetch
    btop
    librewolf
    kitty
    nodejs
  ];

  # Services
  services.openssh.enable = true;
  services.flatpak.enable = true;

  # Do not change after install; see `man configuration.nix`.
  system.stateVersion = "26.05";
}
