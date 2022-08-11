#!/bin/sh

user01=archuser
yayflags= --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y
boot=/dev/nvme1n1p1
swap=/dev/nvme1n1p2
os=/dev/nvme1n1p3
drive=/dev/nvme1n1
pacman=pacman -Syy
pacstrap=pacstrap $rootdir
rootdir=/mnt
bootdir=/boot
pacmandir=/etc/pacman.conf
chroot=arch-chroot $rootdir
usershell=sudo -u $user01
serviceon=systemctl enable
serviceoff=systemctl disable
gnomede=sudo nano gnome-menus polkit-gnome gnome gdm gtk4 gnome-text-editor qt6 gnome-extra dkms gnome-terminal gedit gnome-system-monitor gnome-keyring 
cinnamonde=sudo nano cinnamon lightdm gnome-terminal cinnamon-translations lightdm-gtk-greeter lightdm-gtk-greeter-settings gedit gnome-system-monitor xed xreader vlc gnome-keyring cinnamon-translations pulseaudio archlinux-wallpaper qt6 gtk4 udev dbus
lxqtde=sddm xscreensaver xautolock lxqt ntp lximage-qt lxqt-about lxqt-admin lxqt-archiver lxqt-config lxqt-globalkeys lxqt-notificationd lxqt-openssh-askpass lxqt-panel lxqt-policykit lxqt-powermanagement lxqt-qtplugin lxqt-runner lxqt-session archlinux-wallpaper vlc lxqt-sudo lxqt-themes obconf-qt pavucontrol-qt pcmanfm-qt qterminal screengrab pulseaudio breeze-icons oxygen-icons cups alsa-lib giflib libjpeg libpng xdg-utils mousepad
xfcede=xfce4 mousepad parole ristretto thunar-archive-plugin thunar-media-tags-plugin xfce4-battery-plugin xfce4-datetime-plugin xfce4-mount-plugin xfce4-netload-plugin xfce4-notifyd xfce4-pulseaudio-plugin xfce4-screensaver xfce4-taskmanager xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-xkb-plugin file-roller network-manager-applet ntp leafpad epdfview vlc galculator lightdm xfwm4-themes xfce4-settings lightdm-gtk-greeter lightdm-gtk-greeter-settings capitaine-cursors arc-gtk-theme xdg-user-dirs-gtk xfce4-goodies virtualbox-guest-utils xf86-video-vmware pavucontrol pulseaudio archlinux-wallpaper xfwm4 && xfconf-query -c xfwm4 -p /general/use_compositing -s true
deepinde=ttf-freefont lightdm lightdm-deepin-greeter vlc ntp deepin deepin-extra archlinux-wallpaper deepin-anything-arch pulseaudio mousepad
kdede=lxsession qt5 plasma-integration plasma-browser-integration kwin kmix knewstuff kitemmodels kcmutils kidletime qt5-graphicaleffects appstream-qt archlinux-appstream-data hicolor-icon-theme kirigami2 discount kuserfeedback powerdevil plasma-wayland-session plasma plasma-meta vlc ntp archlinux-wallpaper kde-applications sddm sddm-kcm kdeplasma-addons phonon-qt5-vlc packagekit-qt5 flatpak fwupd
lxdede=lxde mousepad vlc lxde-common archlinux-wallpaper ntp lxsession openbox mousepad lxdm lxpanel xcompmgr
matede=mate mate-extra ttf-freefont lightdm lightdm-gtk-greeter gnome-terminal gnome-system-monitor vlc eom atril engrampa mate-applet-dock
audioconf=gstreamer systemd ntp gst-libav gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad xed xreader vlc pulseaudio archlinux-wallpaper udev dbus 
videoconf=power-profiles-daemon cpupower go meson xorg xorg-server xorg-apps virtualbox-guest-utils xf86-video-vmware nvidia nvidia-utils nvidia-settings git xdg-utils gettext ufw libva-utils libva-vdpau-driver neofetch wine winetricks lib32-gamemode lib32-vkd3d vkd3d innoextract giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox jre-openjdk-headless jre-openjdk jdk-openjdk openjdk-doc openjdk-src chromium steam-native-runtime gamemode gamescope wine-mono wine-gecko lib32-opencl-nvidia zenity lutris discord steam gnome-menus polkit-gnome gst-plugin-pipewire lib32-pipewire lib32-pipewire-jack pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber firewalld shotwell virtualbox file-roller yelp geary libreoffice-fresh accerciser
baseconf=base linux linux-firmware intel-ucode btrfs-progs net-tools networkmanager dhcpcd iwd vim man-pages man-db texinfo base-devel intel-ucode
loaderentries=/boot/loader/entries/arch.conf
loaderconf=/boot/loader/loader.conf
installerdir=arch-linux-installer/
#End Variables

echo 'Enable Repos' && 
nano $pacmandir && 
$pacman && 
$pacman --noconfirm archlinux-keyring && 
echo 'Partition the Disk' && 

