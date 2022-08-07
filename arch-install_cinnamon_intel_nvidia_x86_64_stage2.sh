#!/bin/sh
echo 'Setting Locale' && 
ln -sf ../usr/share/zoneinfo/America/Los_Angeles /etc/localtime && 
hwclock --systohc && 
echo 'en_US ISO-8859-1' >> /etc/locale.gen && 
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && 
echo 'KEYMAP=us' > /etc/vconsole.conf && 
echo 'LANG=en_US.UTF-8' > /etc/locale.conf && 
export LANG=en_US.UTF-8 && 
locale-gen &&  
echo 'Setting Hostname' && 
echo 'Linux-Mint-PC' > /etc/hostname && 
echo '127.0.0.1 localhost' >> /etc/hosts && 
echo '::1 localhost' >> /etc/hosts && 
echo '127.0.1.1 Linux-Mint-PC' >> /etc/hosts && 
echo '[multilib] >> /etc/pacman.conf' && 
echo 'Include = /etc/pacman.d/mirrorlist >> /etc/pacman.conf' && 
pacman -Syy && 
echo 'Set Root Password' && 
passwd && 
echo 'Adding User Account' && 
useradd -m -b /home -G wheel,audio,video,power,users,storage -s /bin/bash user01 && 
echo 'Set User Password' && 
passwd user01 && 
echo '%wheel ALL=(ALL:ALL) ALL' > /etc/sudoers.d/wheel &&
mkinitcpio -P && 
echo Installing Bootloader && 
bootctl install && 
echo 'default arch.conf' > /boot/loader/loader.conf && 
echo 'timeout 5' >> /boot/loader/loader.conf && 
echo 'console-mode max' >> /boot/loader/loader.conf && 
echo 'editor no' >> /boot/loader/loader.conf && 
echo 'title Linux Mint "Alpine"' > /boot/loader/entries/arch.conf && 
echo 'linux /vmlinuz-linux' >> /boot/loader/entries/arch.conf && 
echo 'initrd /intel-ucode.img' >> /boot/loader/entries/arch.conf && 
echo 'initrd /initramfs-linux.img' >> /boot/loader/entries/arch.conf && 
echo 'options root="LABEL=LocalDisk"' rw nvidia-drm.modeset=1 >> /boot/loader/entries/arch.conf && 
echo 'Installing Drivers and dependencies' && 
pacman -Sy archlinux-keyring &&
pacman -Sy xorg xorg-server xorg-apps virtualbox-guest-utils xf86-video-vmware nvidia nvidia-utils nvidia-settings git xdg-utils gettext ufw libva-utils libva-vdpau-driver neofetch wine winetricks lib32-gamemode lib32-vkd3d vkd3d innoextract giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox jre-openjdk-headless jre-openjdk jdk-openjdk openjdk-doc openjdk-src chromium steam-native-runtime gamemode gamescope wine-mono wine-gecko lib32-opencl-nvidia zenity lutris discord steam gnome-menus polkit-gnome gst-plugin-pipewire lib32-pipewire lib32-pipewire-jack pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber firewalld && 
echo 'Installing the "Alpine" Experience Pack' &&
pacman -Sy shotwell virtualbox gimp blender cura ark barrier gnome-calculator gnome-characters file-roller gnome-firmware font-manager gnome-font-viewer fragments gnome-tweaks gvim yelp gnome-logs alacarte gnome-maps gnome-nettool nextcloud-client nfoviewer nitrogen notepadqq gnome-notes owncloud-clent seahorse peek piper gnome-recipes redshift gnome-screenshot solaar warpinator gnome-weather gnome-contacts geary gnome-dictionary gnome-latex libreoffice-fresh links evince gnome-books tellico audacity blanket brasero clementine easyeffects easytag elisa gnac gnome-mplayer gmtp gnome-subtitles helvum gnome-music gnome-podcasts rythembox sound-juicer gnome-sound-recorder akregator cozy-desktop electrum etherwall gfeeds hexchat transmission-gtk aisleriot atomix chrommium-bsu dolphin-emu endless-sky fceux five-or-more four-in-a-row gnome-games gnome-chess hitori gnome-klotski gnome-mahjongg gnome-mines gnome-nibbles iagno gnome-robots persepolis pidgin qopenvpn remmina gnome-sudoku gnome taquin gnome-tetravex granatier hatari hedgewars kajongg kanagram kapman katomic kblackbox kblocks kbounce kbreakout kdiamond kangman kigo kiriki klickety knetwalk kolf kolision klines konquest kubrick lightsoff lincity-ng lbreakout2 ltris mame minetest pcsx2 pychess pysolfc retroarch snes9x-gtk supertux supertuxkart swell-foop tali xonotic celluloid cheese ciano gcolor3 darktable digikam simple-scan freecad goxel gthumb handbrake eog mypaint okular pencil2d gnome-photos pinta qtqr totem accerciser arduino bless bluefish gnome-boxes gnome-builder cmake code devhelp d-feet pcb geany ghex glade godot lokalize meld tetegram-desktop && 
archlinux-java set java-18-openjdk  && 
echo 'Setting default systemd services' && 
systemctl enable gdm && 
systemctl enable dhcpcd && 
systemctl enable NetworkManager && 
systemctl --global enable pipewire.service pipewire-pulse.service wireplumber.service && 
systemctl enable firewalld && 
echo 'Ensuring Home Directory is intact' && 
pacman -Sy xdg-user-dirs &&   
xdg-user-dirs-update && 
echo 'Attempting to install Linux Mint Flavor/s automatically now...' && 
sudo -u user01 git clone https://aur.archlinux.org/yay.git && 
sudo -u user01 chown -R user01:users ./yay && 
sudo -u user01 id user01 && 
sudo -u user01 cd yay && 
sudo -u user01 makepkg -si && 
cd && 
sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y pamac-aur && 
sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y libva-vdpau-driver-vp9-git && 
sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y protontricks && 
sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y nvidia-vaapi-driver && 
sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y cpupower-gui && 
sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-themes && 
sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-x-icons && 
sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-y-icons && 
sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-backgrounds && 
sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y game-devices-udev && 
sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mintlocale && 
sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-artwork && 
sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-artwork-cinnamon 
&& 
sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y linuxmint-keyring 
&& 
sudo -u user01 yay --answerclean y  --answerdiff y --answeredit y --answerupgrade y --nodiffmenu --noremovemake gnome-calendar-linuxmint && 
sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y gnome-browser-connector && 
sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y xboxdrv &&  
echo 'Please type exit and run the next script'
