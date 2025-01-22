#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display usage information
usage() {
    echo "Usage: $0 [-r requirements_file] [-n env_name]"
    echo "  -r requirements_file : Path to the requirements.txt file containing packages and versions"
    echo "  -n env_name          : Name of the virtual environment (default: venv)"
}

# Default values
ENV_NAME="venv"
REQUIREMENTS_FILE="requirements.txt"

# Parse command-line arguments
while getopts "r:n:" opt; do
    case "$opt" in
        r) REQUIREMENTS_FILE=$OPTARG ;;
        n) ENV_NAME=$OPTARG ;;
        *) usage ;;
    esac
done

# Check if requirements file is provided
if [ -z "$REQUIREMENTS_FILE" ]; then
    echo "Error: Requirements file not specified."
    usage
fi

# Check if the requirements file exists
if [ ! -f "$REQUIREMENTS_FILE" ]; then
    echo "Error: Requirements file '$REQUIREMENTS_FILE' not found."
    exit 1
fi

# Create virtual environment
echo "Creating virtual environment '$ENV_NAME'..."
python3 -m venv "$ENV_NAME"

# Activate the virtual environment
echo "Activating virtual environment..."
source "$ENV_NAME/bin/activate"

# Upgrade pip
echo "Upgrading pip..."
pip install --upgrade pip

# Install packages from requirements file
echo "Installing packages from '$REQUIREMENTS_FILE'..."
pip install -r "$REQUIREMENTS_FILE"

echo "All packages installed successfully. You are currently in virtual environment '$ENV_NAME' and it is ready to use, enjoy!"

# Deactivate the virtual environment
# deactivate
