{ config, pkgs, ... }:

{
  imports = [
    ./packages.nix
    ./gnome.nix
  ];

  fonts.fontconfig.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Basic User/Home-Manager settings
  home.username = "darius";
  home.homeDirectory = "/home/darius";
  home.stateVersion = "25.05"; 

  # Shell and Git moved here from the old configuration.
  programs.bash.enable = true;
  programs.bash.initExtra = ''
    # Detect display server type
    if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
        echo -e "\e[32mYou are running: Wayland\e[0m"
    elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
        echo -e "\e[31mYou are running: X11 (Xorg)\e[0m"
    else
        echo -e "\e[33mDisplay server: Unknown ($XDG_SESSION_TYPE)\e[0m"
    fi

    # Aliases
    alias sync-obsidian="cd ~/Development/Obsidian && ./sync_obsidian.sh"
    alias mount-s24="cd ~/Development && sshfs i2v@192.168.2.24:/media/8tb_drive s24_8tb_drive"
    alias mount-s21="cd ~/Development && sshfs i2v@192.168.2.21:/media/i2v-admin/2tb_drive ./s21_2tb_drive/"
    alias mount-datacrunch="cd ~/Development && sshfs root@192.168.2.21:/media ./datacrunch_drive"
  '';

  # direnv
  programs.direnv = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "dariussingh";
    userEmail = "darius2121.ds@gmail.com";
  };
  
  # Firefox moved to Home Manager as it's a user application
  programs.firefox.enable = true;
}
