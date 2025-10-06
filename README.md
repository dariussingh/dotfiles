# nvim tmux dotfiles

## Setup 

### Ubuntu

```bash
sudo chmod +x ./install.sh
sudo ./install.sh
sudo source ~/.bashrc
sudo tmux source ~/.tmux/tmux.conf
pip install neovim debugpy # inside venv, needed for debug
```

### NixOS

- Setup nvidia and nixos: [Guide](https://nixos.wiki/wiki/Nvidia)
- How to setup LazyVim with Nixos: [Recipe](https://github.com/LazyVim/LazyVim/discussions/1972)
- nvim dotfiles are shared for ubuntu and nixos but tmux and alacritty dotfiles for nixos are in nix.
- rm -rf ~/.config/alacritty/
- rm -rf ~/.config/nvim
- rm -rf ~/.tmux/tmux.conf
- cd dotfiles/nixos
- sudo nixos-rebuild  switch --flake .

