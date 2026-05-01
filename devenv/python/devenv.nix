{
  pkgs,
  lib,
  ...
}:
let
  buildInputs = with pkgs; [
    cudaPackages.cuda_cudart
    cudaPackages.cudatoolkit
    cudaPackages.cudnn
    stdenv.cc.cc
    libuv
    zlib
    libGL
    glib
  ];
in
{
  packages = with pkgs; [
    cudaPackages.cuda_nvcc
  ];

  env = {
    XLA_FLAGS = "--xla_gpu_cuda_data_dir=${pkgs.cudaPackages.cudatoolkit}"; # For tensorflow with GPU support
    CUDA_PATH = pkgs.cudaPackages.cudatoolkit;
  };

  languages.python = {
    enable = true;
    version = "3.12.0";
    uv = {
      enable = true;
      sync.enable = true;
    };
  };


  scripts.run-with-cuda-libs.exec = ''
    export LD_LIBRARY_PATH="${lib.makeLibraryPath buildInputs}:/run/opengl-driver/lib:/run/opengl-driver-32/lib"
    exec "$@"
  '';

  scripts.devenv_startup.exec = "run-with-cuda-libs uv run python devenv_startup.py";

  enterShell = ''
    . .devenv/state/venv/bin/activate
    nvcc -V
    devenv_startup
  '';
}

