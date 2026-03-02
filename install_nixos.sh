rm -rf ~/.config/nvim
rm -rf ~/.config/alacritty
rm -rf ~/.tmux/tmux.conf
rm -rf ~/.claude/skills
rm -rf ~/.config/opencode/skills

sudo nixos-rebuild switch --flake ~/dotfiles/nixos
