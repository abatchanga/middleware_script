#!/bin/bash

# Check if the script is run with root privileges
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root. Use 'sudo $0'." >&2
    exit 1
fi

# Update the system
echo "Updating system..."
yum update -y

# Install required packages
echo "Installing required packages..."
yum install -y yum-utils device-mapper-persistent-data lvm2

# Set up the Docker repository
echo "Setting up Docker repository..."
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker
echo "Installing Docker..."
yum install -y docker-ce docker-ce-cli containerd.io

# Start and enable Docker service
echo "Starting and enabling Docker service..."
systemctl start docker
systemctl enable docker

# Check Docker version
docker --version

echo "Docker installation completed."