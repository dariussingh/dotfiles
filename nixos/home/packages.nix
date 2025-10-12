{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    brave
    discord
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
    rclone
    sshfs
    poppler-utils
    ripgrep
    chafa
    imagemagick
    ffmpegthumbnailer
    epub-thumbnailer
    fontpreview
    ffmpegthumbnailer
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

  # Add vscode
  programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
}

