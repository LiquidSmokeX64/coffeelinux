#!/bin/sh

ENDSECTOR=$(sgdisk -E "$1")
OSDRIVE="/dev/nvme1n1"
USERX="fahr"

#Phase 1
echo 'Enable MultiLib' && 
echo '[multilib]' >> /etc/pacman.conf && 
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf && 
echo '[testing]' >> /etc/pacman.conf && 
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf &&
echo '[multilib-testing]' >> /etc/pacman.conf && 
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf &&
echo '[community-testing]' >> /etc/pacman.conf && 
echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf &&  
pacman -Sy && 
pacman -Sy --noconfirm archlinux-keyring && 
echo 'Partition the Disk' && 
sgdisk -og "OSDRIVE"
sgdisk -n 1:2048:4095 -c 1:"BIOS Boot Partition" -t 1:ef02 "OSDRIVE"
sgdisk -n 2:4096:+1G -c 2:"EFI System Partition" -t 2:ef00 "OSDRIVE"
sgdisk -n 3:0:+1G -c 3:"Linux /boot" -t 3:8300 "OSDRIVE"

sgdisk -n 4:0:+64G -c 4:"Linux Swap" -t 4:8200 "OSDRIVE"
sgdisk -n 5:0:"$ENDSECTOR" -c 5:"Linux Filesystem" -t 5:8300 "OSDRIVE"
sgdisk -p "OSDRIVE"
#fdisk /dev/nvme1n1 && 
echo 'Formatting Partitions' && 
mkfs.fat -F32 "OSDRIVE"p1 && 
mkfs.fat -F32 "OSDRIVE"p2 && 
mkfs.fat -F32 "OSDRIVE"p3 && 
mkswap "OSDRIVE"p4 && 
mkfs.btrfs -L LocalDisk "OSDRIVE"p5 && 
echo 'Mounting Disks' && 
swapon "OSDRIVE"p4 && 
mount "OSDRIVE"p5 /mnt && 
mkdir /mnt/boot && 
mkdir /mnt/efi &&
mount "OSDRIVE"p3 /mnt/boot && 
mount "OSDRIVE"p2 /mnt/efi && 
echo 'Installing Kernel Frameworks' && 
pacman -Syy && 
pacman -Sy --noconfirm archlinux-keyring && 
pacstrap /mnt base linux linux-firmware intel-ucode btrfs-progs net-tools networkmanager dhcpcd iwd vim man-pages man-db texinfo base-devel intel-ucode && 
pacstrap /mnt sudo nano cinnamon gnome gdm gtk4 qt6 gnome-extra dkms gnome-terminal gedit gnome-system-monitor gnome-keyring cinnamon-translations && 
echo 'Creating Links' && 
genfstab -U /mnt >> /mnt/etc/fstab &&
echo 'Set Root Password' && 
arch-chroot /mnt passwd && 
echo 'Adding User Account' && 
arch-chroot /mnt useradd -m -G wheel,audio,video,power,users,storage "USERX" && 
echo 'Set User Password' && 
arch-chroot /mnt passwd "USERX" && 

