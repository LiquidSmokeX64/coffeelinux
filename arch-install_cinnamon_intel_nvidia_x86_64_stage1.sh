#!/bin/sh

#--{Linux Mint "Alpine"}

function setusername(){
echo "Set your User Name (lower-case only)"
read user01
if $user01!="*"
    then
    echo "You must set a valid username" && break
else
    echo "Username accepted"
    export usercheck="1"
fi
}

function setdrive(){
echo "Set your Drive"
read drive
if $drive!=("/dev/nvme0n1" || "/dev/sda" || "/dev/sdb)" || "/dev/nvme1n1")
    then
    echo "Please select drive 0 or 1 only." && break
else
    echo "Drive set succcessfully."
    export drivecheck="1"
fi
}

function setboot(){
echo "Set your Boot partition"
read boot
if $boot!=("/dev/nvme0n1p1" || "/dev/nvme1n1p1" || "/dev/sda1" || "/dev/sdb1")
    then
    echo "Please set boot as Partition 1 of the set Drive" && break
else
    echo "Boot Partition set successfully"
    export bootcheck="1"
fi
}

function setswap(){
echo "Set your Swap partition"
read swap
if $swap!=("/dev/nvme0n1p2" || "/dev/nvme1n1p2" || "/dev/sda2" || "/dev/sdb2")
then
    echo "Please set swap as Partition 2 of the set Drive" && break
else
    echo "Swap Partition set successfully"
    export swapcheck="1"
fi
}

function setos(){
echo "Set your System partition"
read os
if $os!=("/dev/nvme0n1p3" || "/dev/nvme1n1p3" || "/dev/sda3" || "/dev/sdb3")
then
    echo "Please set OS as Partition 3 of the set Drive" && break
else
    echo "OS Partition set successfully"
    export oscheck="1"
fi
}

function setdesktop(){
echo 'Select Desktop Environment (gnome, cinnamon, kde, mate, deepin, lxde, lxqt, or xfce)'
read desktop
if $desktop!=("cinnamon" || "gnome" || "kde" || "mate" || "lxde" || "lxqt" || "xfce")
then
    echo "Please set a valid desktop environment." && break
else
    echo "Desktop Environment set successfully"
    export decheck="1"
fi
}

function setrepo(){
echo 'Enable Repos' 
nano $pacmandir 
$pacman
$pacman --noconfirm archlinux-keyring
export repocheck="1"
}

