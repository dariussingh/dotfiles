{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    brave
    discord
    vscode
    python3
    python3Packages.pip
    ruby
    tmux
    git
    alacritty
    gh
    lazygit
    vlc
    libreoffice
    gnomeExtensions.workspace-indicator
    nerd-fonts.jetbrains-mono
  ];

  # Add dotfile symlinks
  home.file.".config/nvim" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/darius/dotfiles/nvim";
    };

  home.file.".config/alacritty/alacritty.toml" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/darius/dotfiles/alacritty/alacritty.toml";
    };


  home.file.".tmux/tmux.conf" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/darius/dotfiles/tmux/tmux.conf";
    };

}

