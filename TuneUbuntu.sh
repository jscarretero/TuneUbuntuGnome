#!/bin/bash
# Author:  Javier Carretero Casado
# License: Beerware

# Before running this sript on a fresh Ubuntu installation, I recommend you to try it on a virtual machine
# where you may have installed that Ubuntu image.

set -e

if ! [ "$XDG_CURRENT_DESKTOP" == "Unity" ] ; then
    echo "This script works for Linux Ubuntu with Unity. You will need to tweak this file to work for other "
    echo "Linux distributions or windows managers. Exiting."
    exit 1
fi

echo "[Upgrading system packages. This will take a while...]"
sudo apt -y -q upgrade &> /dev/null
sudo apt-get -y -q dist-upgrade &> /dev/null

echo "[Updating list of available packages]"
sudo apt update -y -q &> /dev/null

echo
echo "[Installing basic tools (dconf, gconf-editor, unity-tweak-tool, git, synaptic, gparted, compression utilities, zsh)]"
sudo apt-get install -y -q zsh &> /dev/null
chsh -s $(which zsh)
sudo apt-get install -y -q dconf-cli &> /dev/null
sudo apt-get install -y -q dconf-editor &> /dev/null
sudo apt-get install -y -q gconf-editor &> /dev/null
sudo apt-get install -y -q unity-tweak-tool &> /dev/null
sudo apt-get install -y -q git &> /dev/null
sudo apt-get install -y -q synaptic &> /dev/null
sudo apt-get install -y -q gparted &> /dev/null
sudo apt-get install -y -q libgnome2-bin &> /dev/null
sudo apt-get install -y -q tree &> /dev/null
sudo apt-get install -y -q rar unace p7zip p7zip-full p7zip-rar unrar lzip lhasa arj sharutils mpack lzma lzop cabextract &> /dev/null

echo
echo "[Installing Ukuu (ubuntu kernel update utility)]" #ukuu-gtk
sudo apt-add-repository -y ppa:teejee2008/ppa &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q ukuu &> /dev/null

echo "[Installing Chrome]"
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - &> /dev/null
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q google-chrome-stable &> /dev/null
sudo rm -rf /etc/apt/sources.list.d/google.list

echo "[Installing Spotify]"
# Commands from https://www.spotify.com/es/download/linux/
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886 &> /dev/null
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q spotify-client &> /dev/null

echo "[Installing QBitTorrent]"
sudo add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q qbittorrent &> /dev/null

echo "[Installing Pinta (better Paint)]"
sudo apt-get install -y -q pinta &> /dev/null

echo "[Installing GIMP (Photoshop alternative)]"
sudo apt-get install -y -q gimp &> /dev/null

echo "[Installing Oracle's VirtualBox]"
sudo apt-get install -y -q virtualbox-qt &> /dev/null

#echo "[Installing Visual Studio Code]" #TODO
# https://code.visualstudio.com/docs/editor/command-line
# https://gist.github.com/brunolm/65a760f6130fd2e1d39c
# https://askubuntu.com/a/616080

echo "[Installing Remarkable (Markdown editor)]"  #TODO: do I need it when Visual Studio Code has extensions?
wget --quiet https://remarkableapp.github.io/files/remarkable_1.87_all.deb  #FIXME with latest file name
sudo apt-get install -y -q gdebi &> /dev/null
sudo gdebi -q -n remarkable_1.87_all.deb &> /dev/null                        #FIXME with latest file name
\rm -rf remarkable_1.87_all.deb

echo "[Installing Nano and configuring it]"
sudo apt-get install -y -q nano &> /dev/null
#echo "[Configuring Nano]"
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

