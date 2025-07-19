#!/bin/bash

set -e

echo "🔧 Updating and upgrading system packages..."
# sudo apt update && sudo apt upgrade -y

echo "📦 Installing essential development tools..."
sudo apt install -y python3-pip python3-venv tmux git curl software-properties-common unzip

echo "📦 Installing extra tools for clipboard, search, fuzzy finding..."
sudo apt install -y xclip ripgrep fd-find fzf ruby-full

# ----------------------------
# INSTALL LAZYGIT MANUALLY (No PPA)
# ----------------------------
echo "📦 Installing LazyGit manually from GitHub..."
LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
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

if ! grep -q 'export PATH="$PATH:/opt/nvim"' ~/.bashrc; then
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

if ! grep -q 'export NVM_DIR' ~/.bashrc; then
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

# Temporarily load NVM for this script
export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

echo "📥 Installing latest Node.js (LTS) via NVM..."
nvm install --lts
nvm use --lts
nvm alias default 'lts/*'
echo "✅ Node.js: $(node -v), NPM: $(npm -v)"

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
# SYMLINK CONFIGS
# ----------------------------
REPO_DIR="$(pwd)"

echo "🔗 Symlinking Neovim config: ~/.config/nvim -> $REPO_DIR/nvim"
mkdir -p ~/.config
ln -sfn "$REPO_DIR/nvim" ~/.config/nvim

echo "🔗 Symlinking tmux config: ~/.tmux -> $REPO_DIR/tmux"
mkdir -p ~/.tmux
ln -s "$REPO_DIR/tmux" ~/.tmux

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
tmux start-server
tmux new-session -d
~/.tmux/plugins/tpm/bin/install_plugins
tmux kill-server
echo "✅ tmux plugins installed!"

# ----------------------------
# FINAL: Reload ~/.bashrc
# ----------------------------
echo "🔄 Sourcing ~/.bashrc to activate changes..."
source ~/.bashrc

echo "🎉 Full development environment setup is complete!"
