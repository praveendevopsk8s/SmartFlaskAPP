#!/bin/bash

set -e  # Exit on any error

echo "### Checking Python and pip dependencies ###"
# Ensure required packages are installed
sudo apt-get update
sudo apt-get install -y python3 python3-venv python3-pip curl

# Set Python version (optional if using system default)
python3 -V

# Create virtual environment
echo "### Creating virtual environment ###"
python3 -m venv myenv

# Bootstrap pip manually if missing
if [ ! -f "myenv/bin/pip" ]; then
  echo "pip not found in virtual environment, installing manually..."
  curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  myenv/bin/python get-pip.py
fi

# Activate virtual environment
echo "### Activating virtual environment ###"
source myenv/bin/activate

# Confirm pip version
pip --version

# Install dependencies
echo "### Installing requirements ###"
pip install -r requirements.txt
pip install pytest-cov

echo "### All installations complete ###"
