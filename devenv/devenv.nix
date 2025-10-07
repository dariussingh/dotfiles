{ pkgs, ... }:

{
  packages = [
    pkgs.cudaPackages.cudatoolkit
    pkgs.cudaPackages.cudnn
    pkgs.python312Packages.torch
  ];

  languages.python.enable = true;
  languages.python.version = "3.12.0";
  languages.python.venv.enable = true;

  # uv
  languages.python.uv.enable = true;

  # poetry
  languages.python.poetry.enable = false;
}
