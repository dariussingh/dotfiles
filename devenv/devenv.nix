{ pkgs, ... }:

{
  packages = [ 
    # pkgs.git 
  ];

  languages.python.enable = true;
  languages.python.version = "3.12.0";
  languages.python.venv.enable = true;

  # uv
  languages.python.uv.enable = true;

  # poetry
  languages.python.poetry.enable = false;
}
