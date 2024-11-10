{ config, pkgs, ... }:
{
  imports =
    [
      ./hardware-configuration.nix
      ./nix-alien.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;

  networking.networkmanager.enable = true;

  services.xserver.videoDrivers = ["nvidia"];
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  hardware.nvidia.modesetting.enable = true;

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";

  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
    mangohud
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession = {
      enable = true;
    };
  };

  programs.gamemode.enable = true;

  users.users.p4rad0x = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
    packages = with pkgs; [
      pkgs.brave
      pkgs.discord
      pkgs.vesktop
      pkgs.fish
      pkgs.spotify
      pkgs.kitty
      vscode
      xdg-desktop-portal-kde
      xdg-desktop-portal-gtk
    ];
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;

  time.timeZone = "Europe/Amsterdam";

  services.xserver.xkb.layout = "gb";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  system.stateVersion = "24.05";
}

