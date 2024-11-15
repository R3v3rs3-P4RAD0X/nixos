{ config, pkgs, ... }:
{
	imports =
		[
			./hardware-configuration.nix
			./nix-alien.nix
			# ./desktops/hyprland.nix
			./desktops/i3.nix
		];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;

	nixpkgs.config.allowUnfree = true;
	networking.networkmanager.enable = true;

	environment.systemPackages = with pkgs; [
		wget
		neovim
		git
		mangohud
		nix-ld
		patchelf
		glibc
		binutils
		zlib
		libkrb5
		pkgs.home-manager
	];	
	
	services.xserver.videoDrivers = [ "nvidia" ];
	hardware.opengl.enable = true;
	
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

	programs.nix-ld = {
		enable = true;
		libraries = with pkgs; [
			glib
			mesa
			libglvnd
			libxkbcommon
			fontconfig
			xorg.libX11
			freetype
			dbus
			nss
			zlib
			glibc
			binutils
			libkrb5
			libz
		];

	};

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
			python3
			python3Packages.pip
			python3Packages.virtualenv
		];
	};

	security.sudo.enable = true;
	security.sudo.wheelNeedsPassword = false;

	time.timeZone = "Europe/London";

	hardware.pulseaudio.enable = true;
	system.stateVersion = "24.05";
}

