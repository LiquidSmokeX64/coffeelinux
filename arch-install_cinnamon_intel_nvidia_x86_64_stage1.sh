#!/bin/sh

#Phase 1
echo 'Enable MultiLib' && 
echo '[multilib]' >> /etc/pacman.conf && 
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf && 
pacman -Sy && 
pacman -Sy --noconfirm archlinux-keyring && 
echo 'Partition the Disk' && 
fdisk /dev/nvme1n1 && 
echo 'Formatting Partitions' && 
mkfs.fat -F32 /dev/nvme1n1p1 && #!/bin/sh
#Phase 1
echo 'Enable MultiLib' && 
echo '[multilib]' >> /etc/pacman.conf && 
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf && 
pacman -Sy && 
pacman -Sy --noconfirm archlinux-keyring && 
echo 'Partition the Disk' && 
fdisk /dev/nvme1n1 && 
echo 'Formatting Partitions' && 
mkfs.fat -F32 /dev/nvme1n1p1 && 
mkswap /dev/nvme1n1p2 && 
mkfs.btrfs -L LocalDisk /dev/nvme1n1p3 && 
echo 'Mounting Disks' && 
swapon /dev/nvme1n1p2 && 
mount /dev/nvme1n1p3 /mnt && 
mkdir /mnt/boot && 
mount /dev/nvme1n1p1 /mnt/boot && 
echo 'Installing Kernel Frameworks' && 
pacman -Syy && 
pacman -Sy --noconfirm archlinux-keyring && 
pacstrap /mnt base linux linux-firmware intel-ucode btrfs-progs net-tools networkmanager dhcpcd iwd vim man-pages man-db texinfo base-devel intel-ucode && 
echo 'Creating Links' && 
genfstab -U /mnt >> /mnt/etc/fstab &&
echo 'Set Root Password' && 
arch-chroot /mnt passwd && 
echo 'Adding User Account' && 
arch-chroot /mnt useradd -m -G wheel,audio,video,power,users,storage user01 && 
echo 'Set User Password' && 
arch-chroot /mnt passwd user01 && 

#Phase 2
arch-chroot /mnt pacman -Syy &&
arch-chroot /mnt pacman -Sy --noconfirm archlinux-keyring &&
arch-chroot /mnt echo '[multilib]' >> /mnt/etc/pacman.conf && 
arch-chroot /mnt echo 'Include = /etc/pacman.d/mirrorlist' >> /mnt/etc/pacman.conf && 
arch-chroot /mnt pacman -Syy && 
arch-chroot /mnt pacman -Sy gstreamer systemd ntp gst-libav gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad xed xreader vlc pulseaudio archlinux-wallpaper qt6 udev dbus cpupower &&
arch-chroot /mnt pacman -Sy sudo nano gtk4 cinnamon gdm gnome-terminal gedit gnome-system-monitor gnome-keyring cinnamon-translations &&
arch-chroot /mnt pacman -Sy go meson xorg xorg-server xorg-apps virtualbox-guest-utils xf86-video-vmware nvidia nvidia-utils nvidia-settings git xdg-utils gettext ufw libva-utils libva-vdpau-driver neofetch wine winetricks lib32-gamemode lib32-vkd3d vkd3d innoextract giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox jre-openjdk-headless jre-openjdk jdk-openjdk openjdk-doc openjdk-src chromium steam-native-runtime gamemode gamescope wine-mono wine-gecko lib32-opencl-nvidia zenity lutris discord steam gnome-menus polkit-gnome gst-plugin-pipewire lib32-pipewire lib32-pipewire-jack pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber firewalld shotwell virtualbox gimp blender cura ark barrier gnome-calculator gnome-characters file-roller gnome-firmware font-manager gnome-font-viewer fragments gnome-tweaks gvim yelp gnome-logs alacarte gnome-maps gnome-nettool nextcloud-client nitrogen notepadqq gnome-notes owncloud-client seahorse peek piper gnome-recipes redshift gnome-screenshot solaar warpinator gnome-weather gnome-contacts geary gnome-dictionary gnome-latex libreoffice-fresh links evince gnome-books tellico audacity blanket brasero clementine easyeffects easytag elisa gnac gnome-mplayer gmtp gnome-subtitles helvum gnome-music gnome-podcasts sound-juicer gnome-sound-recorder akregator cozy-desktop electrum etherwall gfeeds hexchat transmission-gtk aisleriot atomix chromium-bsu dolphin-emu endless-sky fceux five-or-more four-in-a-row gnome-games gnome-chess hitori gnome-klotski gnome-mahjongg gnome-mines gnome-nibbles iagno gnome-robots persepolis pidgin qopenvpn remmina gnome-sudoku gnome-taquin gnome-tetravex granatier hatari hedgewars kajongg kanagram kapman katomic kblackbox kblocks kbounce kbreakout kdiamond khangman kigo kiriki klickety knetwalk kolf kollision klines konquest kubrick lightsoff lincity-ng lbreakout2 ltris mame minetest pcsx2 pychess pysolfc retroarch snes9x-gtk supertux supertuxkart swell-foop tali xonotic celluloid cheese ciano gcolor3 darktable digikam simple-scan freecad goxel gthumb handbrake eog mypaint okular pencil2d gnome-photos pinta qtqr totem accerciser arduino bless bluefish gnome-boxes gnome-builder cmake code devhelp d-feet pcb geany ghex glade godot lokalize meld telegram-desktop && 
arch-chroot /mnt archlinux-java set java-18-openjdk  &&

