{ config, pkgs, ... }:

{
	programs.hyprland = {
		enable = true;
		xwayland.enable = true;
	};

	security.polkit.enable = true;
}