function setvar(){
export pacman="pacman -Syy"

export pacstrap="pacstrap $rootdir"

export rootdir="/mnt"

export bootdir="/boot"

export pacmandir="/etc/pacman.conf"

export chroot="arch-chroot $rootdir"

export usershell="sudo -u $user01"

export serviceon="systemctl enable"

export serviceoff="systemctl disable"

export yayflags= "--nodiffmenu --noremovemake --answerclean y  --answerdiff y --answeredit y --answerupgrade y"

export gnome="sudo nano gnome-menus polkit-gnome gnome gdm gtk4 gnome-text-editor gnome-menus polkit-gnome qt6 gnome-extra dkms gnome-terminal gedit gnome-system-monitor gnome-keyring" 

export cinnamon="sudo nano cinnamon lightdm gnome-terminal cinnamon-translations lightdm-gtk-greeter lightdm-gtk-greeter-settings gnome-calculator gnome-system-monitor xed xreader vlc gnome-keyring cinnamon-translations pulseaudio archlinux-wallpaper qt6 gtk3 udev polkit-gnome dbus"

export lxqt="sddm xscreensaver xautolock lxqt ntp lximage-qt lxqt-about lxqt-admin lxqt-archiver lxqt-config lxqt-globalkeys lxqt-notificationd lxqt-openssh-askpass lxqt-panel lxqt-policykit lxqt-powermanagement lxqt-qtplugin lxqt-runner lxqt-session archlinux-wallpaper vlc lxqt-sudo lxqt-themes obconf-qt pavucontrol-qt pcmanfm-qt qterminal screengrab pulseaudio breeze-icons oxygen-icons cups alsa-lib giflib libjpeg libpng xdg-utils mousepad"

export xfce="xfce4 mousepad parole ristretto thunar-archive-plugin thunar-media-tags-plugin xfce4-battery-plugin xfce4-datetime-plugin xfce4-mount-plugin xfce4-netload-plugin xfce4-notifyd xfce4-pulseaudio-plugin xfce4-screensaver xfce4-taskmanager xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-xkb-plugin file-roller network-manager-applet ntp leafpad epdfview vlc galculator lightdm xfwm4-themes xfce4-settings lightdm-gtk-greeter lightdm-gtk-greeter-settings capitaine-cursors arc-gtk-theme xdg-user-dirs-gtk xfce4-goodies virtualbox-guest-utils xf86-video-vmware pavucontrol pulseaudio archlinux-wallpaper xfwm4 && xfconf-query -c xfwm4 -p /general/use_compositing -s true
deepinde=ttf-freefont lightdm lightdm-deepin-greeter lightdm-deepin-greeter-settings vlc ntp deepin deepin-extra archlinux-wallpaper deepin-anything-arch pulseaudio mousepad"

export kde="lxsession qt5 plasma-integration plasma-browser-integration kwin kmix knewstuff kitemmodels kcmutils kidletime qt5-graphicaleffects appstream-qt archlinux-appstream-data hicolor-icon-theme kirigami2 discount kuserfeedback powerdevil plasma-wayland-session plasma plasma-meta vlc ntp archlinux-wallpaper kde-applications sddm sddm-kcm kdeplasma-addons phonon-qt5-vlc packagekit-qt5 flatpak fwupd"

export lxde="lxde mousepad vlc lxde-common archlinux-wallpaper ntp lxsession openbox mousepad lxdm lxpanel xcompmgr"

export mate="mate mate-extra ttf-freefont lightdm lightdm-gtk-greeter gnome-terminal gnome-system-monitor vlc eom atril engrampa mate-applet-dock audioconf=gstreamer systemd ntp gst-libav gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad xed xreader vlc pulseaudio archlinux-wallpaper udev dbus" 

export videoconf="power-profiles-daemon cpupower go meson xorg xorg-server xorg-apps virtualbox-guest-utils xf86-video-vmware nvidia-dkms nvidia-utils nvidia-settings git xdg-utils gettext ufw libva-utils libva-vdpau-driver neofetch wine winetricks lib32-vkd3d vkd3d innoextract giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox jre-openjdk-headless jre-openjdk jdk-openjdk openjdk-doc openjdk-src chromium steam-native-runtime wine-mono wine-gecko lib32-opencl-nvidia zenity lutris discord steam gst-plugin-pipewire lib32-pipewire lib32-pipewire-jack pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber firewalld shotwell virtualbox file-rollerlibreoffice-fresh"

export baseconf="base linux linux-firmware linux-headers dkms intel-ucode btrfs-progs net-tools networkmanager dhcpcd iwd vim man-pages man-db texinfo base-devel intel-ucode"

export loaderentries="/boot/loader/entries/arch.conf"
export loaderconf="/boot/loader/loader.conf"
export installerdir="arch-linux-installer/"
#End Variables
export varcheck="1"
}

function checkenv(){
if $usercheck="1" do
echo "UserName check Passed"
else echo "UserName check failed, aborting.." && break
then if $drivecheck="1" do
echo "Drive check Passed"
else echo "Drive check failed, aborting.." && break
then if $bootcheck="1" do
echo "Boot check Passed"
else echo "Boot check failed, aborting.." && break
then if $swapcheck="1" do
echo "Swap check Passed"
else echo "Swap check failed, aborting.." && break
then if $oscheck="1" do 
echo "OS check Passed"
else echo "OS check failed, aborting.." && break
then if $decheck="1" do
echo "Desktop Environment check Passed"
else echo "Desktop Environment check failed, aborting.." && break
then if $repocheck="1"
echo "Repo check Passed"
else echo "Repo check failed, aborting.." && break
then if $varcheck="1"
echo "Var check Passed"
else echo "Var check failed, aborting.." && break
then echo "All Checks Passed"
fi
}

