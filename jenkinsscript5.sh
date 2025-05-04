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

# Create and activate virtual environment
python3 -m venv myenv
source myenv/bin/activate

# Install dependencies
echo '#### Installing requirements ####'
pip install -r ./requirements.txt
pip install pytest-cov

# Run tests
echo '#### Running tests ####'
export PYTHONPATH=$PYTHONPATH:$(pwd)
pytest --cov=main utests --junitxml=./xmlReport/output.xml
python -m coverage xml

# Deactivate and reset pyenv
echo '### Deactivating virtual environment ###'
deactivate
pyenv global system