#Phase 3
arch-chroot /mnt /bin/bash <<"EOT"
mkdir -p /tmp/arch &&
cd /tmp/arch &&
ls -l && 
cd / &&  
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
echo 'options root="LABEL=LocalDisk" rw nvidia-drm.modeset=1' >> /boot/loader/entries/arch.conf &&   
systemctl enable gdm && 
systemctl enable dhcpcd && 
systemctl enable NetworkManager && 
systemctl --global enable pipewire.service pipewire-pulse.service wireplumber.service && 
systemctl enable firewalld && 
echo $$
EOT

#Phase 4
echo 'Attempting to install Linux Mint Flavor/s automatically now...' && 
arch-chroot /mnt pacman -Sy xdg-user-dirs &&

arch-chroot /mnt /bin/bash <<"EOT"
mkdir -p /tmp/arch/stage2 &&
cd /tmp/arch/stage2 &&
ls -l && 
cd /opt &&
sudo -u user01 sudo git clone https://aur.archlinux.org/yay.git && 
sudo -u user01 xdg-user-dirs-update &&
sudo -u user01 sudo chown -R user01:users ./yay && 
sudo -u user01 id user01 && 
cd yay &&
sudo -u user01 makepkg -f -s --install --noconfirm --clean &&  
echo $$
EOT

arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y pamac-aur && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y libva-vdpau-driver-vp9-git && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y protontricks && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y nvidia-vaapi-driver && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y cpupower-gui && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-themes && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-x-icons && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-y-icons && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-backgrounds && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y game-devices-udev && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mintlocale && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-artwork && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-artwork-cinnamon && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y linuxmint-keyring && 
arch-chroot /mnt sudo -u user01 yay --answerclean y  --answerdiff y --answeredit y --answerupgrade y --nodiffmenu --noremovemake gnome-calendar-linuxmint && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y gnome-browser-connector && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y xboxdrv && 

#Phase 5
echo 'Cleaning up' && 
mkdir /mnt/VAAPI-Chrome && 
cp arch-linux-installer/chrome-flags.conf /mnt/VAAPI-Chrome/chrome-flags.conf && 
chmod a+x /mnt/VAAPI-Chrome/chrome-flags.conf && 
cp arch-linux-installer/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop /mnt/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop &&  
chmod a+x /mnt/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop && 
umount -R /mnt && 
reboot
mkswap /dev/nvme1n1p2 && 
mkfs.btrfs -L LocalDisk /dev/nvme1n1p3 && 
echo 'Mounting Disks' && 
swapon /dev/nvme1n1p2 && 
mount /dev/nvme1n1p3 /mnt && 
mkdir /mnt/boot && 
mount /dev/nvme1n1p1 /mnt/boot && 
echo 'Installing Kernel Frameworks' && 
pacman -Syy && 
pacman -Sy --noconfirm archlinux-keyring && 
pacstrap /mnt base linux linux-firmware intel-ucode btrfs-progs net-tools networkmanager dhcpcd iwd vim man-pages man-db texinfo base-devel intel-ucode && 
echo 'Creating Links' && 
genfstab -U /mnt >> /mnt/etc/fstab &&
echo 'Set Root Password' && 
arch-chroot /mnt passwd && 
echo 'Adding User Account' && 
arch-chroot /mnt useradd -m -G wheel,audio,video,power,users,storage user01 && 
echo 'Set User Password' && 
arch-chroot /mnt passwd user01 && 

