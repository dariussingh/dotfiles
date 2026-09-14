{ config, pkgs, ... }:

{
  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };

  # Time and Locale
  time.timeZone = "Asia/Dubai";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
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
    nettools
    psmisc
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
  # Enable OpenSSH
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };

  # Ollama via Docker for Nvidia GPU acceleration (ollama-cuda not in binary cache)
  virtualisation.oci-containers.containers.ollama = {
    image = "ollama/ollama:latest";
    volumes = [ "ollama:/root/.ollama" ];
    ports = [ "11434:11434" ];
    extraOptions = [ "--device" "nvidia.com/gpu=all" ];
    autoStart = true;
  };

  # Open SSH and local service ports in firewall
  networking.firewall = {
    allowedTCPPorts = [
      22
      # Analytic server
      5018 5020 8093 8090
      # Analytic Manager
      5012
      # RabbitMQ
      5672 15672
      # TimescaleDB
      54321
      # PostgreSQL / pgAdmin
      5432 8083
      # Milvus
      19530 9091
      # MinIO
      9000 9001
      # Streaming / player
      8181 4557 8890 8554
      # Discovery / monitor
      8194 8191
      # Seq logs
      5341
      # Anomaly detection VLM server
      8060 8067
      # vlm-client search UI + Qdrant REST/gRPC
      8099 6333 6334
      # Misc existing
      5000 3000 3001 5173 8100 8080 6379 11434 8002 8000
    ];
    trustedInterfaces = [
      "tailscale0"
      "docker0"
      "br+"  # trust all Docker compose bridge networks (i2v_network etc.)
    ];
  };


}