function partitioning(){
echo 'Partition the Disk'
fdisk $drive
echo 'Formatting Partitions' 
mkfs.vfat -F32 $boot  
mkswap $swap
mkfs.btrfs -L LocalDisk $os 
echo 'Mounting Disks' 
swapon $swap
mount $os $rootdir
mkdir $rootdir$boot
mount $boot $rootdir$boot
}
 
function installcinnamon(){
$pacstrap $cinnamon  
echo 'Creating Links'  
genfstab -U $boot >> /mnt/etc/fstab 
echo 'Set Root Password'
$chroot passwd  
echo 'Adding User Account'  
$chroot useradd -m -G wheel,audio,video,power,users,storage $user01 
echo 'Set User Password' 
$chroot passwd $user01 
$chroot $pacman 
$chroot $pacman --noconfirm archlinux-keyring
cp $pacmandir $rootdir$pacmandir 
cp --dereference /etc/resolv.conf /mnt/etc/
$chroot $pacman $audioconf 
$chroot $pacman $videoconf  
$chroot archlinux-java set java-18-openjdk

$chroot /bin/bash <<"EOT"
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
echo 'Linux-Mint-PC' > /etc/hostname
echo '127.0.0.1 localhost' >> /etc/hosts  
echo '::1 localhost' >> /etc/hosts 
echo '127.0.1.1 Linux-Mint-PC' >> /etc/hosts 
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

echo 'Attempting to install Linux Mint Flavor/s automatically now...' 
$chroot $pacman --noconfirm xdg-user-dirs
echo 'Installing yay for AUR support'
$chroot /bin/bash <<"EOT"
mkdir -p /tmp/arch/stage2 
cd /tmp/arch/stage2 
ls -l 
cd /opt 
$usershell sudo git clone https://aur.archlinux.org/yay.git 
$usershell xdg-user-dirs-update
$usershell sudo chown -R $user01:users ./yay  
$usershell id $user01
cd /opt/yay
$usershell makepkg -f -s --install --noconfirm --clean  
echo $$
EOT
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
$chroot $usershell yay $yayflags mint-artwork 
$chroot $usershell yay $yayflags mint-artwork-cinnamon  
$chroot $usershell yay $yayflags linuxmint-keyring 
$chroot $usershell yay $yayflags gnome-calendar-linuxmint 

$chroot $pacman lightdm 
$chroot $pacman lightdm-gtk-greeter 
$chroot $pacman  
#$chroot $serviceoff --now gdm && 
$chroot $serviceon lightdm 
#$chroot $serviceon gdm &&
#$chroot $serviceon systemctl enable sddm &&
#$chroot $serviceon openbox && 
}

