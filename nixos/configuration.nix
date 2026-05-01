{ config, pkgs, home-manager, llm-agents, ... }:

{
  imports = [
    # Hardware is always a direct import
    ./hardware-configuration.nix

    # System Modules
    ./modules/settings.nix
    ./modules/graphics.nix
    ./modules/users.nix
    
    # Home Manager integration
    home-manager.nixosModules.home-manager
    {
      home-manager.useUserPackages = true;
      home-manager.backupFileExtension = "bak";
    
      home-manager.extraSpecialArgs = {
        inherit llm-agents;
      };

      # Point to the user's home-manager entry file
      home-manager.users.darius = import ./home/home.nix;
    }
  ];
  
  # Allow unfree packages globally
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
	
  # Docker
  virtualisation.docker.enable = true;
  hardware.nvidia-container-toolkit.enable = true;
  virtualisation.docker.daemon.settings.features.cdi = true;

  # TeamViewer needs a system-level daemon; installing only the user package
  # does not create teamviewerd.service.
  services.teamviewer.enable = true;

  # Set the system state version
  system.stateVersion = "25.05";
}