echo "[Installing Gedit and configuring it]" # WARNING: gedit has no dev support anymore, does it?
# http://askubuntu.com/questions/571877/how-to-change-gedit-preferences-from-terminal
killall gedit &> /dev/null || true
sudo apt-get install -y -q gedit &> /dev/null
gsettings set org.gnome.gedit.preferences.editor wrap-mode 'none'
gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
gsettings set org.gnome.gedit.preferences.editor highlight-current-line true
gsettings set org.gnome.gedit.preferences.editor insert-spaces true
gsettings set org.gnome.gedit.preferences.editor tabs-size 4
gsettings set org.gnome.gedit.preferences.editor auto-indent true
gsettings set org.gnome.gedit.preferences.editor display-right-margin true
gsettings set org.gnome.gedit.preferences.editor right-margin-position 79
gsettings set org.gnome.gedit.preferences.editor scheme 'oblivion'
gsettings set org.gnome.gedit.preferences.editor use-default-font false #true
gsettings set org.gnome.gedit.preferences.editor editor-font 'Ubuntu Mono Regular 15'
gsettings set org.gnome.gedit.preferences.editor display-overview-map true
gsettings set org.gnome.gedit.preferences.editor bracket-matching true

  # Trim trailing whitespaces when saving files (plugin)
  git clone https://github.com/jonleighton/gedit-trailsave &> /dev/null
  pushd . &> /dev/null
  cd gedit-trailsave  && ./install.sh &> /dev/null
  plugins=`gsettings get org.gnome.gedit.plugins active-plugins` ; plugins=${plugins::-1} ;
  plugins="$plugins, 'trailsave']"
  gsettings set org.gnome.gedit.plugins active-plugins "$plugins"
  popd &> /dev/null
  \rm -rf gedit-trailsave

  #Change keybindings to move to new tab from Ctl+Alt+PgUp/Down to Ctrl+PgUp/Down (plugin)
  git clone https://github.com/jefferyto/gedit-control-your-tabs.git &> /dev/null
  cp ./gedit-control-your-tabs/controlyourtabs.plugin ~/.local/share/gedit/plugins
  cp -rf gedit-control-your-tabs/ ~/.local/share/gedit/plugins/
  #cp ./gedit-control-your-tabs/controlyourtabs.py ~/.local/share/gedit/plugins
  \rm -rf gedit-control-your-tabs
  plugins=`gsettings get org.gnome.gedit.plugins active-plugins` ; plugins=${plugins::-1} ;
  plugins="$plugins, 'controlyourtabs']"
  gsettings set org.gnome.gedit.plugins active-plugins "$plugins"

  #Add Dracula color theme and enable it (theme)
  mkdir -p $HOME/.local/share/gedit/styles/
  wget --quiet -O $HOME/.local/share/gedit/styles/dracula.xml https://raw.githubusercontent.com/dracula/gedit/master/dracula.xml
  #Patch the 'selection' color to not clash with 'current-line' color (black color) ... fuck that
  sed -i '/selection" value/c\    \<color name="selection" value="#000000"/\>' $HOME/.local/share/gedit/styles/dracula.xml
  #gsettings set org.gnome.gedit.preferences.editor scheme 'dracula'  #No, keep oblivion


echo "[Installing Gnome-Terminal and configuring it]"
sudo apt-get install -y -q gnome-terminal &> /dev/null
profId=$(gsettings get org.gnome.Terminal.ProfilesList default | sed "s/^\([\"']\)\(.*\)\1\$/\2/g")
gsettings set org.gnome.Terminal.Legacy.Settings new-terminal-mode 'tab'
gsettings set org.gnome.Terminal.Legacy.Settings tab-position 'bottom'
dconf write /org/gnome/terminal/legacy/profiles:/:$profId/use-system-font false
dconf write /org/gnome/terminal/legacy/profiles:/:$profId/font "'Ubuntu Mono Regular 15'"  #two quotes!!
 # Ctrl+PageDown for Next Tab
 # Ctrl+PageUp for Previous Tab

# Install Dracula theme for Gnome-terminal
git clone https://github.com/GalaticStryder/gnome-terminal-colors-dracula &> /dev/null
sleep 1
cd gnome-terminal-colors-dracula
sleep 1
./install.sh --scheme=Dracula -p :$profId --skip-dircolors
sleep 1
cd ..
rm -rf ./gnome-terminal-colors-dracula

