#!/bin/bash
RELEASE=$(lsb_release -cs)
RELEASE=zesty
NODE_VERSION=node_8.x
echo Release is $RELEASE

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

echo Installing Docker keys
curl -fsSL https://apt.dockerproject.org/gpg | apt-key add -

echo Installing fldigi keys
curl -fsSL http://repo.longlandclan.id.au/signkey.gpg | apt-key add -

echo Adding Node keys
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -

echo Adding VBox keys
curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | apt-key add -

echo Adding PPAs
add-apt-repository -y ppa:bitcoin/bitcoin
add-apt-repository -y ppa:dansmith/chirp-snapshots
add-apt-repository -y ppa:kamalmostafa/fldigi
add-apt-repository -y ppa:kubuntu-ppa/backports
add-apt-repository -y ppa:ondrej/php
add-apt-repository -y ppa:ubuntu-hams-updates
add-apt-repository -y ppa:webupd8team/atom
add-apt-repository -y ppa:wine/wine-builds
add-apt-repository -y "deb https://deb.nodesource.com/$NODE_VERSION $RELEASE main"
add-apt-repository -y "deb https://apt.dockerproject.org/repo ubuntu-$RELEASE main"
add-apt-repository -y "deb http://repo.longlandclan.id.au/ubuntu wily main"
add-apt-repository -y "deb http://download.virtualbox.org/virtualbox/debian $RELEASE contrib"

echo Modifying sources
sed -i "s/artful/zesty/g" /etc/apt/sources.list.d/*

echo Updating again
apt update

echo Installing software
apt install -y atom fldigi flrig wsjtx docker-engine git ffmpeg firefox \
torbrowser-launcher wget ddate htop jnettop iotop \
doomsday higan dolphin-emu fceux pcsxr openarena powertop \
sauerbraten qwbfsmanager gimp  inkscape pavucontrol \
gpredict qsstv freedv clementine gladish qjackctl \
jack-rack ardour guvcview kdenlive picard qarecord rosegarden yoshimi \
chirp-daily vim nodejs \
python-qt4 python-pip build-essential kaffeine audacity mplayer \
nmap unrar xtightvncviewer etherape wireshark ufw-kde john \
kde-zeroconf boinc-manager \
ppa-purge hashcat aircrack-ng lm-sensors smartmontools k4dirstat \
whois postfix assimp-utils openssh-server kgpg kleopatra \
virtualbox screenfetch php-cli php-xml php-curl php-mcrypt php-xdebug
# pcsx2 bitcoin-qt blender openmw openmw-launcher winehq-staging

echo Installing GEarth
wget -c https://dl.google.com/dl/earth/client/current/google-earth-stable_current_amd64.deb
dpkg -i google-earth-stable_current_amd64.deb

echo Installing GMusicManager
wget -c https://dl.google.com/linux/direct/google-musicmanager-beta_current_amd64.deb
dpkg -i google-musicmanager-beta_current_amd64.deb

echo Installing Chrome
wget -c https://dl.google.com/linux/direct/google-chrome-unstable_current_amd64.deb
dpkg -i google-chrome-unstable_current_amd64.deb

echo Installing Hangouts
wget -c https://dl.google.com/linux/direct/google-talkplugin_current_amd64.deb
dpkg -i google-talkplugin_current_amd64.deb

echo Installing Keybase
wget -c https://prerelease.keybase.io/keybase_amd64.deb
dpkg -i keybase_amd64.deb

echo Installing VSCode
wget -c https://go.microsoft.com/fwlink/?LinkID=760865 -Ocode-insiders.deb
dpkg -i code-insiders.deb

echo Installing Steam
wget -c https://steamcdn-a.akamaihd.net/client/installer/steam.deb
dpkg -i steam.deb

echo Installing Vagrant
wget -c https://releases.hashicorp.com/vagrant/2.0.0/vagrant_2.0.0_x86_64.deb
dpkg -i vagrant*

echo Finishing deps
apt-get install -yf

echo Installing ET
wget http://filebase.trackbase.net/et/full/et260b.x86_full.zip
unzip et*.zip

echo Updating pip
pip install --upgrade pip

echo Installing Electrum
pip install https://download.electrum.org/2.7.18/Electrum-2.7.18.tar.gz

echo Cleaning up packages
rm *.zip *.deb

echo Done
