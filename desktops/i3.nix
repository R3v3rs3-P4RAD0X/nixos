{ config, pkgs, lib, ... }:

{
	services.xserver = {
		enable = true;
		xkb.layout = "gb";
		windowManager.i3 = {
			enable = true;
			extraPackages = with pkgs; [
				rofi
				i3
				i3status
				i3lock
				i3-gaps
				feh
				variety
				pkgs.gnome.nautilus
				polybar
			];
		};
		videoDrivers = [ "nvidia" ];
	};

	hardware.opengl.enable = true;

	services.displayManager.sddm = {
		enable = true;
	};
}
