#!/bin/bash

#Function to check which application are installed
check_installed() {
    command -v "$1" >/dev/null 2>&1
}

echo "Checking installed tools..."

# Packages actualization
sudo apt update -y && sudo apt upgrade -y

# Docker installation
if check_installed docker; then
    echo "Docker was installed."
else
    echo "Docker installation"
    sudo apt install -y docker.io
    sudo usermod -aG docker $USER
    sudo gpasswd -a $USER docker
    echo "Docker installed"
    source ~/.bashrc
fi

# Minikube installation
if check_installed minikube; then
    echo "Minikube was installed."
else
    echo "Minikube installation..."
    curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
    rm minikube-linux-amd64
    echo "Minikube installed."
fi

# Kind installation
if check_installed kind; then
    echo "Kind was installed."
else
    echo "Kind installation..."
    curl -Lo ./kind "https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64"
    chmod +x ./kind
    sudo mv ./kind /usr/local/bin/kind
    echo "Kind installed."
fi

# Helm installation
if check_installed helm; then
    echo "Helm was installed."
else
    echo "Helm installation..."
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
    echo "Helm installed."
fi

# Kubectl installation
if check_installed kubectl; then
    echo "Kubectl was installed."
else
    echo "Kubectl installation..."
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
    echo "Kubectl installed."
fi

echo "Installation done! Restart terminal or run 'newgrp docker' to activate changes."
