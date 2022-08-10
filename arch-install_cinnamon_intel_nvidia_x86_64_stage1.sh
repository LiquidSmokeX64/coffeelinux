#Phase 1
echo 'Enable Repos' && 
nano /etc/pacman.conf && 
pacman -Sy && 
pacman -Sy --noconfirm archlinux-keyring && 
echo 'Partition the Disk' && 

fdisk /dev/nvme1n1 && 
echo 'Formatting Partitions' && 
mkfs.fat -F32 /dev/nvme1n1p1 && 
#mkfs.fat -F32 /dev/nvme1n1p2 && 
#mkfs.fat -F32 /dev/nvme1n1p3 && 
mkswap /dev/nvme1n1p2 && 
mkfs.btrfs -L LocalDisk /dev/nvme1n1p3 && 
echo 'Mounting Disks' && 
swapon /dev/nvme1n1p2 && 
mount /dev/nvme1n1p3 /mnt && 
mkdir /mnt/boot && 
#mkdir /mnt/efi &&
mount /dev/nvme1n1p1 /mnt/boot && 
#mount /dev/nvme1n1p2 /mnt/efi && 
echo 'Installing Kernel Frameworks' && 
pacman -Syy && 
pacman -Sy --noconfirm archlinux-keyring && 
pacstrap /mnt base linux linux-firmware intel-ucode btrfs-progs net-tools networkmanager dhcpcd iwd vim man-pages man-db texinfo base-devel intel-ucode && 
#echo 'Installing Gnome' && 
#pacstrap /mnt sudo nano gnome-menus polkit-gnome gnome gdm gtk4 gnome-text-editor qt6 gnome-extra dkms gnome-terminal gedit gnome-system-monitor gnome-keyring && 
echo 'Installing Cinnamon'
pacstrap /mnt cinnamon lightdm gnome-terminal cinnamon-translations lightdm-gtk-greeter lightdm-slick-greeter gedit gnome-system-monitor xed xreader vlc gnome-keyring cinnamon-translations pulseaudio archlinux-wallpaper qt6 gtk4 udev dbus && 
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
cp /etc/pacman.conf /mnt/etc/pacman.conf && 
cp --dereference /etc/resolv.conf /mnt/etc/
arch-chroot /mnt pacman -Syy && 
arch-chroot /mnt pacman -Sy gstreamer systemd ntp gst-libav gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad xed xreader vlc pulseaudio archlinux-wallpaper udev dbus && 
arch-chroot /mnt pacman -Sy power-profiles-daemon cpupower go meson xorg xorg-server xorg-apps virtualbox-guest-utils xf86-video-vmware nvidia nvidia-utils nvidia-settings git xdg-utils gettext ufw libva-utils libva-vdpau-driver neofetch wine winetricks lib32-gamemode lib32-vkd3d vkd3d innoextract giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox jre-openjdk-headless jre-openjdk jdk-openjdk openjdk-doc openjdk-src chromium steam-native-runtime gamemode gamescope wine-mono wine-gecko lib32-opencl-nvidia zenity lutris discord steam gnome-menus polkit-gnome gst-plugin-pipewire lib32-pipewire lib32-pipewire-jack pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber firewalld shotwell virtualbox gimp blender cura gnome-calculator gnome-characters file-roller gnome-firmware font-manager gnome-font-viewer fragments gnome-tweaks gvim yelp gnome-logs alacarte gnome-maps gnome-nettool gnome-notes gnome-recipes gnome-screenshot gnome-weather gnome-contacts geary gnome-dictionary gnome-latex libreoffice-fresh gnome-music gnome-podcasts gnome-sound-recorder hexchat transmission-gtk five-or-more four-in-a-row gnome-games gnome-chess gnome-klotski gnome-mahjongg gnome-mines gnome-nibbles gnome-robots gnome-sudoku gnome-taquin gnome-tetravex cheese gnome-photos accerciser gnome-boxes gnome-builder && 
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
arch-chroot /mnt pacman -Sy --noconfirm xdg-user-dirs &&
echo 'Installing any extra Desktop Environments' &&

