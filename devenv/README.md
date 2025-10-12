# devenv

## Setup
```bash
# in project dir
devenv init
# replace devenv.nix, devenv.yaml and devenv_startup.py in project dir
direnv allow # devenv shell -- --print-build-logs --verbose
uv sync
```

## References
- How to setup devenv: [blog](https://cloudnativeengineer.substack.com/p/effortless-python-development-with-nix)
- Devenv with cuda: [github](https://github.com/clementpoiret/nix-python-devenv/tree/cuda)
- Direnv with vscode: [extension](https://marketplace.visualstudio.com/items?itemName=mkhl.direnv)