function installgnome(){
$pacstrap $gnome  

echo 'Creating Links'  
genfstab -U $boot >> /mnt/etc/fstab 
echo 'Set Root Password'  
$chroot passwd 
echo 'Adding User Account' 
$chroot useradd -m -G wheel,audio,video,power,users,storage $user01  
echo 'Set User Password'  
$chroot passwd $user01  
$chroot $pacman 
$chroot $pacman --noconfirm archlinux-keyring 
cp $pacmandir $rootdir$pacmandir 
cp --dereference /etc/resolv.conf /mnt/etc/
$chroot $pacman $audioconf  
$chroot $pacman $videoconf 
$chroot archlinux-java set java-18-openjdk

$chroot /bin/bash <<"EOT"
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
echo 'Linux-Mint-PC' > /etc/hostname
echo '127.0.0.1 localhost' >> /etc/hosts 
echo '::1 localhost' >> /etc/hosts
echo '127.0.1.1 Linux-Mint-PC' >> /etc/hosts
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
$serviceon gdm 
$serviceon dhcpcd
$serviceon NetworkManager
systemctl --global enable pipewire.service pipewire-pulse.service wireplumber.service 
$serviceon firewalld
echo $$
EOT

echo 'Attempting to install Linux Mint Flavor/s automatically now...' 
$chroot $pacman --noconfirm xdg-user-dirs 
echo 'Installing yay for AUR support' 
$chroot /bin/bash <<"EOT"
mkdir -p /tmp/arch/stage2
cd /tmp/arch/stage2
ls -l 
cd /opt
$usershell sudo git clone https://aur.archlinux.org/yay.git 
$usershell xdg-user-dirs-update
$usershell sudo chown -R $user01:users ./yay 
$usershell id $user01 
cd /opt/yay
$usershell makepkg -f -s --install --noconfirm --clean  
echo $$
EOT
echo 'Installing Arch-QOL-Extras' 
$chroot $usershell yay $yayflags pamac-aur 
$chroot $usershell yay $yayflags libva-vdpau-driver-vp9-git
$chroot $usershell yay $yayflags protontricks
$chroot $usershell yay $yayflags nvidia-vaapi-driver 
$chroot $usershell yay $yayflags cpupower-gui
$chroot $usershell yay $yayflags mint-backgrounds
$chroot $usershell yay $yayflags game-devices-udev  

#$chroot $pacman lightdm && 
#$chroot $pacman lightdm-gtk-greeter && 
$chroot $pacman 
#$chroot $serviceoff --now gdm && 
#$chroot $serviceon lightdm && 
$chroot $serviceon gdm 
#$chroot $serviceon systemctl enable sddm &&
#$chroot $serviceon openbox && 
} 

function installkde(){
$pacstrap $kde

echo 'Creating Links' 
genfstab -U $boot >> /mnt/etc/fstab
echo 'Set Root Password'
$chroot passwd 
echo 'Adding User Account' 
$chroot useradd -m -G wheel,audio,video,power,users,storage $user01
echo 'Set User Password'
$chroot passwd $user01
$chroot $pacman
$chroot $pacman --noconfirm archlinux-keyring 
cp $pacmandir $rootdir$pacmandir 
cp --dereference /etc/resolv.conf /mnt/etc/
$chroot $pacman $audioconf 
$chroot $pacman $videoconf 
$chroot archlinux-java set java-18-openjdk 

$chroot /bin/bash <<"EOT"
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
echo 'Linux-Mint-PC' > /etc/hostname
echo '127.0.0.1 localhost' >> /etc/hosts
echo '::1 localhost' >> /etc/hosts
echo '127.0.1.1 Linux-Mint-PC' >> /etc/hosts
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
$serviceon sddm
$serviceon dhcpcd 
$serviceon NetworkManager 
systemctl --global enable pipewire.service pipewire-pulse.service wireplumber.service 
$serviceon firewalld
echo $$
EOT

echo 'Attempting to install Linux Mint Flavor/s automatically now...'
$chroot $pacman --noconfirm xdg-user-dirs
echo 'Installing yay for AUR support'
$chroot /bin/bash <<"EOT"
mkdir -p /tmp/arch/stage2
cd /tmp/arch/stage2
ls -l
cd /opt
$usershell sudo git clone https://aur.archlinux.org/yay.git 
$usershell xdg-user-dirs-update
$usershell sudo chown -R $user01:users ./yay 
$usershell id $user01
cd /opt/yay
$usershell makepkg -f -s --install --noconfirm --clean  
echo $$
EOT
echo 'Installing Arch-QOL-Extras'
$chroot $usershell yay $yayflags pamac-aur
$chroot $usershell yay $yayflags libva-vdpau-driver-vp9-git
$chroot $usershell yay $yayflags protontricks
$chroot $usershell yay $yayflags nvidia-vaapi-driver 
$chroot $usershell yay $yayflags cpupower-gui
$chroot $usershell yay $yayflags mint-backgrounds 
$chroot $usershell yay $yayflags game-devices-udev 
$chroot $usershell yay $yayflags systemd-kcm

#$chroot $pacman lightdm && 
#$chroot $pacman lightdm-gtk-greeter && 
$chroot $pacman
#$chroot $serviceoff --now gdm && 
#$chroot $serviceon lightdm && 
#$chroot $serviceon gdm &&
$chroot $serviceon sddm
#$chroot $serviceon openbox && 
}

