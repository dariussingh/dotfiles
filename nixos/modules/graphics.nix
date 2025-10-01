{ config, pkgs, ... }:

{
  # Enable X11 and OpenGL
  services.xserver.enable = true;
  hardware.graphics.enable = true;

  # Display Manager and Desktop Environment (GNOME)
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  
  # Video Drivers
  services.xserver.videoDrivers = [
    "amdgpu" 
    "nvidia"
  ];
  
  # Nvidia Configuration (Hybrid setup)
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      sync.enable = true;
      nvidiaBusId = "PCI:64:0:0";
      amdgpuBusId = "PCI:65:0:0";
    };
  };

  # Wayland Environment Variables
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1"; # Invisible cursor fix
    NIXOS_OZONE_WL = "1";          # Hint electron apps to use wayland
  };
}