#arch-chroot /mnt /bin/bash <<"EOT"
#ls -l &&
#pacman -Sy flatpak snapd && 
#pacman -Sy lxsession qt5 plasma-integration plasma-browser-integration kwin kmix knewstuff kitemmodels kcmutils kidletime qt5-graphicaleffects appstream-qt archlinux-appstream-data hicolor-icon-theme kirigami2 discount kuserfeedback powerdevil plasma-wayland-session plasma plasma-meta vlc ntp archlinux-wallpaper kde-applications sddm sddm-kcm kdeplasma-addons phonon-qt5-vlc packagekit-qt5 flatpak fwupd && 
#pacman -Sy lxde mousepad vlc lxde-common archlinux-wallpaper ntp lxsession openbox mousepad lxdm lxpanel xcompmgr && 
#pacman -Sy sddm xscreensaver xautolock lxqt ntp lximage-qt lxqt-about lxqt-admin lxqt-archiver lxqt-config lxqt-globalkeys lxqt-notificationd lxqt-openssh-askpass lxqt-panel lxqt-policykit lxqt-powermanagement lxqt-qtplugin lxqt-runner lxqt-session archlinux-wallpaper vlc lxqt-sudo lxqt-themes obconf-qt pavucontrol-qt pcmanfm-qt qterminal screengrab pulseaudio breeze-icons oxygen-icons cups alsa-lib giflib libjpeg libpng xdg-utils mousepad && 
#pacman -Sy mate mate-extra ttf-freefont lightdm lightdm-gtk-greeter gnome-terminal gnome-system-monitor vlc eom atril engrampa mate-applet-dock && 
#pacman -Sy xfce4 mousepad parole ristretto thunar-archive-plugin thunar-media-tags-plugin xfce4-battery-plugin xfce4-datetime-plugin xfce4-mount-plugin xfce4-netload-plugin xfce4-notifyd xfce4-pulseaudio-plugin xfce4-screensaver xfce4-taskmanager xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-xkb-plugin file-roller network-manager-applet ntp leafpad epdfview vlc galculator lightdm xfwm4-themes xfce4-settings lightdm-gtk-greeter lightdm-gtk-greeter-settings capitaine-cursors arc-gtk-theme xdg-user-dirs-gtk xfce4-goodies virtualbox-guest-utils xf86-video-vmware pavucontrol pulseaudio archlinux-wallpaper xfwm4 && xfconf-query -c xfwm4 -p /general/use_compositing -s true && 
#pacman -Sy ttf-freefont lightdm lightdm-deepin-greeter vlc ntp deepin deepin-extra archlinux-wallpaper deepin-anything-arch pulseaudio mousepad &&
#echo $$
#EOT
echo 'Installing yay for AUR support' && 
arch-chroot /mnt /bin/bash <<"EOT"
mkdir -p /tmp/arch/stage2 &&
cd /tmp/arch/stage2 &&
ls -l && 
cd /opt &&
sudo -u user01 sudo git clone https://aur.archlinux.org/yay.git && 
sudo -u user01 xdg-user-dirs-update &&
sudo -u user01 sudo chown -R user01:users ./yay && 
sudo -u user01 id user01 && 
cd /opt/yay &&
sudo -u user01 makepkg -f -s --install --noconfirm --clean &&  
echo $$
EOT


echo 'Installing Arch-QOL-Extras' && 
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
arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y xboxdrv && 
#arch-chroot /mnt sudo -u user01 yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y systemd-kcm &&

echo 'Ensuring correct DM is set.' && 
arch-chroot /mnt pacman -Sy lightdm gtk3 && 
arch-chroot /mnt pacman -Sy lightdm-gtk-greeter && 
arch-chroot /mnt pacman -Syu && 
arch-chroot /mnt systemctl disable --now gdm && 
arch-chroot /mnt systemctl enable lightdm && 
#arch-chroot /mnt systemctl enable gdm &&
#arch-chroot /mnt systemctl enable sddm &&
#arch-chroot /mnt systemctl enable openbox &&  

#Phase 5
echo 'Cleaning up' && 
mkdir /mnt/VAAPI-Chrome && 
cp arch-linux-installer/chrome-flags.conf /mnt/VAAPI-Chrome/chrome-flags.conf && 
chmod a+x /mnt/VAAPI-Chrome/chrome-flags.conf && 
cp arch-linux-installer/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop /mnt/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop &&  
chmod a+x /mnt/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop && 
umount -R /mnt && 
reboot