fdisk $drive && 
echo 'Formatting Partitions' && 
mkfs.vfat -F32 $boot && 
#mkfs.fat -F32 /dev/nvme1n1p2 && 
#mkfs.fat -F32 /dev/nvme1n1p3 && 
mkswap $swap && 
mkfs.btrfs -L LocalDisk $os && 
echo 'Mounting Disks' && 
swapon $swap && 
mount $os $rootdir && 
mkdir $rootdir$boot && 
#mkdir /mnt/efi &&
mount $boot $rootdir$boot && 
#mount /dev/nvme1n1p2 /mnt/efi && 
echo 'Installing Kernel Frameworks' && 
$pacman && 
$pacman --noconfirm archlinux-keyring && 
$pacstrap  $baseconf && 
#pacstrap /mnt echo 'Installing Main Desktop Environment'
$pacstrap $cinnamonde && 
echo 'Creating Links' && 
genfstab -U $boot >> /mnt/etc/fstab &&
echo 'Set Root Password' && 
$chroot passwd && 
echo 'Adding User Account' && 
$chroot useradd -m -G wheel,audio,video,power,users,storage $user01 && 
echo 'Set User Password' && 
$chroot passwd $user01 && 

#Phase 2
$chroot $pacman &&
$chroot $pacman --noconfirm archlinux-keyring &&
cp $pacmandir $rootdir$pacmandir && 
cp --dereference /etc/resolv.conf /mnt/etc/
$chroot $pacman $audioconf && 
$chroot $pacman $videoconf && 
$chroot archlinux-java set java-18-openjdk  &&

#Phase 3
$chroot /bin/bash <<"EOT"
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
echo 'default arch.conf' >  $loaderconf && 
echo 'timeout 5' >> $loaderconf && 
echo 'console-mode max' >> $loaderconf && 
echo 'editor no' >> $loaderconf && 
echo 'title Linux Mint "Alpine"' >  $loaderentries && 
echo 'linux /vmlinuz-linux' >> $loaderentries && 
echo 'initrd /intel-ucode.img' >> $loaderentries && 
echo 'initrd /initramfs-linux.img' >> $loaderentries && 
echo 'options root="LABEL=LocalDisk" rw nvidia-drm.modeset=1' >> $loaderentries &&   
$serviceon lightdm && 
$serviceon dhcpcd && 
$serviceon NetworkManager && 
systemctl --global enable pipewire.service pipewire-pulse.service wireplumber.service && 
$serviceon firewalld && 
echo $$
EOT

#Phase 4
echo 'Attempting to install Linux Mint Flavor/s automatically now...' && 
$chroot $pacman --noconfirm xdg-user-dirs &&
echo 'Installing any extra Desktop Environments' &&

$chroot /bin/bash <<"EOT"
ls -l &&
$pacman flatpak snapd && 
#$pacman  $xfcede &&
#$pacman  $kdede &&
#$pacman  $lxqtde &&
#$pacman  $lxde &&
#$pacman  $matede &&
#$pacman  $deepinde &&
echo $$
EOT

echo 'Installing yay for AUR support' && 
$chroot /bin/bash <<"EOT"
mkdir -p /tmp/arch/stage2 &&
cd /tmp/arch/stage2 &&
ls -l && 
cd /opt &&
$usershell sudo git clone https://aur.archlinux.org/yay.git && 
$usershell xdg-user-dirs-update &&
$usershell sudo chown -R $user01:users ./yay && 
$usershell id $user01 && 
cd /opt/yay &&
$usershell makepkg -f -s --install --noconfirm --clean &&  
echo $$
EOT


echo 'Installing Arch-QOL-Extras' && 
$chroot $usershell yay $yayflags pamac-aur && 
$chroot $usershell yay $yayflags libva-vdpau-driver-vp9-git && 
$chroot $usershell yay $yayflags protontricks && 
$chroot $usershell yay $yayflags nvidia-vaapi-driver && 
$chroot $usershell yay $yayflags cpupower-gui && 
$chroot $usershell yay $yayflags mint-themes && 
$chroot $usershell yay $yayflags mint-x-icons && 
$chroot $usershell yay $yayflags mint-y-icons && 
$chroot $usershell yay $yayflags mint-backgrounds && 
$chroot $usershell yay $yayflags game-devices-udev && 
$chroot $usershell yay $yayflags mintlocale && 
$chroot $usershell yay $yayflags mint-artwork &&
$chroot $usershell yay $yayflags mint-artwork-cinnamon && 
$chroot $usershell yay $yayflags linuxmint-keyring && 
$chroot $usershell yay $yayflags gnome-calendar-linuxmint && 
#$chroot $usershell yay $yayflags xboxdrv && 
#$chroot $usershell yay $yayflags systemd-kcm &&

echo 'Ensuring correct DM is set.' && 
$chroot $pacman lightdm gtk3 && 
$chroot $pacman lightdm-gtk-greeter && 
$chroot $pacman && 
$chroot $serviceoff --now gdm && 
$chroot $serviceon lightdm && 
#$chroot $serviceon gdm &&
#$chroot $serviceon systemctl enable sddm &&
#$chroot $serviceon openbox &&  

#Phase 5
echo 'Cleaning up' && 
mkdir $rootdir/VAAPI-Chrome && 
cp $installerdir/chrome-flags.conf $rootdir/VAAPI-Chrome/chrome-flags.conf && 
chmod a+x $rootdir/VAAPI-Chrome/chrome-flags.conf && 
cp $installerdir/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop $rootdir/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop &&  
chmod a+x $rootdir/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop && 
umount -R $rootdir && 
reboot
