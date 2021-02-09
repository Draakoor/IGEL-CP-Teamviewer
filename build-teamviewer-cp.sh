#!/bin/bash
#set -x
#trap read debug

# Creating an IGELOS CP for Teamviewer
## Development machine (Ubuntu 18.04)
sudo apt install unzip -y

mkdir build_tar
cd build_tar

wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb

mkdir -p custom/teamviewer

dpkg -x teamviewer_amd64.deb custom/teamviewer

mv custom/teamviewer/usr/share/applications/ custom/teamviewer/usr/share/applications.mime

wget https://github.com/Draakoor/IGEL-CP-Teamviewer/archive/main.zip

unzip main.zip -d custom
mkdir -p custom/teamviewer/config/bin
mkdir -p custom/teamviewer/lib/systemd/system
mv zoom_cp_apparmor_reload custom/teamviewer/config/bin
mv igel-teamviewer-cp-apparmor-reload.service custom/teamviewer/lib/systemd/system/
mv teamviewer-cp-init-script.sh custom

cd custom

tar cvjf teamviewer.tar.bz2 teamviewer custompart-teamviewer.sh
mv teamviewer.tar.bz2 ../..
mv target/teamviewer.inf ../..

cd ../..
rm -rf build_tar
