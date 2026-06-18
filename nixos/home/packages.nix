{ config, pkgs, llm-agents, ... }:

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
    devcontainer
    libreoffice
    gnomeExtensions.workspace-indicator
    gnomeExtensions.advanced-alttab-window-switcher
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
    ffmpeg
    zip
    pigz
    remmina
    llm-agents.packages.${pkgs.system}.claude-code
    llm-agents.packages.${pkgs.system}.codex
    llm-agents.packages.${pkgs.system}.opencode
    tabby-agent
    anydesk
    postman
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

  home.file.".claude/skills" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/darius/dotfiles/ai/skills";
    };

  home.file.".config/opencode/skills" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/darius/dotfiles/ai/skills";
    };

  home.file.".codex/skills" = {
      source = config.lib.file.mkOutOfStoreSymlink "/home/darius/dotfiles/ai/skills";
    };

# Enable vscode with specific dependencies for extensions
  programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhsWithPackages (ps: with ps; [
        python3
        python3Packages.autopep8
        python3Packages.isort
        python3Packages.debugpy
        python3Packages.pylance
        rustup
        rust-analyzer
        clang
        cmake
        gcc
        gnumake
        docker
        docker-compose
        devcontainer
        git
        nodejs_22
        live-server
        python3Packages.ipython
        python3Packages.jupyter
        go
        openjdk
    ]);
  };
}
