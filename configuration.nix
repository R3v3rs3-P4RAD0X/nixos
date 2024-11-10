{ config, pkgs, ... }:
{
	imports =
		[
			./hardware-configuration.nix
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

	programs.nix-ld = {
		enable = true;
		libraries = with pkgs; [
			glib
			mesa
			libglvnd
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
		];
	};

	security.sudo.enable = true;
	security.sudo.wheelNeedsPassword = false;

	time.timeZone = "Europe/London";

	hardware.pulseaudio.enable = true;
	system.stateVersion = "24.05";
}

