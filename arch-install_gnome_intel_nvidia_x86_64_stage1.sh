#!/bin/sh
fdisk /dev/nvme1n1 && mkfs.fat -F32 /dev/nvme1n1p1 && mkswap /dev/nvme1n1p2 && mkfs.btrfs -L arch-pc /dev/nvme1n1p3 && swapon /dev/nvme1n1p2 && mount /dev/nvme1n1p3 /mnt && mkdir /mnt/boot && mount /dev/nvme1n1p1 /mnt/boot && pacman -Syy && pacstrap /mnt base linux linux-firmware intel-ucode btrfs-progs net-tools networkmanager dhcpcd iwd vim man-pages man-db texinfo sudo nano base-devel intel-ucode power-profiles-daemon && pacstrap /mnt gst-libav gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad gnome gnome-extra gnome-themes-extra pulseaudio && genfstab -U /mnt >> /mnt/etc/fstab && cp arch-linux-installer/arch-install_gnome_intel_nvidia_x86_64_stage2.sh /mnt && cp arch-linux-installer/arch-install_gnome_intel_nvidia_x86_64_stage4.sh /mnt && chmod a+x arch-linux-installer/arch-install_gnome_intel_nvidia_x86_64_stage3.sh && chmod a+x /mnt/arch-install_gnome_intel_nvidia_x86_64_stage2.sh && chmod a+x /mnt/arch-install_gnome_intel_nvidia_x86_64_stage4.sh