#echo "[Installing Guake (Ctr+F12 Terminal)]"
#sudo apt-get install -y -q guake &> /dev/null
#gconftool-2 --type Integer --set /apps/guake/general/window_height  100
#gconftool-2 --type Float   --set /apps/guake/general/window_height_f 100
#gconftool-2 --type Integer --set /apps/guake/general/window_width 100
#gconftool-2 --type Float   --set /apps/guake/general/window_width_f 100
#gconftool-2 --type Integer --set /apps/guake/style/background/transparency 0
#gconftool-2 --type Boolean --set /apps/guake/general/use_visible_bell  True
#gconftool-2 --type Boolean --set /apps/guake/general/window_losefocus False
#gconftool-2 --type Boolean --set /apps/guake/general/window_ontop False
#gconftool-2 --type string  --set /apps/guake/style/font/palette_name 'Dracula'
#gconftool-2 --type Boolean --set /apps/guake/general/use_default_font False
#gconftool-2 --type string  --set /apps/guake/style/font/style 'Ubuntu Mono Regular 15'
#gconftool-2 --type Boolean --set /apps/guake/general/use_popup False
#vtimeout 2.5 guake-prefs &> /dev/null  || true
##Add guake to startup applications
#sudo ln -s /usr/share/applications/guake.desktop /etc/xdg/autostart/

 # https://github.com/zsh-users/
 # https://github.com/zsh-users/antigen
echo "[Installing Antigen (plugin manager for zsh)]"
pushd . &> /dev/null
cd ~
git clone https://github.com/zsh-users/antigen.git &> /dev/null
mv antigen .antigen &> /dev/null

git clone git://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions &> /dev/null

#Backup .zshrc if it exists
if [ -f ~/.zshrc ] ; then
    echo "...backing up .zshrc file to $HOME/.antigen/.zshrc_bck"
    cp -f ~/.zshrc $HOME/.antigen/.zshrc_bck
fi

rm -rf ~/.zshrc

# Create alias soft links
ln -s ~/TuneUbuntu/dotfiles/zsh/.zshrc ~/.zshrc  &> /dev/null
declare -a arr=(".common_alias" ".apt_alias")
for i in "${arr[@]}"
do
    ln -s ~/TuneUbuntu/dotfiles/zsh/$i ~/$i  &> /dev/null
done
popd &> /dev/null

echo "source ~/.common_alias" >> $HOME/.sourced
echo "source ~/.apt_alias" >> $HOME/.sourced

echo "[Installing Docky dock bar]"
sudo apt-get install -y -q docky &> /dev/null
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
# Configure docklets (Trash, Desktop, Weather)
gconftool-2 --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/Plugins ['Trash','Desktop','Weather']
# Add launch icons (.desktop files)
gconftool-2 --type Boolean --set /apps/docky-2/Docky/Interface/DockPreferences/FirstRun False
gconftool-2 --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/Launchers ['file:///usr/share/applications/gnome-terminal.desktop','file:///usr/share/applications/nautilus.desktop','file:///usr/share/applications/google-chrome.desktop','file:///usr/share/applications/spotify.desktop','file:///usr/share/ubuntu/applications/org.gnome.Software.desktop','file:///usr/share/applications/qbittorrent.desktop','file:///usr/share/applications/gnome-calculator.desktop']
#gconftool-2 --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/SortList  ['/usr/share/applications/gnome-terminal.desktop','/usr/share/applications/nautilus.desktop','/usr/share/applications/google-chrome.desktop','/usr/share/applications/spotify.desktop','/usr/share/ubuntu/applications/org.gnome.Software.desktop','/usr/share/applications/qbittorrent.desktop','/usr/share/applications/gnome-calculator.desktop','TrashCan','Desktop','WeatherDockItem']
gconftool-2 --type list --list-type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/SortList  ['/usr/share/applications/gnome-terminal.desktop','/usr/share/applications/nautilus.desktop','/usr/share/applications/google-chrome.desktop','/usr/share/applications/spotify.desktop','/usr/share/ubuntu/applications/org.gnome.Software.desktop','/usr/share/applications/qbittorrent.desktop','/usr/share/applications/gnome-calculator.desktop']
# Configure effects + size
gconftool-2 --type string --set /apps/docky-2/Docky/Services/ThemeService/Theme 'Transparent' #Air
gconftool-2 --type Boolean --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/ThreeDimensional True
gconftool-2 --type Integer --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/IconSize 75
gconftool-2 --type Float --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/ZoomPercent 2.1
gconftool-2 --type string --set /apps/docky-2/Docky/Interface/DockPreferences/Dock1/Autohide 'UniversalIntellihide'
gconftool-2 --type Boolean --set /apps/docky-2/Docky/Items/DockyItem/ShowDockyItem False
gconftool-2 --type list --list-type string --set /apps/docky-2/WeatherDocklet/WeatherPreferences/Location ['Barcelona\, spain']
gconftool-2 --type Boolean --set /apps/docky-2/WeatherDocklet/WeatherPreferences/Metric True
gconftool-2 --type Integer --set /apps/docky-2/WeatherDocklet/WeatherPreferences/Timeout 60
nohup docky &> /dev/null &

