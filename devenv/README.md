# devenv

Two environment templates depending on project needs:

- **`python/`** — Python + CUDA (PyTorch, Ultralytics, uv)
- **`python-cpp/`** — Python + C++ + CUDA (above + Conan, CMake, clangd, GStreamer, FFmpeg, OpenCV, OpenVINO, ONNX Runtime)

## Setup
```bash
# copy the relevant template into your project dir
cp -r ~/dotfiles/devenv/python/. .         # or python-cpp
direnv allow
```

## References
- How to setup devenv: [blog](https://cloudnativeengineer.substack.com/p/effortless-python-development-with-nix)
- Devenv with cuda: [github](https://github.com/clementpoiret/nix-python-devenv/tree/cuda)
- Direnv with vscode: [extension](https://marketplace.visualstudio.com/items?itemName=mkhl.direnv)
