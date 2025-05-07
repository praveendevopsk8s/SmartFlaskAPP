#!/bin/bash

set -e  # Exit on any error

echo "### Updating and installing system dependencies ###"
su apt-get update
su apt-get install -y python3 python3-venv python3-pip curl

echo "### Python version check ###"
python3 -V

echo "### Creating virtual environment ###"
python3 -m venv myenv

# Bootstrap pip manually if missing
if [ ! -f "myenv/bin/pip" ]; then
  echo "pip not found in virtual environment, installing manually..."
  curl -sS https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  myenv/bin/python get-pip.py
fi

echo "### Installing Python dependencies inside virtualenv ###"
myenv/bin/pip install --upgrade pip
myenv/bin/pip install -r requirements.txt
myenv/bin/pip install pytest-cov

echo "### All installations complete. You can now run your tests using: ###"
echo "myenv/bin/python -m pytest --cov=your_package tests/"