# Hide Unity dock (will not disable it)
#http://askubuntu.com/questions/643028/shell-script-to-remove-unity-launcherif-present-in-ubuntu-14-04-and-or-the-xf
dconf write /org/compiz/profiles/unity/plugins/unityshell/launcher-hide-mode 1   #0 to enable back
dconf write /org/compiz/profiles/unity/plugins/unityshell/edge-responsiveness 0  #2 to enable back
gsettings set com.canonical.Unity.Launcher favorites [] #gsettings reset com.canonical.Unity.Launcher favorites
gsettings set org.compiz.unityshell:/org/compiz/profiles/unity/plugins/unityshell/ icon-size 8

echo "[Installing classic Application top menu]"
sudo apt-add-repository -y ppa:diesch/testing  &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q classicmenu-indicator &> /dev/null

echo "[Installing new Fonts (Powerline)]"
git clone https://github.com/powerline/fonts.git  &> /dev/null
cd fonts
./install.sh &> /dev/null
cd ..
\rm -rf ./fonts
sudo apt-get install -y -q fonts-powerline &> /dev/null
fc-cache -vf &> /dev/null #refresh font cache! (make fonts available)

echo "[Installing 'Paper' GTK theme, icons and cursors]"
sudo add-apt-repository -y ppa:snwh/pulp &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q paper-icon-theme &> /dev/null
sudo apt-get install -y -q paper-gtk-theme &> /dev/null
sudo apt-get install -y -q paper-cursor-theme &> /dev/null
echo "[Installing 'Flatabulous' GTK theme, icons and cursors]"
sudo add-apt-repository -y ppa:noobslab/themes &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q flatabulous-theme &> /dev/null
sudo add-apt-repository -y ppa:noobslab/icons &> /dev/null
sudo apt-get update -y -q &> /dev/null
sudo apt-get install -y -q ultra-flat-icons &> /dev/null

echo "[Configuring visual aspect]"
gsettings set org.gnome.desktop.interface gtk-theme 'Flatabulous'
gsettings set org.gnome.desktop.interface icon-theme 'Paper'
gsettings set com.canonical.indicator.datetime show-date true
gsettings set com.canonical.indicator.datetime show-year true
gsettings set com.canonical.indicator.power show-percentage true
gsettings set com.canonical.indicator.power show-time true
gsettings set org.gnome.nautilus.icon-view default-zoom-level 'large'
gsettings set org.gtk.Settings.FileChooser show-hidden true
gsettings set com.canonical.Unity always-show-menus false
gsettings set com.canonical.Unity integrated-menus false
#gsettings set org.compiz.animation:/org/compiz/profiles/unity/plugins/animation/ unminimize-effects [\'animation:"Magic Lamp"\'] #"Glide 2" is the original # needs some package
#gsettings set org.compiz.animation:/org/compiz/profiles/unity/plugins/animation/ minimize-effects [\'animation:"Magic Lamp"\'] #"Zoom" is the original
sudo sh -c "echo 'LC_TIME=\"en_GB.UTF-8\"' >> /etc/default/locale"

wget --quiet http://wallpaper-gallery.net/images/desktop-wallpaper-mountains/desktop-wallpaper-mountains-17.jpg --output-document ~/Pictures/mountains.jpg
imageFile=$(readlink -e ~/Pictures/mountains.jpg)
imageFile="'file://$imageFile'"
#gsettings set org.gnome.desktop.background picture-uri $imageFile #disabled

echo "[Other configurations]"
sudo timedatectl set-timezone Europe/Madrid
#sudo dpkg-reconfigure tzdata   # This will bring up a new window where the user can select it

#echo "[Changing keyboard layout to 'es']"   # and winkeys?
#sudo setxkbmap -layout es  #TODO: Does not work

