#!/bin/bash
echo Refreshing package lists
apt update

echo Doing a full upgrade
apt -y full-upgrade

echo Setting locale
locale-gen en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

echo Installing packaging prerequisites
apt install -y curl apt-transport-https ca-certificates curl \
software-properties-common lsb-release locales apt-utils

echo Adding PPAs
add-apt-repository -y ppa:bitcoin/bitcoin
add-apt-repository -y ppa:dansmith/chirp-snapshots
add-apt-repository -y ppa:kamalmostafa/fldigi
add-apt-repository -y ppa:kubuntu-ppa/backports
add-apt-repository -y ppa:oibaf/graphics-drivers
add-apt-repository -y ppa:ondrej/php
add-apt-repository -y ppa:ubuntu-hams-updates
add-apt-repository -y ppa:webupd8team/atom
add-apt-repository -y ppa:wine/wine-builds

echo Installing Docker keys
curl -fsSL https://apt.dockerproject.org/gpg | apt-key add -

echo Installing fldigi keys
curl -fsSL http://repo.longlandclan.id.au/signkey.gpg | apt-key add -

echo Adding Node keys
curl -sL https://deb.nodesource.com/setup_7.x | bash -

RELEASE=$(lsb_release -cs)
echo Release is $RELEASE

echo Modifying sources
sed -i "s/xenial/$RELEASE/g" sources.list.d/*
cp -r sources.list.d /etc/apt/

echo Updating again
apt update

echo Installing software
apt install -y atom fldigi flrig wsjtx docker-engine git ffmpeg firefox \
torbrowser-launcher openmw openmw-launcher wget ddate htop jnettop iotop \
doomsday higan dolphin-emu fceux pcsxr openarena powertop \
sauerbraten qwbfsmanager gimp blender inkscape pavucontrol \
gpredict qsstv freedv clementine gladish qjackctl winehq-staging \
jack-rack ardour guvcview kdenlive picard qarecord rosegarden yoshimi \
chirp-daily vim php-cli php-xml php-curl nodejs python-qt4 python-pip \
build-essential kaffeine
# pcsx2

echo Installing GEarth
wget https://dl.google.com/dl/earth/client/current/google-earth-stable_current_amd64.deb
dpkg -i google-earth-stable_current_amd64.deb

echo Installing GMusicManager
wget https://dl.google.com/linux/direct/google-musicmanager-beta_current_amd64.deb
dpkg -i google-musicmanager-beta_current_amd64.deb

echo Installing Hangouts
wget https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb
dpkg -i google-talkplugin_current_amd64.deb

echo Installing Keybase
curl -O https://prerelease.keybase.io/keybase_amd64.deb
dpkg -i keybase_amd64.deb

echo Installing VSCode
wget https://go.microsoft.com/fwlink/?LinkID=760865 -Ocode-insiders.deb
dpkg -i code-insiders.deb

echo Installing Steam
wget https://steamcdn-a.akamaihd.net/client/installer/steam.deb
dpkg -i steam.deb

echo Installing VBox
wget http://download.virtualbox.org/virtualbox/5.1.14/virtualbox-5.1_5.1.14-112924~Ubuntu~yakkety_amd64.deb
dpkg -i virtualbox-*.deb

echo Installing Vagrant
wget https://releases.hashicorp.com/vagrant/1.9.1/vagrant_1.9.1_x86_64.deb
dpkg -i vagrant*

echo Finishing deps
apt-get install -yf

echo Setting up VBox
/sbin/vboxconfig

echo Installing VBox extpack
wget http://download.virtualbox.org/virtualbox/5.1.14/Oracle_VM_VirtualBox_Extension_Pack-5.1.14-112924.vbox-extpack
VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack*

echo Installing ET
wget http://filebase.trackbase.net/et/full/et260b.x86_full.zip
unzip et*.zip

echo Updating pip
pip install --upgrade pip

echo Installing Electrum
pip install https://download.electrum.org/2.7.18/Electrum-2.7.18.tar.gz

echo Done
