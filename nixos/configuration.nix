{ config, pkgs, home-manager, ... }:

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
      # Point to the user's home-manager entry file
      home-manager.users.darius = import ./home/home.nix;
    }
  ];
  
  # Allow unfree packages globally
  nixpkgs.config.allowUnfree = true;

  # Enable Flakes and nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # Set the system state version
  system.stateVersion = "25.05";
}
