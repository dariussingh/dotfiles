# Config files

## Setup 

### Ubuntu

```bash
sudo chmod +x ./install_ubuntu.sh
sudo ./install_ubuntu.sh
sudo source ~/.bashrc
sudo tmux source ~/.tmux/tmux.conf
pip install neovim debugpy # inside venv, needed for debug
```

### NixOS


- Setup:
  ```bash
  rm -rf ~/.config/alacritty/
  rm -rf ~/.config/nvim
  rm -rf ~/.tmux/tmux.conf
  cd dotfiles/nixos
  sudo nixos-rebuild  switch --flake .
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  tmux
  # Press Prefix (Ctrl+b), then type:
  :source-file ~/.tmux/tmux.conf
  sudo tmux source ~/.tmux/tmux.conf
  # if markdown-preview does not work
  cd ~/.local/share/nvim/lazy/markdown-preview.nvim/app && ./install.sh
  ```
- Garbage Collection of generations
  ```bash
    # Keep the last 4 generations for the current user
    nix-env --delete-generations 4
    # Delete system generations
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations 4
    # Garbage collect everything unreferenced
    sudo nix-collect-garbage -d
  ```

- References
  - Setup nvidia and nixos: [Guide](https://nixos.wiki/wiki/Nvidia)
  - How to setup LazyVim with Nixos: [Recipe](https://github.com/LazyVim/LazyVim/discussions/1972)
  - Setup VScode with Nixos: [Guide](https://nixos.wiki/wiki/Visual_Studio_Code)


