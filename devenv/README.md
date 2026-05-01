# devenv

Two environment templates depending on project needs:

- **`python/`** — Python + CUDA (PyTorch, Ultralytics, uv)
- **`python-cpp/`** — Python + C++ + CUDA (above + Conan, CMake, clangd, GStreamer, FFmpeg, OpenCV, OpenVINO, ONNX Runtime)

## Setup
```bash
devenv init
# copy the relevant template into your project dir
cp -r ~/dotfiles/devenv/python-cpp/. .         # or python
direnv allow
```

## CUDA Runtime Libraries
Do not export a global `LD_LIBRARY_PATH` from these templates. On NixOS that can override the runtime linkage of unrelated tools and break binaries such as `nvim` by mixing glibc versions.

When a specific CUDA-linked program needs the extra runtime libraries, run it through the helper script instead:

```bash
run-with-cuda-libs python script_using_cuda.py
run-with-cuda-libs ./build/my_app
run-with-cuda-libs lldb ./build/my_app
```

This scopes `LD_LIBRARY_PATH` to one process instead of the whole shell.

## References
- How to setup devenv: [blog](https://cloudnativeengineer.substack.com/p/effortless-python-development-with-nix)
- Devenv with cuda: [github](https://github.com/clementpoiret/nix-python-devenv/tree/cuda)
- Direnv with vscode: [extension](https://marketplace.visualstudio.com/items?itemName=mkhl.direnv)
