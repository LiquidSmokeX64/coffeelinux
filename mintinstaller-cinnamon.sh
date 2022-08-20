#!/bin/sh
source /usr/local/bin
source /usr/bin
#--{Linux Mint "Alpine"}
function setusername(){
source /usr/local/bin
source /usr/bin
echo "Set your User Name (lower-case only)"
read user01
echo "Username accepted"
}

function setdrive(){
source /usr/local/bin
source /usr/bin
echo "Set your Drive (/dev/nvmeXn1 or /dev/sdX)"
read drive
echo "Drive set succcessfully."
}

function setboot(){
source /usr/local/bin
source /usr/bin
echo "Set your Boot partition (/dev/nvmeXn1p1 or /dev/sdX1)"
read boot
echo "Boot Partition set successfully"
}

function setswap(){
source /usr/local/bin
source /usr/bin
echo "Set your Swap partition (/dev/nvmeXn1p2 or /dev/sdX2)"
read swap
echo "Swap Partition set successfully"
}

function setos(){
source /usr/local/bin
source /usr/bin
echo "Set your System partition (/dev/nvmeXn1p3 or /dev/sdX3)"
read os
echo "OS Partition set successfully"
}

function setvar(){
source /usr/local/bin
source /usr/bin
echo "Setting Variables..."
pacman="pacman -Syy"

user=$user01

rootdir="/mnt"

bootdir="/boot"

pacstrap="pacstrap /mnt"

pacmandir="/etc/pacman.conf"

chroot="arch-chroot /mnt"

usershell="sudo -u $user"

serviceon="systemctl enable"

serviceoff="systemctl disable"

yayflags="--nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y"

cinnamon="xcb-util-cursor xcursor-bluecurve xcursor-comix xcursor-flatbed xcursor-neutral xcursor-pinux xcursor-premium xcursor-simpleandsoft xcursor-themes xcursor-vanilla-dmz xcursor-vanilla-dmz-aa nano sudo cinnamon lightdm mate-terminal cinnamon-translations lightdm-gtk-greeter lightdm-gtk-greeter-settings mate-calc mate-terminal gnome-system-monitor xed xreader vlc gnome-keyring cinnamon-translations pulseaudio archlinux-wallpaper qt6 gtk3 udev polkit-gnome gnome-disk-utility dbus"

videoconf="power-profiles-daemon cpupower go meson xorg xorg-server xorg-apps virtualbox-guest-utils xf86-video-vmware nvidia-dkms nvidia-utils nvidia-settings git xdg-utils gettext ufw libva-utils libva-vdpau-driver neofetch wine winetricks lib32-vkd3d vkd3d innoextract giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox jre-openjdk-headless jre-openjdk jdk-openjdk openjdk-doc openjdk-src chromium steam-native-runtime wine-mono wine-gecko lib32-opencl-nvidia zenity lutris discord steam gst-plugin-pipewire lib32-pipewire lib32-pipewire-jack pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber firewalld shotwell virtualbox file-roller libreoffice-fresh"

baseconf="base linux linux-firmware linux-headers dkms intel-ucode btrfs-progs net-tools networkmanager dhcpcd iwd vim man-pages man-db texinfo base-devel intel-ucode"

loaderentries="/boot/loader/entries/arch.conf"
loaderconf="/boot/loader/loader.conf"
installerdir="arch-linux-installer"
#End Variables
echo "Setting Variables...completed sucessfully"
}

function setrepo(){
source /usr/local/bin
source /usr/bin
setvar
echo "Enable Repos" 
nano $pacmandir 
$pacman
$pacman --noconfirm archlinux-keyring
}

function partitioning(){
source /usr/local/bin
source /usr/bin
setvar
echo 'Partition the Disk'
fdisk $drive
echo 'Formatting Partitions' 
mkfs.vfat -F32 $boot  
mkswap $swap
mkfs.btrfs -L LocalDisk $os 
echo 'Mounting Disks' 
swapon $swap
mount $os $rootdir
mkdir $rootdir$bootdir
mount $boot $rootdir$bootdir
}

