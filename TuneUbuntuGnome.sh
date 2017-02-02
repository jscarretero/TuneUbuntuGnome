#!/bin/bash
# Author:  Javier Carretero Casado
# License:


# TODO??: Check we are using Ubuntu Unity, otherwise exit saying why
# TODO: install git!

echo "[Updating list of available packages]"
sudo apt update -y -q &> /dev/null

echo
echo "[Upgrading system packages. This will take a while...]"
sudo apt -y -q upgrade &> /dev/null

echo
echo "[Installing Dconf tools]"
sudo apt-get install -y -q dconf-cli > /dev/null
sudo apt-get install -y -q dconf-editor > /dev/null

echo "[Installing Gconf-editor]"
sudo apt-get install -y -q gconf-editor > /dev/null

echo "[Installing Unity tweak tool]"
sudo apt-get install -y -q unity-tweak-tool > /dev/null

echo "[Installing Synaptic package manager]"
sudo apt-get install -y -q synaptic > /dev/null

echo "[Installing Slack]"
sudo apt-get install -y -q slack > /dev/null

echo "[Installing Spotify]"
# Commands from https://www.spotify.com/es/download/linux/
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 &> /dev/null
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list > /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q spotify-client > /dev/null

# REVIEW CHROME
#echo "[Installing Chrome]"
#wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - &> /dev/null
#sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
#sudo apt-get update -y -q &> /dev/null
#sudo apt-get install -y -q google-chrome-stable > /dev/null

echo "[Installing Transmission for bittorrents]"
sudo apt-get install -y -q transmission > /dev/null
sudo apt-get install -y -q transmission-qt > /dev/null

echo "[Installing QBitTorrent]"
sudo add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q qbittorrent > /dev/null

echo "[Installing Oracle's VirtualBox]"
sudo apt-get install -y -q virtualbox-qt > /dev/null

echo "[Installing Restricted extras and addons (including codecs)]"
#TODO: check what they are installing
sudo apt-get install -y -q ubuntu-restricted-extras                  #interactive!!
sudo apt-get install -y -q ubuntu-restricted-addons > /dev/null
sudo apt-get install -y -q libdvdcss2 libdvdnav4 libdvdread4  > /dev/null
sudo apt-get install -y -q libdvd-pkg > /dev/null
sudo dpkg-reconfigure libdvd-pkg > /dev/null
#echo "[Installing Flash Player (flash will soon be unsupported)]"
#sudo apt-get install flashplugin-installer #Not needed for Chrome #already installed by restricted-extras

echo "[Installing VLC Media Player]"  #Alternative to Ubuntu GNOME's "Totem" app
sudo apt-get install -y -q vlc &> /dev/null

echo "[Installing Atom editor]"
sudo add-apt-repository -y ppa:webupd8team/atom &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q atom > /dev/null
echo "[Configuring Atom editor]"
#TODO: same as nano (tabs to spaces, 4 spaces, max column)

echo "[Installing Darktable photo editor]"
sudo add-apt-repository -y ppa:pmjdebruijn/darktable-release &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q darktable > /dev/null

echo "[Installing Pinta (better Paint)]"
sudo apt-get install -y -q pinta > /dev/null

echo "[Installing Remarkable (Markdown editor)]"
wget --quiet https://remarkableapp.github.io/files/remarkable_1.87_all.deb  #FIXME with latest file name
sudo apt-get install -y -q gdebi > /dev/null
sudo gdebi -q -n remarkable_1.87_all.deb > /dev/null                        #FIXME with latest file name
\rm remarkable_1.87_all.deb

echo "[Installing GIT client]" #gitkraken? gitk?
#TODO

#TODO: NO: use bash-it instead!!
#echo "[Installing Oh-my-zsh]"
#echo "[Configuring Oh-my-zsh]"
#echo "[...Changing theme]" !!!
#echo "[...Changing plugins]"
#echo "[...Changing fonts]"
#echo "[...Changing color schemes]"s

echo "[Installing new Fonts]" #!!!!
#TODO
echo "[Installing new Icon sets]" # ????
#TODO?

