#!/bin/bash

# This script will install folders for a pentest and grab some commonn tools for testing
# Define directories to be created
DIRECTORIES=(
  "osint"
  "scanning"
  "exploitation"
  "creds"
  "wordlists"
)

# Tools to be installed
TOOLS=(
  "nmap"
  "gobuster"
  "wfuzz"
  "dirb"
  "nikto"
  "hashcat"
  "metasploit-framework"
  "john"
  "hydra"
  "sqlmap"
  "aircrack-ng"
  "wifite"
  "enum4linux"
  "impacket-scripts"
  "bloodhound.py"
  "netcat"
  "responder"
  "mimikatz"
  "netexec"
)

# Function to create directories
create_directories() {
  echo "Creating directories..."
  for dir in "${DIRECTORIES[@]}"; do
    if [ ! -d "$dir" ]; then
      mkdir -p "$dir"
      if [ $? -eq 0 ]; then
        echo "Created: $dir"
      else
        echo "Failed to create: $dir"
      fi
    else
      echo "Directory $dir already exists."
    fi
  done
}

# Function to install tools
install_tools() {
  echo "Updating package list..."
  sudo apt-get update -y
  if [ $? -ne 0 ]; then
    echo "Failed to update package list. Check your network connection or sources."
    exit 1
  fi
  
  echo "Installing tools..."
  for tool in "${TOOLS[@]}"; do
    sudo apt-get install -y "$tool"
    if [ $? -ne 0 ]; then
      echo "Failed to install: $tool. Please check the package name or your internet connection."
    fi
  done
}

# Function to download wordlists
download_wordlists() {
  echo "Downloading wordlists..."
  if [ ! -d "wordlists/SecLists" ]; then
    git clone https://github.com/danielmiessler/SecLists.git wordlists/SecLists
    if [ $? -eq 0 ]; then
      echo "SecLists downloaded successfully."
    else
      echo "Failed to download SecLists. Please check your internet connection or git installation."
    fi
  else
    echo "SecLists already exists in the wordlists directory."
  fi
}

# Main script
echo "Setting up folders and installing tools for penetration testing..."

create_directories
install_tools
download_wordlists

echo "Setup complete!"
