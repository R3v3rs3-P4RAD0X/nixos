{ config, pkgs, ... }:
{
	services.xserver = {
		enable = true;
		displayManager.sddm.enable = true;
		desktopManager = {
			xterm.enable = false;
		};
	};

	environment.systemPackages = with pkgs; [
		hyprland
			waybar
			alacritty
			rofi
			dunst
	];
}