echo "[Configuring terminal aspect]"
#TODO: use tabs instead of new windows
#TODO: install tmux? terminator? screen?
#TODO: disable beep

echo "[Configuring keyboard delays - rates]"
gsettings set org.gnome.desktop.peripherals.keyboard delay 145
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 22
gsettings set org.gnome.desktop.peripherals.keyboard repeat true

echo "[Configuring Gnome]"
echo "[ ...Showing minimize-maximize icons]"
echo "[ ...]"
#TODO

echo "[Installing 'Paper' GTK theme, icons and cursors]"
sudo add-apt-repository -y ppa:snwh/pulp &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q paper-icon-theme > /dev/null
sudo apt-get install -y -q paper-gtk-theme > /dev/null
sudo apt-get install -y -q paper-cursor-theme > /dev/null
echo "[Installing 'Flatabulous' GTK theme, icons and cursors]"
sudo add-apt-repository -y ppa:noobslab/themes &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q flatabulous-theme > /dev/null
sudo add-apt-repository -y ppa:noobslab/icons &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q ultra-flat-icons > /dev/null
#TODO: activate flatabulous theme, icons

echo "[Adding Gnome shell extensions]"

echo "[Configuring Gnome shell]"
# TODO: new tab instead of window
# TODO: bell

echo "[Configuring Terminal]"

echo "[Installing Guake (Ctr+F12)]"
sudo apt-get install -y -q guake > /dev/null
echo "[Configuring Guake]"
# TODO:!!!
# TODO: Add guake to startup applications

echo "[Changing wallpaper]"
#wget -q -o "$HOME/Pictures/wallpaper.jpg" http://www.elviajeroazul.top/wp-content/uploads/2016/07/atardecer-magico-fondos-4k-hd-elviajeroazul.top-13.jpg
#if [$? -eq 0 ] ; then
#    gsettings set org.gnome.desktop.background picture-uri "$HOME/Pictures/wallpaper.jpg"
#fi
echo "[Changing lockscreen wallpaper]"
# TODO
echo "[Changing welcome wallpaper]"
# TODO
echo "[Disabling annoying beep sounds]"
# TODO

echo "[Installing Nano]"
sudo apt-get install -y -q nano > /dev/null
echo "[Configuring Nano]"
 echo "include \"/usr/share/nano/*.nanorc\"" >> ~/.nanorc
 echo "set autoindent" >> ~/.nanorc
 echo "set cut" >> ~/.nanorc
 echo "set nowrap" >> ~/.nanorc
 echo "set smooth" >> ~/.nanorc
 echo "set tabsize 4" >> ~/.nanorc
 echo "unset casesensitive" >> ~/.nanorc
 echo "set morespace" >> ~/.nanorc
 echo "unset nonewlines" >> ~/.nanorc
 echo "set tabstospaces" >> ~/.nanorc


echo "[Installing Gedit]"
# http://askubuntu.com/questions/571877/how-to-change-gedit-preferences-from-terminal
killall gedit &> /dev/null
sudo apt-get install -y -q gedit > /dev/null
echo "[Configuring Gedit]"
gsettings set org.gnome.gedit.preferences.editor wrap-mode 'none'
gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
gsettings set org.gnome.gedit.preferences.editor highlight-current-line true
gsettings set org.gnome.gedit.preferences.editor insert-spaces true
gsettings set org.gnome.gedit.preferences.editor tabs-size 4
gsettings set org.gnome.gedit.preferences.editor auto-indent true
gsettings set org.gnome.gedit.preferences.editor display-right-margin true
gsettings set org.gnome.gedit.preferences.editor right-margin-position 110
gsettings set org.gnome.gedit.preferences.editor scheme 'oblivion'
gsettings set org.gnome.gedit.preferences.editor use-default-font true
gsettings set org.gnome.gedit.preferences.editor editor-font 'Monospace 9'
  # Trim trailing whitespaces when saving files
  git clone https://github.com/jonleighton/gedit-trailsave &> /dev/null
  pushd . &> /dev/null
  cd gedit-trailsave  && ./install.sh &> /dev/null
  plugins=`gsettings get org.gnome.gedit.plugins active-plugins` ; plugins=${plugins::-1} ;
  plugins="$plugins, 'trailsave']"
  gsettings set org.gnome.gedit.plugins active-plugins "$plugins"
  popd &> /dev/null
  \rm -rf gedit-trailsave

