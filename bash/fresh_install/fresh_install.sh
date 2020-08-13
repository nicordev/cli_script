#!/bin/bash

gitUsername='nicor'
gitEmail='nicolas.renvoise.dev@gmail.com'

echo -e "Let's go install some useful stuff!\n"

apt-get update

# VSCodium:
#   https://github.com/VSCodium/vscodium
#   https://vscodium.com/

getVsCodiumUsingSnap() {
    snap install codium
}

getVsCodiumUsingApt() {
    wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | apt-key add -
    echo 'deb https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/debs/ vscodium main' | tee --append /etc/apt/sources.list.d/vscodium.list
    apt update && apt install codium
}

# Git:
#   https://git-scm.com/download/linux

getGit() {
    apt-get install git
    git config --global user.name "$gitUsername"
    git config --global user.email "$gitEmail"
}

# Vim:

getVim() {
    apt-get install vim
}

# Insomnia:
#   https://support.insomnia.rest/article/23-installation#linux

getInsomnia() {
    # Add to sources
    echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
        | tee -a /etc/apt/sources.list.d/insomnia.list

    # Add public key used to verify code signature
    wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
        | apt-key add -

    # Refresh repository sources and install Insomnia
    apt-get update
    apt-get install insomnia

}

# Docker:
#   https://docs.docker.com/engine/install/ubuntu/

getDocker() {
    apt-get install \
        apt-transport-https \
        ca-certificates \
        curl \
        gnupg-agent \
        software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

    apt-key fingerprint 0EBFCD88

    add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"
    
    apt-get update
    apt-get install docker-ce docker-ce-cli containerd.io
}

# Uncomment the packages you want:

# getGit
# getVim
getVsCodiumUsingApt
getInsomnia
getDocker