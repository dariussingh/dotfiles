{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    brave
    discord
    vscode
    python3
    python3Packages.pip
    ruby
    tmux       # Keep tmux for configuration, but it's also in systemPackages
    git        # Keep git for configuration, but it's also in systemPackages
    gh
    lazygit
    vlc
    libreoffice
    gnomeExtensions.workspace-indicator
    nerd-fonts.jetbrains-mono
  ];
}