function installmate(){
$pacstrap $mate

echo 'Creating Links' 
genfstab -U $boot >> /mnt/etc/fstab
echo 'Set Root Password' 
$chroot passwd
echo 'Adding User Account' 
$chroot useradd -m -G wheel,audio,video,power,users,storage $user01 
echo 'Set User Password'
$chroot passwd $user01
$chroot $pacman
$chroot $pacman --noconfirm archlinux-keyring
cp $pacmandir $rootdir$pacmandir
cp --dereference /etc/resolv.conf /mnt/etc/
$chroot $pacman $audioconf
$chroot $pacman $videoconf
$chroot archlinux-java set java-18-openjdk 

$chroot /bin/bash <<"EOT"
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
echo 'Linux-Mint-PC' > /etc/hostname
echo '127.0.0.1 localhost' >> /etc/hosts
echo '::1 localhost' >> /etc/hosts
echo '127.0.1.1 Linux-Mint-PC' >> /etc/hosts
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

echo 'Attempting to install Linux Mint Flavor/s automatically now...' 
$chroot $pacman --noconfirm xdg-user-dirs
echo 'Installing yay for AUR support'
$chroot /bin/bash <<"EOT"
mkdir -p /tmp/arch/stage2
cd /tmp/arch/stage2
ls -l
cd /opt
$usershell sudo git clone https://aur.archlinux.org/yay.git
$usershell xdg-user-dirs-update
$usershell sudo chown -R $user01:users ./yay
$usershell id $user01
cd /opt/yay
$usershell makepkg -f -s --install --noconfirm --clean 
echo $$
EOT

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
$chroot $usershell yay $yayflags mint-artwork
$chroot $usershell yay $yayflags mint-artwork-mate
$chroot $usershell yay $yayflags linuxmint-keyring

$chroot $pacman lightdm
$chroot $pacman lightdm-gtk-greeter 
$chroot $pacman
#$chroot $serviceoff --now gdm && 
$chroot $serviceon lightdm
#$chroot $serviceon gdm &&
#$chroot $serviceon systemctl enable sddm &&
#$chroot $serviceon openbox && 
}

