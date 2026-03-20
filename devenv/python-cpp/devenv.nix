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
    cudaPackages.tensorrt
    # C++ toolchain
    cmake
    ninja
    gdb
    lldb
    bear
    conan
    # system libs for conan */system packages
    libva
    libvdpau
    xkeyboard_config
    # top-level xorg aliases
    libx11
    libxext
    libxrender
    libxi
    libxfixes
    libxtst
    libxcb
    libfontenc
    libxrandr
    libxinerama
    libxcursor
    libxft
    libxxf86vm
    xcb-util-cursor
    util-linux
    # xorg.* packages (not yet top-level aliased)
    xorg.libICE
    xorg.libSM
    xorg.libXau
    xorg.libXaw
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXdmcp
    xorg.libxkbfile
    xorg.libXmu
    xorg.libXpm
    xorg.libXres
    xorg.libXScrnSaver
    xorg.libXt
    xorg.libXv
    xorg.xcbutil
    xorg.xcbutilimage
    xorg.xcbutilkeysyms
    xorg.xcbutilrenderutil
    xorg.xcbutilwm
  ];

  env = {
    LD_LIBRARY_PATH = "${lib.makeLibraryPath buildInputs}:/run/opengl-driver/lib:/run/opengl-driver-32/lib";
    XLA_FLAGS = "--xla_gpu_cuda_data_dir=${pkgs.cudaPackages.cudatoolkit}"; # For tensorflow with GPU support
    CUDA_PATH = pkgs.cudaPackages.cudatoolkit;
  };

  languages.cplusplus = {
    enable = true;
    lsp = {
      enable = true;
      package = pkgs.clang-tools;
    };
  };

  languages.python = {
    enable = true;
    version = "3.12.0";
    uv = {
      enable = true;
      sync.enable = true;
    };
  };

  scripts.devenv_startup.exec = "uv run python devenv_startup.py";

  enterShell = ''
    . .devenv/state/venv/bin/activate
    nvcc -V
    cmake --version | head -1
    mkdir -p ~/.conan2/extensions/hooks
    cat > ~/.conan2/extensions/hooks/hook_nixos_compat.py << 'CONAN_HOOK'
import os
import subprocess

def pre_build(conanfile):
    source_folder = getattr(conanfile, 'source_folder', None)
    if not source_folder or not os.path.exists(source_folder):
        return
    for root, dirs, files in os.walk(source_folder):
        dirs[:] = [d for d in dirs if d != '.git']
        for f in files:
            path = os.path.join(root, f)
            try:
                with open(path, 'rb') as fp:
                    header = fp.read(14)
                if header.startswith(b'#!/bin/bash'):
                    subprocess.run(
                        ['sed', '-i', '1s|#!/bin/bash|#!/usr/bin/env bash|', path],
                        check=False
                    )
            except (IOError, OSError):
                pass
CONAN_HOOK
    [ -f conanfile.txt ] && { conan profile detect --exist-ok; conan install . --build=missing --output-folder=build; }
    devenv_startup
  '';
}

