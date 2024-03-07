#!/bin/bash

sudo dnf update -y
sudo dnf upgrade --refresh --best --allowerasing -y
sudo dnf autoremove -y
sudo dnf clean all -y
sudo dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y dnf-automatic firefox gcc htop inxi nano neofetch notepadqq python3 unzip wget wine zip zsh

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo -y
flatpak update -y
flatpak install flathub org.telegram.desktop org.mozilla.Thunderbird org.libreoffice.LibreOffice -y
flatpak uninstall --unused -y

# Installing Docker Engine (latest)
sudo dnf remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-selinux docker-engine-selinux docker-engine
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo groupadd docker
sudo usermod -aG docker $USER
sudo docker run hello-world

# Installing VS Code

sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
dnf check-update
sudo dnf install -y code # or code-insiders

# Installing Jetbrains Toolbox App
wget https://download-cdn.jetbrains.com/toolbox/jetbrains-toolbox-2.2.2.20062.tar.gz
sudo tar -xzf jetbrains-toolbox-2.2.2.20062.tar.gz -C /opt
sudo mv /opt/jetbrains-toolbox-*/jetbrains-toolbox /opt/jetbrains-toolbox
echo 'export PATH=$PATH:/opt' | tee -a ~/.bashrc ~/.bash_profile
rm jetbrains-toolbox-2.2.2.20062.tar.gz

# Installing JetBrains Mono font
wget https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
unzip JetBrainsMono-2.304.zip
sudo mv fonts /usr/share/jetbrains-fonts
rm -rf fonts/ JetBrainsMono-2.304.zip

# Configuring zsh & fonts
grep tecmint /etc/passwd
sudo chsh -s /bin/zsh $USER

source ~/.bashrc
/bin/zsh