function installlxde(){
$pacstrap $lxde && 

eecho 'Creating Links' 
genfstab -U $boot >> /mnt/etc/fstab
echo 'Set Root Password' 
$chroot passwd
echo 'Adding User Account' 
$chroot useradd -m -G wheel,audio,video,power,users,storage $user01 
echo 'Set User Password'
$chroot passwd $user01
$chroot $pacman
$chroot $pacman --noconfirm archlinux-keyring
cp $pacmandir $rootdir$pacmandir
cp --dereference /etc/resolv.conf /mnt/etc/
$chroot $pacman $audioconf
$chroot $pacman $videoconf
$chroot archlinux-java set java-18-openjdk 

$chroot /bin/bash <<"EOT"
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
echo 'Linux-Mint-PC' > /etc/hostname
echo '127.0.0.1 localhost' >> /etc/hosts
echo '::1 localhost' >> /etc/hosts
echo '127.0.1.1 Linux-Mint-PC' >> /etc/hosts
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
$serviceon lxdm
$serviceon dhcpcd
$serviceon NetworkManager
systemctl --global enable pipewire.service pipewire-pulse.service wireplumber.service
$serviceon firewalld
echo $$
EOT

echo 'Attempting to install Linux Mint Flavor/s automatically now...' 
$chroot $pacman --noconfirm xdg-user-dirs
echo 'Installing yay for AUR support'
$chroot /bin/bash <<"EOT"
mkdir -p /tmp/arch/stage2
cd /tmp/arch/stage2
ls -l
cd /opt
$usershell sudo git clone https://aur.archlinux.org/yay.git
$usershell xdg-user-dirs-update
$usershell sudo chown -R $user01:users ./yay
$usershell id $user01
cd /opt/yay
$usershell makepkg -f -s --install --noconfirm --clean 
echo $$
EOT
echo 'Installing Arch-QOL-Extras'
$chroot $usershell yay $yayflags pamac-aur
$chroot $usershell yay $yayflags libva-vdpau-driver-vp9-git
$chroot $usershell yay $yayflags protontricks
$chroot $usershell yay $yayflags nvidia-vaapi-driver 
$chroot $usershell yay $yayflags cpupower-gui
$chroot $usershell yay $yayflags mint-backgrounds 
$chroot $usershell yay $yayflags game-devices-udev 

#$chroot $pacman lightdm && 
#$chroot $pacman lightdm-gtk-greeter && 
$chroot $pacman
#$chroot $serviceoff --now gdm && 
$chroot $serviceon lxdm 
#$chroot $serviceon gdm &&
#$chroot $serviceon systemctl enable sddm &&
#$chroot $serviceon openbox &&
}
 
function installlxqt(){
$pacstrap $lxqt && 

echo 'Creating Links' 
genfstab -U $boot >> /mnt/etc/fstab
echo 'Set Root Password'
$chroot passwd 
echo 'Adding User Account' 
$chroot useradd -m -G wheel,audio,video,power,users,storage $user01
echo 'Set User Password'
$chroot passwd $user01
$chroot $pacman
$chroot $pacman --noconfirm archlinux-keyring 
cp $pacmandir $rootdir$pacmandir 
cp --dereference /etc/resolv.conf /mnt/etc/
$chroot $pacman $audioconf 
$chroot $pacman $videoconf 
$chroot archlinux-java set java-18-openjdk 

$chroot /bin/bash <<"EOT"
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
echo 'Linux-Mint-PC' > /etc/hostname
echo '127.0.0.1 localhost' >> /etc/hosts
echo '::1 localhost' >> /etc/hosts
echo '127.0.1.1 Linux-Mint-PC' >> /etc/hosts
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
$serviceon sddm
$serviceon dhcpcd 
$serviceon NetworkManager 
systemctl --global enable pipewire.service pipewire-pulse.service wireplumber.service 
$serviceon firewalld
echo $$
EOT

echo 'Attempting to install Linux Mint Flavor/s automatically now...'
$chroot $pacman --noconfirm xdg-user-dirs
echo 'Installing yay for AUR support'
$chroot /bin/bash <<"EOT"
mkdir -p /tmp/arch/stage2
cd /tmp/arch/stage2
ls -l
cd /opt
$usershell sudo git clone https://aur.archlinux.org/yay.git 
$usershell xdg-user-dirs-update
$usershell sudo chown -R $user01:users ./yay 
$usershell id $user01
cd /opt/yay
$usershell makepkg -f -s --install --noconfirm --clean  
echo $$
EOT
echo 'Installing Arch-QOL-Extras'
$chroot $usershell yay $yayflags pamac-aur
$chroot $usershell yay $yayflags libva-vdpau-driver-vp9-git
$chroot $usershell yay $yayflags protontricks
$chroot $usershell yay $yayflags nvidia-vaapi-driver 
$chroot $usershell yay $yayflags cpupower-gui
$chroot $usershell yay $yayflags mint-backgrounds 
$chroot $usershell yay $yayflags game-devices-udev  

#$chroot $pacman lightdm && 
#$chroot $pacman lightdm-gtk-greeter && 
$chroot $pacman
#$chroot $serviceoff --now gdm && 
#$chroot $serviceon lightdm && 
#$chroot $serviceon gdm &&
$chroot $serviceon sddm
#$chroot $serviceon openbox && 
}

