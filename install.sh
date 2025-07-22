#!/bin/bash
set -euo pipefail
trap 'echo "❌ Script failed at line $LINENO."; exit 1' ERR

echo "🔧 Updating and upgrading system packages..."
# sudo apt update && sudo apt upgrade -y

echo "📦 Installing essential development tools..."
sudo apt install -y python3-pip python3-venv tmux git curl software-properties-common unzip alacritty

echo "📦 Installing extra tools for clipboard, search, fuzzy finding..."
sudo apt install -y xclip ripgrep fd-find fzf ruby-full

# ----------------------------
# INSTALL LAZYGIT
# ----------------------------
echo "📦 Installing LazyGit manually from GitHub..."
LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -oP '"tag_name": "\Kv[0-9.]+' )
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION#v}_Linux_x86_64.tar.gz"
tar -xzf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin/
rm lazygit lazygit.tar.gz
echo "✅ LazyGit $(lazygit --version) installed"

# ----------------------------
# INSTALL LATEST NEOVIM (AppImage)
# ----------------------------
echo "🌐 Downloading latest Neovim AppImage..."
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage

echo "📁 Installing Neovim to /opt/nvim..."
sudo mkdir -p /opt/nvim
sudo mv nvim-linux-x86_64.appimage /opt/nvim/nvim

if ! grep -q '/opt/nvim' ~/.bashrc; then
  echo 'export PATH="$PATH:/opt/nvim"' >>~/.bashrc
  echo "✅ Added /opt/nvim to PATH in ~/.bashrc"
else
  echo "ℹ️ /opt/nvim already in PATH"
fi

echo "✅ Neovim installed to /opt/nvim/nvim"

# ----------------------------
# INSTALL NVM + NODE + NPM
# ----------------------------
echo "📦 Installing NVM (Node Version Manager)..."
export NVM_DIR="$HOME/.nvm"
if [ ! -d "$NVM_DIR" ]; then
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
else
  echo "ℹ️ NVM already installed, skipping..."
fi

if ! grep -q 'NVM Configuration' ~/.bashrc; then
  cat <<'EOF' >>~/.bashrc

# NVM Configuration
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
EOF
  echo "✅ NVM setup added to ~/.bashrc"
else
  echo "ℹ️ NVM already configured in ~/.bashrc"
fi

export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"
else
  echo "❌ NVM script not found at $NVM_DIR/nvm.sh"
  exit 1
fi

echo "📥 Installing latest Node.js (LTS) via NVM..."
nvm install --lts || echo "⚠️ Node.js LTS may already be installed."
NODE_LTS_VERSION=$(nvm ls --no-colors | grep -oE 'v[0-9]+\.[0-9]+\.[0-9]+' | head -1)

if [[ -n "$NODE_LTS_VERSION" ]]; then
  nvm use "$NODE_LTS_VERSION"
  nvm alias default "$NODE_LTS_VERSION"
  echo "✅ Node.js: $(node -v), NPM: $(npm -v)"
else
  echo "❌ Failed to detect installed Node.js LTS version."
  exit 1
fi

# ----------------------------
# VIRTUALENV HELPERS
# ----------------------------
echo "🛠️ Adding virtualenv helpers to ~/.bashrc..."
VENV_HELPERS='
# ----------------------------
# VIRTUALENV HELPERS
# ----------------------------
mkvirtualenv() {
  if [ -z "$1" ]; then
    echo "Usage: mkvirtualenv <env_name>"
  else
    python3 -m venv "$HOME/.virtualenvs/$1"
    echo "✅ Virtualenv created at ~/.virtualenvs/$1"
    echo "💡 To activate it, run: workon $1"
  fi
}
workon() {
  if [ -z "$1" ]; then
    echo "Usage: workon <env_name>"
    echo "Available environments:"
    ls "$HOME/.virtualenvs"
  else
    local env_path="$HOME/.virtualenvs/$1"
    if [ -d "$env_path" ]; then
      source "$env_path/bin/activate"
    else
      echo "❌ No virtualenv named '\''$1'\'' found in ~/.virtualenvs/"
    fi
  fi
}
_complete_workon() {
  COMPREPLY=($(compgen -W "$(ls -1 "$HOME/.virtualenvs")" -- "${COMP_WORDS[1]}"))
}
complete -F _complete_workon workon
'

if ! grep -q 'VIRTUALENV HELPERS' ~/.bashrc; then
  echo "$VENV_HELPERS" >>~/.bashrc
  echo "✅ Virtualenv helpers added to ~/.bashrc"
else
  echo "ℹ️ Virtualenv helpers already exist in ~/.bashrc, skipping..."
fi

echo "📁 Creating ~/.virtualenvs directory..."
mkdir -p ~/.virtualenvs

echo "🌱 Creating base virtual environment: ~/.virtualenvs/base..."
python3 -m venv ~/.virtualenvs/base
echo "✅ Base virtualenv created."
echo "💡 To activate it now, run: workon base"

# ----------------------------
# Install Neovim Python + Node support
# ----------------------------
echo "🐍 Installing neovim Python module in base virtualenv..."
~/.virtualenvs/base/bin/pip install -U pip neovim

echo "🟢 Installing neovim Node.js package..."
npm install -g neovim

# ----------------------------
# FORCE INSTALL Lazy.nvim PLUGIN MANAGER
# ----------------------------
echo "📦 Installing Lazy.nvim plugin manager..."
LAZY_PATH="$HOME/.local/share/nvim/lazy/lazy.nvim"
rm -rf "$LAZY_PATH"
git clone https://github.com/folke/lazy.nvim.git "$LAZY_PATH"
echo "✅ Lazy.nvim freshly installed to $LAZY_PATH"

# ----------------------------
# SYMLINK CONFIGS
# ----------------------------
REPO_DIR="$(pwd)"
echo "🔗 Symlinking Neovim config: ~/.config/nvim -> $REPO_DIR/nvim"
mkdir -p ~/.config
ln -sfn "$REPO_DIR/nvim" ~/.config/nvim

echo "🔗 Symlinking Alacritty config: ~/.config/alacritty-> $REPO_DIR/alacritty"
ln -sfn "$REPO_DIR/alacritty" ~/.config/alacritty

echo "🔗 Symlinking tmux config: ~/.tmux -> $REPO_DIR/tmux"
mkdir -p ~/.tmux
ln -sfn "$REPO_DIR/tmux/tmux.conf" ~/.tmux/tmux.conf

echo 'source-file ~/.tmux/tmux.conf' > ~/.tmux.conf
echo "~/.tmux.conf has been replaced to source ~/.tmux/tmux.conf"

# ----------------------------
# INSTALL TPM (Tmux Plugin Manager)
# ----------------------------
echo "🔌 Installing TPM (Tmux Plugin Manager)..."
if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo "ℹ️ TPM already exists, skipping..."
fi

# ----------------------------
# INSTALL TMUX PLUGINS
# ----------------------------
echo "📜 Installing tmux plugins using TPM..."
tmux new-session -d -s plugin-install-session "sleep 1; tmux source-file ~/.tmux.conf; ~/.tmux/plugins/tpm/bin/install_plugins; sleep 2"
sleep 4
tmux kill-session -t plugin-install-session 2>/dev/null || true
echo "✅ tmux plugins installed!"

# ----------------------------
# FINAL MESSAGE
# ----------------------------
echo "🔄 Please run 'source ~/.bashrc' or restart your terminal to activate all changes."
echo "🎉 Full development environment setup is complete!"

