#!/bin/sh
echo 'Enable MultiLib' && 
echo '[multilib]' >> /etc/pacman.conf && 
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf && 
pacman -Sy && 
pacman -Sy archlinux-keyring && 
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
pacman -Sy archlinux-keyring && 
pacstrap /mnt base linux linux-firmware intel-ucode btrfs-progs net-tools networkmanager dhcpcd iwd vim man-pages man-db texinfo base-devel intel-ucode && 
echo 'Installing Linux Framework' && 
pacstrap /mnt gstreamer systemd ntp gst-libav gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad xed xreader vlc pulseaudio archlinux-wallpaper qt6 udev dbus cpupower && 
echo 'Installing Desktop Environment' && 
pacstrap /mnt sudo nano gtk4 cinnamon gdm gnome-terminal gedit gnome-system-monitor gnome-keyring cinnamon-translations && 
echo 'Creating Links' && 
genfstab -U /mnt >> /mnt/etc/fstab && 
arch-chroot /mnt echo 'Setting Locale' && 
arch-chroot /mnt ln -sf ../usr/share/zoneinfo/America/Los_Angeles /etc/localtime && 
arch-chroot /mnt hwclock --systohc && 
arch-chroot /mnt echo 'en_US ISO-8859-1' >> /etc/locale.gen && 
arch-chroot /mnt echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && 
arch-chroot /mnt echo 'KEYMAP=us' > /etc/vconsole.conf && 
arch-chroot /mnt echo 'LANG=en_US.UTF-8' > /etc/locale.conf && 
arch-chroot /mnt export LANG=en_US.UTF-8 && 
arch-chroot /mnt locale-gen &&  
arch-chroot /mnt echo 'Setting Hostname' && 
arch-chroot /mnt echo 'Linux-Mint-PC' > /etc/hostname && 
arch-chroot /mnt echo '127.0.0.1 localhost' >> /etc/hosts && 
arch-chroot /mnt echo '::1 localhost' >> /etc/hosts && 
arch-chroot /mnt echo '127.0.1.1 Linux-Mint-PC' >> /etc/hosts && 
arch-chroot /mnt echo '[multilib]' >> /etc/pacman.conf && 
arch-chroot /mnt echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf && 
arch-chroot /mnt pacman -Syy && 
arch-chroot /mnt echo 'Set Root Password' && 
arch-chroot /mnt passwd && 
arch-chroot /mnt echo 'Adding User Account' && 
arch-chroot /mnt useradd -m -b /home -G wheel,audio,video,power,users,storage -s /bin/bash user01 && 
arch-chroot /mnt echo 'Set User Password' && 
arch-chroot /mnt passwd user01 && 
arch-chroot /mnt echo '%wheel ALL=(ALL:ALL) ALL' > /etc/sudoers.d/wheel &&
arch-chroot /mnt mkinitcpio -P && 
arch-chroot /mnt echo Installing Bootloader && 
arch-chroot /mnt bootctl install && 
arch-chroot /mnt echo 'default arch.conf' > /boot/loader/loader.conf && 
arch-chroot /mnt echo 'timeout 5' >> /boot/loader/loader.conf && 
arch-chroot /mnt echo 'console-mode max' >> /boot/loader/loader.conf && 
arch-chroot /mnt echo 'editor no' >> /boot/loader/loader.conf && 
arch-chroot /mnt echo 'title Linux Mint "Alpine"' > /boot/loader/entries/arch.conf && 
arch-chroot /mnt echo 'linux /vmlinuz-linux' >> /boot/loader/entries/arch.conf && 
arch-chroot /mnt echo 'initrd /intel-ucode.img' >> /boot/loader/entries/arch.conf && 
arch-chroot /mnt echo 'initrd /initramfs-linux.img' >> /boot/loader/entries/arch.conf && 
arch-chroot /mnt echo 'options root="LABEL=LocalDisk" rw nvidia-drm.modeset=1' >> /boot/loader/entries/arch.conf && 
arch-chroot /mnt echo 'Installing Drivers and dependencies' && 
arch-chroot /mnt pacman -Sy archlinux-keyring &&
arch-chroot /mnt pacman -Sy xorg xorg-server xorg-apps virtualbox-guest-utils xf86-video-vmware nvidia nvidia-utils nvidia-settings git xdg-utils gettext ufw libva-utils libva-vdpau-driver neofetch wine winetricks lib32-gamemode lib32-vkd3d vkd3d innoextract giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox jre-openjdk-headless jre-openjdk jdk-openjdk openjdk-doc openjdk-src chromium steam-native-runtime gamemode gamescope wine-mono wine-gecko lib32-opencl-nvidia zenity lutris discord steam gnome-menus polkit-gnome gst-plugin-pipewire lib32-pipewire lib32-pipewire-jack pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber firewalld shotwell virtualbox gimp blender cura ark barrier gnome-calculator gnome-characters file-roller gnome-firmware font-manager gnome-font-viewer fragments gnome-tweaks gvim yelp gnome-logs alacarte gnome-maps gnome-nettool nextcloud-client nitrogen notepadqq gnome-notes owncloud-client seahorse peek piper gnome-recipes redshift gnome-screenshot solaar warpinator gnome-weather gnome-contacts geary gnome-dictionary gnome-latex libreoffice-fresh links evince gnome-books tellico audacity blanket brasero clementine easyeffects easytag elisa gnac gnome-mplayer gmtp gnome-subtitles helvum gnome-music gnome-podcasts sound-juicer gnome-sound-recorder akregator cozy-desktop electrum etherwall gfeeds hexchat transmission-gtk aisleriot atomix chromium-bsu dolphin-emu endless-sky fceux five-or-more four-in-a-row gnome-games gnome-chess hitori gnome-klotski gnome-mahjongg gnome-mines gnome-nibbles iagno gnome-robots persepolis pidgin qopenvpn remmina gnome-sudoku gnome-taquin gnome-tetravex granatier hatari hedgewars kajongg kanagram kapman katomic kblackbox kblocks kbounce kbreakout kdiamond khangman kigo kiriki klickety knetwalk kolf kollision klines konquest kubrick lightsoff lincity-ng lbreakout2 ltris mame minetest pcsx2 pychess pysolfc retroarch snes9x-gtk supertux supertuxkart swell-foop tali xonotic celluloid cheese ciano gcolor3 darktable digikam simple-scan freecad goxel gthumb handbrake eog mypaint okular pencil2d gnome-photos pinta qtqr totem accerciser arduino bless bluefish gnome-boxes gnome-builder cmake code devhelp d-feet pcb geany ghex glade godot lokalize meld telegram-desktop && 
arch-chroot /mnt archlinux-java set java-18-openjdk  &&  
arch-chroot /mnt systemctl enable gdm && 
arch-chroot /mnt systemctl enable dhcpcd && 
arch-chroot /mnt systemctl enable NetworkManager && 
arch-chroot /mnt systemctl --global enable pipewire.service pipewire-pulse.service wireplumber.service && 
arch-chroot /mnt systemctl enable firewalld && 
arch-chroot /mnt echo 'Ensuring Home Directory is intact' && 
arch-chroot /mnt pacman -Sy xdg-user-dirs &&   
arch-chroot /mnt xdg-user-dirs-update && 
arch-chroot /mnt echo 'Attempting to install Linux Mint Flavor/s automatically now...' && 
arch-chroot /mnt git clone https://aur.archlinux.org/yay.git && 
arch-chroot /mnt sudo -u user01 chown -R user01:users ./yay && 
arch-chroot /mnt sudo -u user01 id user01 && 
arch-chroot /mnt cd yay && 
arch-chroot /mnt sudo -u user01 makepkg -si && 
arch-chroot /mnt cd && 
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
echo 'Cleaning up' && 
mkdir /mnt/VAAPI-Chrome && 
cp arch-linux-installer/chrome-flags.conf /mnt/VAAPI-Chrome/chrome-flags.conf && 
chmod a+x /mnt/VAAPI-Chrome/chrome-flags.conf && 
cp arch-linux-installer/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop /mnt/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop && 
chmod a+x /mnt/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop && 
umount -R /mnt && 
reboot