function installxfce(){
$pacstrap $xfce && 
echo 'Creating Links'  
genfstab -U $boot >> /mnt/etc/fstab 
echo 'Set Root Password'
$chroot passwd  
echo 'Adding User Account'  
$chroot useradd -m -G wheel,audio,video,power,users,storage $user01 
echo 'Set User Password' 
$chroot passwd $user01 
$chroot $pacman 
$chroot $pacman --noconfirm archlinux-keyring
cp $pacmandir $rootdir$pacmandir 
cp --dereference /etc/resolv.conf /mnt/etc/
$chroot $pacman $audioconf 
$chroot $pacman $videoconf  
$chroot archlinux-java set java-18-openjdk

$chroot /bin/bash <<"EOT"
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
echo 'Linux-Mint-PC' > /etc/hostname
echo '127.0.0.1 localhost' >> /etc/hosts  
echo '::1 localhost' >> /etc/hosts 
echo '127.0.1.1 Linux-Mint-PC' >> /etc/hosts 
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

echo 'Attempting to install Linux Mint Flavor/s automatically now...' 
$chroot $pacman --noconfirm xdg-user-dirs
echo 'Installing yay for AUR support'
$chroot /bin/bash <<"EOT"
mkdir -p /tmp/arch/stage2 
cd /tmp/arch/stage2 
ls -l 
cd /opt 
$usershell sudo git clone https://aur.archlinux.org/yay.git 
$usershell xdg-user-dirs-update
$usershell sudo chown -R $user01:users ./yay  
$usershell id $user01
cd /opt/yay
$usershell makepkg -f -s --install --noconfirm --clean  
echo $$
EOT

echo 'Installing Arch-QOL-Extras'
$chroot $usershell yay $yayflags pamac-aur
$chroot $usershell yay $yayflags libva-vdpau-driver-vp9-git
$chroot $usershell yay $yayflags protontricks
$chroot $usershell yay $yayflags nvidia-vaapi-driver 
$chroot $usershell yay $yayflags cpupower-gui
$chroot $usershell yay $yayflags mint-backgrounds 
$chroot $usershell yay $yayflags game-devices-udev 

$chroot $pacman lightdm 
$chroot $pacman lightdm-gtk-greeter 
$chroot $pacman
#$chroot $serviceoff --now gdm && 
$chroot $serviceon lightdm
#$chroot $serviceon gdm &&
#$chroot $serviceon systemctl enable sddm &&
#$chroot $serviceon openbox &&
}

function cleanupinstall(){
#Phase 5
echo 'Cleaning up' 
mkdir $rootdir/VAAPI-Chrome 
cp $installerdir/chrome-flags.conf $rootdir/VAAPI-Chrome/chrome-flags.conf 
chmod a+x $rootdir/VAAPI-Chrome/chrome-flags.conf
cp $installerdir/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop $rootdir/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop  
chmod a+x $rootdir/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop
umount -R $rootdir
}

function archdesktop(){
if $desktop="cinnamon"
installcinnamon
cleanupinstall
else if $desktop="gnome"
installgnome
cleanupinstall
else if $desktop="kde"
installkde
cleanupinstall
else if $desktop="mate"
installmate
cleanupinstall
else if $desktop="lxde"
installlxde
cleanupinstall
else if $desktop="lxqt"
installlxqt
cleanupinstall
else if $desktop="xfce"
installxfce
cleanupinstall
else echo "Something went wrong, Aborting.." && break
fi
}

function installmintarchbase(){
setusername &&
setdrive &&
setboot &&
setswap &&
setos &&
setdesktop &&
setrepo &&
setvar &&
partitioning &&
checkenv &&
archdesktop
}

installmintarchbase && reboot

##End Script
