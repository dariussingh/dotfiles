{ config, pkgs, ... }:

{
  users.users.darius = {
    isNormalUser = true;
    description = "darius";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nix.settings.trusted-users = [ "root" "darius" ];
}
