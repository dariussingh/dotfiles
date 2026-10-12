{ config, pkgs, lib, llm-agents, ... }:

let
  # Link each skill individually so the runtime skill dirs stay real,
  # writable directories (GSD and other installers refuse to write through
  # a symlinked skills dir).
  skillNames = [
    "full-code-review"
    "github-issue-workflow"
    "github-review-comments"
    "review-assignment"
    "write-article"
  ];
  skillLinks = dir: lib.listToAttrs (map (name: {
    name = "${dir}/${name}";
    value.source = config.lib.file.mkOutOfStoreSymlink "/home/darius/dotfiles/ai/skills/${name}";
  }) skillNames);
in
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
    ollama
    tabby-agent
    anydesk
    postman
    tailscale
    gnome-network-displays
    chromium
  ];

  # Add dotfile symlinks
  home.file = skillLinks ".claude/skills"
    // skillLinks ".config/opencode/skills"
    // skillLinks ".codex/skills"
    // {
      ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink "/home/darius/dotfiles/nvim";
      ".config/alacritty/alacritty.toml".source = config.lib.file.mkOutOfStoreSymlink "/home/darius/dotfiles/alacritty/alacritty.toml";
      ".tmux/tmux.conf".source = config.lib.file.mkOutOfStoreSymlink "/home/darius/dotfiles/tmux/tmux.conf";
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
