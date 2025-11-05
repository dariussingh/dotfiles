{ config, pkgs, ... }:

{
  users.users.darius = {
    isNormalUser = true;
    description = "darius";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  nix.settings.trusted-users = [ "root" "darius" ];
}