gsettings set org.gnome.desktop.peripherals.keyboard delay 140
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 20
gsettings set org.gnome.desktop.peripherals.keyboard repeat true

echo "[Installing Restricted extras and addons]"
sudo apt-get install -y -q ubuntu-restricted-addons &> /dev/null  || true
sudo apt-get --no-install-recommends install ubuntu-restricted-extras &> /dev/null  || true
# I have removed the Microsoft Fonts! The package list have been obtained through synaptic
sudo apt-get install -y -q libavcodec-extra libavcodec-ffmpeg-extra56  &> /dev/null || true

####sudo apt-get install -y -q libdvdcss2 &> /dev/null
#sudo apt-get install -y -q libdvdnav4 &> /dev/null
#sudo apt-get install -y -q libdvdread4  &> /dev/null
#sudo apt-get install -y -q libdvd-pkg &> /dev/null
####sudo dpkg-reconfigure libdvd-pkg &> /dev/null

# Install the latest proprietary Linux graphics drivers available for your hardware
#       http://www.webupd8.org/2016/06/how-to-install-latest-nvidia-drivers-in.html
#       https://ubuntu-mate.community/t/how-to-install-graphics-card-drivers-in-ubuntu/3228
echo "[You may want to install specific GPU drivers. Opening a window (close it to skip this step)]"
echo "[ Remember that you may have already installed those propietary software packages during Ubuntu installation]"
nohup software-properties-gtk --open-tab=4 &> /dev/null &

sudo apt autoremove -y -q &> /dev/null
sudo apt clean -y -q &> /dev/null
sudo apt-get -y -q autoclean &> /dev/null
echo "[ DONE! Log out from this session and login again to see all the changes. Hope it works! ]"
echo "[ Remember that installed applications can be accessed by clicking on the 'three stacked rectangles' icon (dock at the top left) ]"
echo "[ Or by clicking on the 'Ubuntu Software' icon (dock bar at the bottom) ]"

# TODO: Change default apps for web browser, mail client, music player, video player and photo viewer (don't know how to do that through CLI)
# TODO: Windowskey + M to minimize all windows (possible?)
# TODO: Windowskey + Enter to show windows thumbnails


