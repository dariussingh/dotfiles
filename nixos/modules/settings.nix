{ config, pkgs, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Time and Locale
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true; # Uncomment if needed
  };

  # Printing
  services.printing.enable = true;

  # System Packages (Moved from home.nix to system-wide for access by all users)
  environment.systemPackages = with pkgs; [
    vim
    lshw
    wget
    curl
    unzip
    htop
    tree
    gcc
    gnumake
    xclip
    home-manager # Keep home-manager in system packages
    nodejs_22
    ripgrep 
    fzf
    fd
    neovim
  ];

  fonts.fontDir.enable = true;

  # nix-ld for running foreign binaries
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    glibc
    zlib
    stdenv.cc.cc
    curl
    openssl
  ];
}