#Phase 2
arch-chroot /mnt pacman -Syy &&
arch-chroot /mnt pacman -Sy --noconfirm archlinux-keyring &&
arch-chroot /mnt echo '[multilib]' >> /mnt/etc/pacman.conf && 
arch-chroot /mnt echo 'Include = /etc/pacman.d/mirrorlist' >> /mnt/etc/pacman.conf && 
arch-chroot /mnt pacman -Syy && 
arch-chroot /mnt pacman -Sy gstreamer systemd ntp gst-libav gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad xed xreader vlc pulseaudio archlinux-wallpaper udev dbus &&
arch-chroot /mnt pacman -Sy sudo nano gtk lightdm cinnamon gnome-terminal gedit gnome-system-monitor gnome-keyring cinnamon-translations &&
arch-chroot /mnt pacman -Sy go meson xorg xorg-server xorg-apps virtualbox-guest-utils xf86-video-vmware nvidia nvidia-utils nvidia-settings git xdg-utils gettext ufw libva-utils libva-vdpau-driver neofetch wine winetricks lib32-gamemode lib32-vkd3d vkd3d innoextract giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox jre-openjdk-headless jre-openjdk jdk-openjdk openjdk-doc openjdk-src chromium steam-native-runtime gamemode gamescope wine-mono wine-gecko lib32-opencl-nvidia zenity lutris discord steam gnome-menus polkit-gnome gst-plugin-pipewire lib32-pipewire lib32-pipewire-jack pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber firewalld shotwell virtualbox gimp blender cura ark barrier gnome-calculator gnome-characters file-roller gnome-firmware font-manager gnome-font-viewer fragments gnome-tweaks gvim yelp gnome-logs alacarte gnome-maps gnome-nettool nextcloud-client nitrogen notepadqq gnome-notes owncloud-client seahorse peek piper gnome-recipes redshift gnome-screenshot solaar warpinator gnome-weather gnome-contacts geary gnome-dictionary gnome-latex libreoffice-fresh links evince gnome-books tellico audacity blanket brasero clementine easyeffects easytag elisa gnac gnome-mplayer gmtp gnome-subtitles helvum gnome-music gnome-podcasts sound-juicer gnome-sound-recorder akregator cozy-desktop electrum etherwall gfeeds hexchat transmission-gtk aisleriot atomix chromium-bsu dolphin-emu endless-sky fceux five-or-more four-in-a-row gnome-games gnome-chess hitori gnome-klotski gnome-mahjongg gnome-mines gnome-nibbles iagno gnome-robots persepolis pidgin qopenvpn remmina gnome-sudoku gnome-taquin gnome-tetravex granatier hatari hedgewars kajongg kanagram kapman katomic kblackbox kblocks kbounce kbreakout kdiamond khangman kigo kiriki klickety knetwalk kolf kollision klines konquest kubrick lightsoff lincity-ng lbreakout2 ltris mame minetest pcsx2 pychess pysolfc retroarch snes9x-gtk supertux supertuxkart swell-foop tali xonotic celluloid cheese ciano gcolor3 darktable digikam simple-scan freecad goxel gthumb handbrake eog mypaint okular pencil2d gnome-photos pinta qtqr totem accerciser arduino bless bluefish gnome-boxes gnome-builder cmake code devhelp d-feet pcb geany ghex glade godot lokalize meld telegram-desktop && 
arch-chroot /mnt archlinux-java set java-18-openjdk  &&

#Phase 3
arch-chroot /mnt /bin/bash <<"EOT"
mkdir -p /tmp/arch &&
cd /tmp/arch &&
ls -l && 
cd / &&  
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
echo 'options root="LABEL=LocalDisk" rw nvidia-drm.modeset=1' >> /boot/loader/entries/arch.conf &&   
systemctl enable lightdm && 
systemctl enable dhcpcd && 
systemctl enable NetworkManager && 
systemctl --global enable pipewire.service pipewire-pulse.service wireplumber.service && 
systemctl enable firewalld && 
echo $$
EOT

#Phase 4
echo 'Attempting to install Linux Mint Flavor/s automatically now...' && 
arch-chroot /mnt pacman -Sy xdg-user-dirs &&

arch-chroot /mnt /bin/bash <<"EOT"
mkdir -p /tmp/arch/stage2 &&
cd /tmp/arch/stage2 &&
ls -l && 
cd /opt &&
sudo -u user01 sudo git clone https://aur.archlinux.org/yay.git && 
sudo -u user01 xdg-user-dirs-update &&
sudo -u user01 sudo chown -R user01:users ./yay && 
sudo -u user01 id user01 && 
cd yay &&
sudo -u user01 makepkg -f -s --install --noconfirm --clean &&  
echo $$
EOT

arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y pamac-aur &&  
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y protontricks &&  
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-themes && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-x-icons && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-y-icons && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-backgrounds && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y game-devices-udev && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mintlocale && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-artwork && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-artwork-cinnamon && 
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y linuxmint-keyring && 
arch-chroot /mnt sudo -u user01 yay --answerclean y  --answerdiff y --answeredit y --answerupgrade y --nodiffmenu --noremovemake gnome-calendar-linuxmint && 

#Phase 5
echo 'Cleaning up' && 
mkdir /mnt/VAAPI-Chrome && 
cp arch-linux-installer/chrome-flags.conf /mnt/VAAPI-Chrome/chrome-flags.conf && 
chmod a+x /mnt/VAAPI-Chrome/chrome-flags.conf && 
cp arch-linux-installer/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop /mnt/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop &&  
chmod a+x /mnt/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop && 
umount -R /mnt && 
reboot
