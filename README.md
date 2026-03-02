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
- Update Packages
  ```bash
  cd ~/dotfiles/nixos
  # Update all flake inputs (nixpkgs, home-manager, etc.)
  sudo nix flake update
  # Rebuild system with updated packages
  sudo nixos-rebuild switch --flake .#nixos

  # Or combine both steps
  sudo nix flake update && sudo nixos-rebuild switch --flake .#nixos

  # Update specific inputs only
  sudo nix flake update nixpkgs
  sudo nix flake update home-manager
  ```

- Garbage Collection
  ```bash
  # Delete all generations older than 7 days
  sudo nix-collect-garbage --delete-older-than 7d

  # Or delete all old generations except current
  sudo nix-collect-garbage -d

  # Delete old user profile generations
  nix-collect-garbage -d

  # Optimize the Nix store (deduplicate files)
  sudo nix-store --optimise

  # Clean up boot entries after garbage collection
  sudo nixos-rebuild boot
  ```

- Maintenance Routine
  ```bash
  # Weekly: Update and rebuild
  cd ~/dotfiles/nixos
  sudo nix flake update && sudo nixos-rebuild switch --flake .#nixos

  # Monthly: Garbage collect
  sudo nix-collect-garbage --delete-older-than 30d
  sudo nix-store --optimise
  ```

- References
  - Setup nvidia and nixos: [Guide](https://nixos.wiki/wiki/Nvidia)
  - How to setup LazyVim with Nixos: [Recipe](https://github.com/LazyVim/LazyVim/discussions/1972)
  - Setup VScode with Nixos: [Guide](https://nixos.wiki/wiki/Visual_Studio_Code)