function copytolocalbin(){
source /usr/local/bin
source /usr/bin
setvar
mkdir -p /mnt/usr/local/bin
cp -r /usr/local/bin/* /mnt/usr/local/bin 
}

function installcinnamon(){
source /usr/local/bin
source /usr/bin
setvar
$pacstrap $cinnamon  
echo 'Creating Links'  
genfstab -U $rootdir >> $rootdir/etc/fstab 
echo 'Set Root Password'
$chroot passwd  
echo 'Adding User Account'  
$chroot useradd -m -G wheel,audio,video,users $user
echo 'Set User Password' 
$chroot passwd $user
$chroot $pacman 
$chroot $pacman --noconfirm archlinux-keyring
cp $pacmandir $rootdir$pacmandir 
cp --dereference /etc/resolv.conf $rootdir/etc/
$chroot $pacman $audioconf 
$chroot $pacman $videoconf  
$chroot archlinux-java set java-18-openjdk
}

function setuplocaleandbootloader(){
$chroot /bin/bash <<"EOT"
source /usr/local/bin
source /usr/bin
setvar
mkdir -p /tmp/arch
cd /tmp/arch
ls -l 
cd /  
echo 'Setting Locale' 
ln -sf ../usr/share/zoneinfo/America/Los_Angeles /etc/localtime  
hwclock --systohc 
echo 'en_US ISO-8859-1' >> /etc/locale.gen  
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen 
echo 'KEYMAP=us' > /etc/vconsole.conf 
echo 'LANG=en_US.UTF-8' > /etc/locale.conf 
export LANG=en_US.UTF-8 
locale-gen 
echo 'Setting Hostname' 
echo 'mint-alpine' > /etc/hostname
echo '127.0.0.1 localhost' >> /etc/hosts  
echo '::1 localhost' >> /etc/hosts 
echo '127.0.1.1 mint-alpine' >> /etc/hosts 
echo '%wheel ALL=(ALL:ALL) ALL' > /etc/sudoers.d/wheel
mkinitcpio -P 
echo Installing Bootloader 
bootctl install
echo 'default arch.conf' >  $loaderconf 
echo 'timeout 5' >> $loaderconf 
echo 'console-mode max' >> $loaderconf 
echo 'editor no' >> $loaderconf 
echo 'title Linux Mint "Alpine"' >  $loaderentries 
echo 'linux /vmlinuz-linux' >> $loaderentries 
echo 'initrd /intel-ucode.img' >> $loaderentries 
echo 'initrd /initramfs-linux.img' >> $loaderentries 
echo 'options root="LABEL=LocalDisk" rw nvidia-drm.modeset=1' >> $loaderentries    
$serviceon lightdm  
$serviceon dhcpcd 
$serviceon NetworkManager 
systemctl --global enable pipewire.service pipewire-pulse.service wireplumber.service  
$serviceon firewalld 
echo $$
EOT
}

function fixhomefolders(){
source /usr/local/bin
source /usr/bin
setvar
echo 'Attempting to install Linux Mint Flavor/s automatically now...' 
$chroot $pacman --noconfirm xdg-user-dirs
$chroot xdg-user-dirs-update
}

function installyay(){
source /usr/local/bin
source /usr/bin
setvar
echo 'Installing yay for AUR support'
$chroot /bin/bash <<"EOT"
source /usr/local/bin
source /usr/bin
setvar

mkdir -p /tmp/arch/stage2 
cd /tmp/arch/stage2 
ls -l 
cd /opt 
$usershell sudo git clone https://aur.archlinux.org/yay.git 
$usershell xdg-user-dirs-update
$usershell sudo chown -R $user:users ./yay  
$usershell id $user
cd /opt/yay
$usershell makepkg -f -s --install --noconfirm --clean  
echo $$
EOT
}

function installextras(){
source /usr/local/bin
source /usr/bin
setvar
echo 'Installing Arch-QOL-Extras' 
$chroot $usershell yay $yayflags pamac-aur  
$chroot $usershell yay $yayflags libva-vdpau-driver-vp9-git  
$chroot $usershell yay $yayflags protontricks 
$chroot $usershell yay $yayflags nvidia-vaapi-driver
$chroot $usershell yay $yayflags cpupower-gui 
$chroot $usershell yay $yayflags mint-backgrounds 
$chroot $usershell yay $yayflags game-devices-udev 
$chroot $usershell yay $yayflags mint-themes  
$chroot $usershell yay $yayflags mint-x-icons  
$chroot $usershell yay $yayflags mint-y-icons   
$chroot $usershell yay $yayflags mintlocale   
$chroot $usershell yay $yayflags linuxmint-keyring 
$chroot $usershell yay $yayflags gnome-calendar-linuxmint 
$chroot $pacman lightdm 
$chroot $pacman lightdm-gtk-greeter 
$chroot $pacman
$chroot $usershell yay $yayflags mint-artwork 
$chroot $usershell yay $yayflags mint-artwork-cinnamon 
$chroot $usershell yay $yayflags google-chrome
#$chroot $serviceoff --now gdm && 
$chroot $serviceon lightdm 
#$chroot $serviceon gdm &&
#$chroot $serviceon systemctl enable sddm &&
#$chroot $serviceon openbox && 
}

function cleanupinstall(){
source /usr/local/bin
source /usr/bin
#Phase 5
setvar &&
echo 'Cleaning up' 
cp /home/os-release $rootdir/usr/lib/os-release
mkdir $rootdir/VAAPI-Chrome 
cp $installerdir/chrome-flags.conf $rootdir/VAAPI-Chrome/chrome-flags.conf 
chmod a+x $rootdir/VAAPI-Chrome/chrome-flags.conf
cp $installerdir/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop $rootdir/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop  
chmod a+x $rootdir/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop
umount -R $rootdir
}

function installcinnamondesktop(){
source /usr/local/bin
source /usr/bin
setvar
installcinnamon
setuplocaleandbootloader
fixhomefolders
installyay
installextras
cleanupinstall
}

function installmintarchbase(){
source /usr/local/bin
source /usr/bin

setusername &&
setdrive &&
setboot &&
setswap &&
setos &&
setvar &&
setrepo &&
partitioning &&
copytolocalbin &&
installcinnamondesktop
#reboot
echo "Installation Complete, Please Reboot to use your OS."
read -n 1 -s -r -p "Press any key to continue"
}

installmintarchbase

##End Script