#Phase 2
arch-chroot /mnt pacman -Syy &&
arch-chroot /mnt pacman -Sy --noconfirm archlinux-keyring &&
arch-chroot /mnt echo '[multilib]' >> /mnt/etc/pacman.conf && 
arch-chroot /mnt echo 'Include = /etc/pacman.d/mirrorlist' >> /mnt/etc/pacman.conf &&
arch-chroot /mnt echo '[testing]' >> /mnt/etc/pacman.conf && 
arch-chroot /mnt echo 'Include = /etc/pacman.d/mirrorlist' >> /mnt/etc/pacman.conf &&
arch-chroot /mnt echo '[multilib-testing]' >> /mnt/etc/pacman.conf && 
arch-chroot /mnt echo 'Include = /etc/pacman.d/mirrorlist' >> /mnt/etc/pacman.conf &&
arch-chroot /mnt echo '[community-testing]' >> /mnt/etc/pacman.conf && 
arch-chroot /mnt echo 'Include = /etc/pacman.d/mirrorlist' >> /mnt/etc/pacman.conf &&  
arch-chroot /mnt pacman -Syy && 
arch-chroot /mnt pacman -Sy gstreamer systemd ntp gst-libav gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad xed xreader vlc pulseaudio archlinux-wallpaper udev dbus && 
arch-chroot /mnt pacman -Sy go meson xorg xorg-server xorg-apps virtualbox-guest-utils xf86-video-vmware nvidia nvidia-utils nvidia-settings git xdg-utils gettext ufw libva-utils libva-vdpau-driver neofetch wine winetricks lib32-gamemode lib32-vkd3d vkd3d innoextract giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox jre-openjdk-headless jre-openjdk jdk-openjdk openjdk-doc openjdk-src chromium steam-native-runtime gamemode gamescope wine-mono wine-gecko lib32-opencl-nvidia zenity lutris discord steam gnome-menus polkit-gnome gst-plugin-pipewire lib32-pipewire lib32-pipewire-jack pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber firewalld shotwell virtualbox gimp blender cura gnome-calculator gnome-characters file-roller gnome-firmware font-manager gnome-font-viewer fragments gnome-tweaks gvim yelp gnome-logs alacarte gnome-maps gnome-nettool gnome-notes gnome-recipes gnome-screenshot gnome-weather gnome-contacts geary gnome-dictionary gnome-latex libreoffice-fresh gnome-music gnome-podcasts gnome-sound-recorder hexchat transmission-gtk five-or-more four-in-a-row gnome-games gnome-chess gnome-klotski gnome-mahjongg gnome-mines gnome-nibbles gnome-robots gnome-sudoku gnome-taquin gnome-tetravex cheese gnome-photos accerciser gnome-boxes gnome-builder && 
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

arch-chroot /mnt /bin/bash <<"EOT"
USERX="USERX"
mkdir -p /tmp/arch/stage2 &&
cd /tmp/arch/stage2 &&
ls -l && 
cd /opt &&
sudo -u "USERX" sudo git clone https://aur.archlinux.org/yay.git && 
sudo -u "USERX" xdg-user-dirs-update &&
sudo -u "USERX" sudo chown -R user01:users ./yay && 
sudo -u "USERX" id user01 && 
cd /opt/yay &&
sudo -u "USERX" makepkg -f -s --install --noconfirm --clean &&  
echo $$
EOT

arch-chroot /mnt sudo -u "USERX" yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y pamac-aur && 
arch-chroot /mnt sudo -u "USERX" yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y libva-vdpau-driver-vp9-git && 
arch-chroot /mnt sudo -u "USERX" yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y protontricks && 
arch-chroot /mnt sudo -u "USERX" yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y nvidia-vaapi-driver && 
arch-chroot /mnt sudo -u "USERX" yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y cpupower-gui && 
arch-chroot /mnt sudo -u "USERX" yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-themes && 
arch-chroot /mnt sudo -u "USERX" yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-x-icons && 
arch-chroot /mnt sudo -u "USERX" yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-y-icons && 
arch-chroot /mnt sudo -u "USERX" yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-backgrounds && 
arch-chroot /mnt sudo -u "USERX" yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y game-devices-udev && 
arch-chroot /mnt sudo -u "USERX" yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mintlocale &&  
arch-chroot /mnt sudo -u "USERX" yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y mint-artwork-cinnamon && 
arch-chroot /mnt sudo -u "USERX" yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y linuxmint-keyring && 
arch-chroot /mnt sudo -u "USERX" yay --answerclean y  --answerdiff y --answeredit y --answerupgrade y --nodiffmenu --noremovemake gnome-calendar-linuxmint && 
arch-chroot /mnt sudo -u "USERX" yay --nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y xboxdrv && 

#Phase 5
echo 'Cleaning up' && 
mkdir /mnt/VAAPI-Chrome && 
cp arch-linux-installer/chrome-flags.conf /mnt/VAAPI-Chrome/chrome-flags.conf && 
chmod a+x /mnt/VAAPI-Chrome/chrome-flags.conf && 
cp arch-linux-installer/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop /mnt/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop &&  
chmod a+x /mnt/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop && 
umount -R /mnt && 
reboot
