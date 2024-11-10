{ config, pkgs, ... }:

{
	services.xserver = {
		enable = true;
		layout = "gb";
		windowManager.i3 = {
			enable = true;
			extraPackages = with pkgs; [
				rofi
				i3status
				i3lock
				feh
			];
		};
	};
}
