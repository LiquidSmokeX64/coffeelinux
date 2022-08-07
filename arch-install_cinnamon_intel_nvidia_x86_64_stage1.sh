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
echo 'Copying scripts to system root' && 
cp arch-linux-installer/arch-install_cinnamon_intel_nvidia_x86_64_stage2.sh /mnt && 
chmod a+x arch-linux-installer/arch-install_cinnamon_intel_nvidia_x86_64_stage3.sh && 
chmod a+x /mnt/arch-install_cinnamon_intel_nvidia_x86_64_stage2.sh &&  
echo 'Please run the next script after typing arch-chroot /mnt'
