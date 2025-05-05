#!/bin/bash

# Fail fast if any command fails
set -e

# Install dependencies for pyenv
sudo apt-get update
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev git

# Install pyenv if not already installed
if [ ! -d "$HOME/.pyenv" ]; then
    echo "Installing pyenv..."
    curl https://pyenv.run | bash
else
    echo "pyenv already installed"
fi

# Export pyenv paths
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# Install Python version (if not installed)
PYTHON_VERSION="3.10.12"
if ! pyenv versions --bare | grep -q "$PYTHON_VERSION"; then
    echo "Installing Python $PYTHON_VERSION via pyenv..."
    pyenv install $PYTHON_VERSION
fi

# Set Python version
pyenv global $PYTHON_VERSION

# Show current versions
python3 -V
pip3 -V

# Create and activate virtual environment
python3 -m venv myenv
source myenv/bin/activate

# Install pip if not available
if ! command -v pip &> /dev/null; then
    echo "pip not found, installing pip..."
    python3 -m ensurepip --upgrade
fi

# Install dependencies
echo '#### Installing requirements ####'
pip install --upgrade pip
pip install -r ./requirements.txt
pip install pytest-cov
echo '#### Installing Pytest is done ####'
