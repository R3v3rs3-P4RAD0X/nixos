# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nix-alien.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;  

  # Allow Unfree Software
  nixpkgs.config.allowUnfree = true;

  # Networking
  networking.networkmanager.enable = true;
  
  # Setup NVIDIA
  hardware.opengl.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    package = pkgs.linuxPackages.nvidiaPackages.stable;
  };

  # Wayland and Hyprland
  services.xserver = {
    enable = true;
  };
	
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager.defaultSession = "plasma";

  # Nix_LD
  programs.nix-ld.enable = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    wget
    neovim
    git
  ];

  # Custom Program Options
  programs.steam = {
  	enable = true;
	remotePlay.openFirewall = true;
	dedicatedServer.openFirewall = true;
	localNetworkGameTransfers.openFirewall = true;
  };

  users.users.p4rad0x = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
    packages = with pkgs; [
      pkgs.brave
      pkgs.discord
      pkgs.fish
      pkgs.spotify
      pkgs.kitty
      vscode
    ];
  };

  security.sudo.enable = true;
  security.sudo.wheelNeedsPassword = false;
  
  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Configure keymap in X11
  services.xserver.xkb.layout = "gb";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  hardware.pulseaudio.enable = false;
  # OR
  services.pipewire = {
     enable = true;
     pulse.enable = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
  # ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };


  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?
}