echo "[Adding Docky dock bar]"
sudo apt-get install -y -q docky &> /dev/null

echo "[Configuring dock bar]"
# Auto-Start
mkdir $HOME/.config/autostart/
cat <<EOF > $HOME/.config/autostart/docky.desktop
[Desktop Entry]
Name=Docky
Type=Application
Exec=docky
Terminal=false
Icon=docky
Comment=The finest dock no money can buy.
NoDisplay=false
Categories=Utility;
X-GNOME-Autostart-enabled=true
EOF

#Configure docklets (Trash, Desktop, Weather)
gconftool-2 --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/Plugins ['Trash','Desktop','Weather']

#Add launch icons (.desktop files)
gconftool-2 --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/Launchers ['file:///usr/share/applications/gnome-terminal.desktop','file:///usr/share/applications/nautilus.desktop','file:///usr/share/applications/google-chrome.desktop','file:///usr/share/applications/spotify.desktop','file:///usr/share/ubuntu/applications/org.gnome.Software.desktop','file:///usr/share/applications/qBittorrent.desktop','file:///usr/share/applications/gnome-calculator.desktop']
gconftool-2 --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/SortList  ['/usr/share/applications/gnome-terminal.desktop','/usr/share/applications/nautilus.desktop','/usr/share/applications/google-chrome.desktop','/usr/share/applications/spotify.desktop','/usr/share/ubuntu/applications/org.gnome.Software.desktop','/usr/share/applications/qBittorrent.desktop','/usr/share/applications/gnome-calculator.desktop','TrashCan','Desktop','WeatherDockItem']

#Configure effects + size
gconftool-2 --type string --set /apps/docky-2/Docky/Services/ThemeService/Theme 'Transparent'
gconftool-2 --type Boolean --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/ThreeDimensional True
gconftool-2 --type Integer --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/IconSize 75
gconftool-2 --type Float --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/ZoomPercent 2.1
gconftool-2 --type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/Autohide 'Intellihide'
gconftool-2 --type Boolean --set /apps/docky-2/Docky/Items/DockyItem/ShowDockyItem False
gconftool-2 --type list --list-type string --set /apps/docky-2/WeatherDocklet/WeatherPreferences/Location ['Barcelona, Spain']
gconftool-2 --type Boolean --set /apps/docky-2/WeatherDocklet/WeatherPreferences/Metric 'True'
gconftool-2 --type Integer --set /apps/docky-2/WeatherDocklet/WeatherPreferences/Timeout 60

echo "[Hiding Unity dock (will not disable it)]"
#http://askubuntu.com/questions/643028/shell-script-to-remove-unity-launcherif-present-in-ubuntu-14-04-and-or-the-xf
dconf write /org/compiz/profiles/unity/plugins/unityshell/launcher-hide-mode 1   #0 to enable back
dconf write /org/compiz/profiles/unity/plugins/unityshell/edge-responsiveness 0  #2 to enable back

echo "[Changing timezone to Europe/Madrid"
sudo timedatectl set-timezone Europe/Madrid
# sudo dpkg-reconfigure tzdata   # This will bring up a new window where the user can select it

echo "[Changing keyboard layout to 'es']"
sudo setxkbmap -layout es  #DOES NOT WORK

sudo apt autoremove -y -q &> /dev/null
sudo apt clean -y -q &> /dev/null
sudo apt-get -y -q autoclean &> /dev/null
echo "[ DONE! Log out from this session and login again to see all the changes. Hope it works! ]"

# LINKS:
# http://askubuntu.com/questions/22313/what-is-dconf-what-is-its-function-and-how-do-i-use-it