notify-send "DONE!    :)"

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                            STUFF TO CONSIDER
# TODO?: screencast recorders (for GIFs)
# TODO?: audio editors
# TODO?: video editors
# TODO?: STEAM
# TODO?: DropBox
# TODO?: Gufws
# TODO?: Peazip GUI
# TODO?: Password manager like KeepPass, but that synchronizes to cloud
#
#echo "[Installing Thunderbird (e-mail client)]"
#sudo apt-get install -y -q thunderbird &> /dev/null
#
#echo "[Installing Geary (e-mail client, alternative to Thunderbird)]"
#sudo apt-get install -y -q geary &> /dev/null
#
#echo "[Installing Evolution (e-mail client, alternative to Thunderbird) ]"
#sudo apt-get install -y -q evolution &> /dev/null
#
#echo "[Installing Skype]" #TODO: too old!, dont use it
#sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
#sudo dpkg --add-architecture i386
#sudo apt-get update -y -q &> /dev/null
#sudo apt-get install -y -q skype &> /dev/null
#
#echo "[Installing Shutter (advanced screenshot capture)]"
#sudo apt-get install -y -q shutter &> /dev/null
#
#echo "[Installing SimpleScreenRecorder (screen recorder)]"
#sudo add-apt-repository -y ppa:maarten-baert/simplescreenrecorder &> /dev/null
#sudo apt-get update -y -q &> /dev/null
#sudo apt-get install -y -q simplescreenrecorder &> /dev/null
#
#echo "[Installing Darktable photo manager and editor]"
#sudo add-apt-repository -y ppa:pmjdebruijn/darktable-release &> /dev/null
#sudo apt-get update -y -q &> /dev/null
#sudo apt-get install -y -q darktable &> /dev/null
#
#echo "[Installing Digikam photo editor]"
#sudo apt-get install -y -q digikam &> /dev/null
#
#echo "[Installing Shotwell photo editor]"
#sudo apt-get install -y -q shotwell &> /dev/null
#
#echo "[Installing RawTherapee photo editor]"
#sudo add-apt-repository -y ppa:dhor/myway  &> /dev/null
#sudo apt-get update -y -q  &> /dev/null
#sudo apt-get install -y -q rawtherapee  &> /dev/null
#
#echo "[Installing Inkscape (vector drawing and PDF editor, like LibreOffice Draw - alternative to Adobe Illustrator)]"
#sudo apt-get install -y -q inkscape &> /dev/null
#
#echo "[Installing LibreOffice (FOSS alternative to MS Office)]"
#sudo apt-get install -y -q libreoffice &> /dev/null
#
#echo "[Installing Evince (PDF viewer and annotator)]"
#sudo apt-get install -y -q evince &> /dev/null
#
#echo "[Installing Okular (PDF viewer and annotator)]"
#sudo apt-get install -y -q okular &> /dev/null
#
#echo "[Installing Pdftk (PDF manipulation)]"
#sudo apt-get install -y -q pdftk &> /dev/null
#
#echo "[Installing PDFChain (Pdftk GUI)]"
#sudo add-apt-repository -y ppa:pdfchain-team/ppa &> /dev/null
#sudo apt-get update -y -q &> /dev/null
#sudo apt-get install -y -q pdfchain &> /dev/null
#sudo add-apt-repository -y  -r ppa:pdfchain-team/ppa &> /dev/null # Removes repo, seems to break things !
#
#echo "[Installing Mcomix (comic viewer)]"
#sudo apt-get install -y -q mcomix &> /dev/null
#
#echo "[Installing Qcomicbook (comic viewer)]"
#sudo apt-get install -y -q qcomicbook &> /dev/null
#
#echo "[Installing Calibre (ebook reader)]"
#sudo apt-get install -y -q calibre &> /dev/null
#
#echo "[Installing Bleachbit (cleaner)]"
#sudo apt-get install -y -q bleachbit &> /dev/null
#echo "[Installing Transmission for bittorrents]"
#sudo apt-get install -y -q transmission &> /dev/null
#sudo apt-get install -y -q transmission-qt &> /dev/null
#
#echo "[Installing Slack]"
#sudo apt-get install -y -q slack &> /dev/null  #TODO: Does not work
#
#echo "[Installing Rhythmbox and plugins (music player)]"
#sudo apt-get install -y -q rhythmbox &> /dev/null
#sudo add-apt-repository -y ppa:fossfreedom/rhythmbox-plugins &> /dev/null
#sudo apt-get update -y -q &> /dev/null
#sudo apt-get install -y -q rhythmbox-plugin-complete &> /dev/null
#TODO: enable plugins through settings, make them work (album cover art navigation specially)
#
#echo "[Installing Tomahawk (music player)]"
#sudo apt-get install -y -q tomahawk &> /dev/null
#
#echo "[Installing Lollypop (music player]"
#sudo add-apt-repository -y ppa:gnumdk/lollypop &> /dev/null
#sudo apt-get update -y -q &> /dev/null
#sudo apt-get install -y -q lollypop &> /dev/null
#
#TODO: Install music player that allows navigating through artists / albums covers.
#      Allows getting cover arts in bulk, and stores them into audio files. Also that can synchronize
#      with external devices and that can integrate with spotify, get lyrics, information.
#
#echo "[Installing VLC Media Player]"  #Alternative to Ubuntu GNOME's "Totem" app
#sudo apt-get install -y -q vlc &> /dev/null
#
#echo "[Installing Kodi Media Center]"
#sudo apt-get install -y -q kodi &> /dev/null
#TODO: find prepackaged configuration files
#
#echo "[Installing GitKraken (GIT client)]"
#wget -q https://release.gitkraken.com/linux/gitkraken-amd64.deb
#sudo dpkg -i gitkraken-amd64.deb &> /dev/null
#\rm -rf gitkraken-amd64.deb
#
#TODO: Changes displays scale factor (code below does not work)
#export scales=$(dconf read /com/ubuntu/user-interface/scale-factor)
#newscales=$(python <<EOF
#import ast
#import os
#d = ast.literal_eval(str(os.getenv('scales')))
#d={k:7 for k,v in d.items()}
#print d
#EOF
#)
#echo $newscales
#dconf write /com/ubuntu/user-interface/scale-factor "$newscales"
