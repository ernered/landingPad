#!/bin/bash

# script to create folders for a pentest and grab tools. Work in progress.
# Define directories to be created
DIRECTORIES=(
  "osint"
  "scanning"
  "exploitation"
  "creds"
  "wordlists"
  "tools"
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

# GitHub repositories to be cloned
GITHUB_REPOS=(
  "https://github.com/topotam/PetitPotam.git"
  "https://github.com/blacklanternsecurity/TREVORspray.git"
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

# Function to install some tools
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

# Function to download SecLists wordlists
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

# Function to install tools from GitHub
install_github_tools() {
  echo "Installing tools from GitHub..."
  for repo in "${GITHUB_REPOS[@]}"; do
    repo_name=$(basename "$repo" .git)
    if [ ! -d "tools/$repo_name" ]; then
      git clone "$repo" "tools/$repo_name"
      if [ $? -eq 0 ]; then
        echo "$repo_name installed successfully."
      else
        echo "Failed to install $repo_name. Please check your internet connection or git installation."
      fi
    else
      echo "$repo_name already exists in the tools directory."
    fi
  done
}

# Pull it all together
echo "Setting up folders and installing tools for penetration testing..."

create_directories
install_tools
download_wordlists
install_github_tools

echo "Setup complete! GLHF! "
