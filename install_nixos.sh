rm -rf ~/.config/nvim
rm -rf ~/.config/alacritty
rm -rf ~/.tmux/tmux.conf

sudo nixos-rebuild switch --flake ~/dotfiles/nixos
