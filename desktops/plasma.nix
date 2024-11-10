{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };

  services.desktopManager.plasma6 = {
    enable = true;
  };

  services.displayManager.defaultSession = "plasma";

  fonts.fonts = with pkgs; [
    pkgs.google-fonts
    pkgs.nerdfonts
  ];
}
