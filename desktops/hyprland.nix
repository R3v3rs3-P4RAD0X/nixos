{ config, pkgs, ... }:

{
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};
	
	services.xserver = {
		displayManager = {
			sddm.enable = true;
		};
	};
	services.displayManager.sddm.wayland.enable = true;

	security.polkit.enable = true;
}

