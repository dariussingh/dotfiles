{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./gnome.nix
    ./alacritty.nix
    ./tmux.nix
  ];

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Basic User/Home-Manager settings
  home.username = "darius";
  home.homeDirectory = "/home/darius";
  home.stateVersion = "25.05"; 

  # Shell and Git moved here from the old configuration.
  programs.bash.enable = true;

  programs.git = {
    enable = true;
    userName = "dariussingh";
    userEmail = "darius2121.ds@gmail.com";
  };
  
  # Firefox moved to Home Manager as it's a user application
  programs.firefox.enable = true;
}
