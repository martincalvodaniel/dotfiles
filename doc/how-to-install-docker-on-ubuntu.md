# How to install Docker on Ubuntu: A step-by-step guide

(All credits to https://laboratoriolinux.es/index.php/-noticias-mundo-linux-/software/37315-como-instalar-docker-en-ubuntu-un-guia-paso-a-paso.html)

## Introduction
Docker is an open-source platform that allows you to develop, deploy, and manage applications in containers. This guide will show you how to install Docker on Ubuntu.

## Prerequisites
- An Ubuntu system (20.04/22.04 recommended)
- Terminal access with sudo privileges
- Internet connection

## Step 1: Update the system
```bash
sudo apt update && sudo apt upgrade -y
```

## Step 2: Install necessary dependencies
```bash
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
```

## Step 3: Add the official Docker repository
```bash
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

## Step 4: Install Docker Engine
```bash
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
```

## Step 5: Verify the installation
```bash
docker --version
sudo docker run hello-world
```

## Step 6: Configure Docker to use without sudo (optional)
```bash
sudo usermod -aG docker $USER
newgrp docker
```

## Step 7: Enable Docker at startup (optional)
```bash
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
```

## Conclusion
Now you have Docker correctly installed on your Ubuntu system. You can begin creating and managing containers.
