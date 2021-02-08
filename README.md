# Zoom

|  CP Information |            |
|-----------------|------------|
| Package | Teamviewer - Current Version |
| Script Name | [custompart-teamviewer](custompart-teamviewer.sh) |
| CP Mount Path | /custom/teamviewer |
| CP Size | 200M |
| IGEL OS Version (min) | 11.3.110 |
| Metadata File <br /> teamviewer.inf | [INFO] <br /> [PART] <br /> file="teamviewer.tar.bz2" <br /> version="15.14.5" <br /> size="200M" <br /> minfw="11.03.110" |
| Path to Executable | /custom/teamviewer/usr/bin/zoom |
| Path to Icon | /custom/teamviewer/usr/share/icons/hicolor/48x48/apps/TeamViewer.png |
| Download package and missing library | wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb |
| Packaging Notes | Create folder: **teamviewer** <br /><br /> dpkg -x <package/lib> custom/teamviewer <br /><br /> Need to move the mime folder: <br /><br />mv /custom/teamviewer/usr/share/applications /custom/teamviewer/usr/share/applications.mime <br /><br />The init script needs additional files to configure AppArmor: <br /><br /> /custom/teamviewer/config/bin/[teamviewer_cp_apparmor_reload](teamviewer_cp_apparmor_reload) <br /> /custom/teamviewer/lib/systemd/system/[igel-teamviewer-cp-apparmor-reload.service](igel-teamviewer-cp-apparmor-reload.service) |
| Package automation | [build-teamviewer-cp.sh](build-zoom-cp.sh) <br /><br /> Tested with 15.14.5 |

|  Customization | - |
|----------------|------------------------------|
