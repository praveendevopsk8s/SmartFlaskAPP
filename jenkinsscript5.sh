#!/bin/bash

# Load pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

# Set Python version
pyenv global 3.10.12

# Show current versions
pyenv versions
python3 -V

# Check if pip is installed, if not, install it
if ! command -v pip &> /dev/null; then
    echo "pip not found, installing pip..."
    python3 -m ensurepip --upgrade
    # Alternatively, use get-pip.py if the above doesn't work
    # curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    # python3 get-pip.py
fi

# Create and activate virtual environment
python3 -m venv myenv
source myenv/bin/activate

# Install dependencies
echo '#### Installing requirements ####'
pip install --upgrade pip  # Ensure the latest version of pip is installed
pip install -r ./requirements.txt
pip install pytest-cov
echo '#### Installing Pytest is done ####'
