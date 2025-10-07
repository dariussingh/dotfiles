# devenv

## Setup
```bash
# in project dir
devenv init
# replace devenv.nix with current file
# replace devenv.yaml with repo file
direnv allow # devenv shell -- --print-build-logs --verbose
uv sync
# pip install -r requirements.txt
# poetry install 

```

## References
  - How to setup devenv: [blog](https://cloudnativeengineer.substack.com/p/effortless-python-development-with-nix)

