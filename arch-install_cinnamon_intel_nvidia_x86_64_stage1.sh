#!/bin/sh
echo Enable MultiLib && echo [multilib] >> /etc/pacman.conf && echo Include = /etc/pacman.d/mirrorlist >> /etc/pacman.conf && echo Partition the Disk && fdisk /dev/nvme0n1 && echo Formatting Partitions && mkfs.fat -F32 /dev/nvme0n1p1 && mkswap /dev/nvme0n1p2 && mkfs.btrfs -L arch-pc /dev/nvme0n1p3 && echo Mounting Disks && swapon /dev/nvme0n1p2 && mount /dev/nvme0n1p3 /mnt && mkdir /mnt/boot && mount /dev/nvme0n1p1 /mnt/boot && echo Installing Base System && pacman -Syy  && pacman -S archlinux-keyring && pacstrap /mnt base linux linux-firmware intel-ucode btrfs-progs net-tools networkmanager dhcpcd iwd vim man-pages man-db texinfo sudo nano base-devel intel-ucode gstreamer systemd && echo Installing Desktop Environment && pacstrap /mnt ntp gst-libav gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad cinnamon lightdm gnome-terminal lightdm-gtk-greeter gedit gnome-system-monitor xed xreader vlc gnome-keyring cinnamon-translations pulseaudio archlinux-wallpaper qt6 gtk4 udev dbus cpupower && echo Creating Links && genfstab -U /mnt >> /mnt/etc/fstab && echo Copying scripts to system root && cp arch-linux-installer/arch-install_cinnamon_intel_nvidia_x86_64_stage2.sh /mnt && cp arch-linux-installer/arch-install_cinnamon_intel_nvidia_x86_64_stage4.sh /mnt && chmod a+x arch-linux-installer/arch-install_cinnamon_intel_nvidia_x86_64_stage3.sh && chmod a+x /mnt/arch-install_cinnamon_intel_nvidia_x86_64_stage2.sh && chmod a+x /mnt/arch-install_cinnamon_intel_nvidia_x86_64_stage4.sh && echo Please run the next script after typing arch-chroot /mnt
