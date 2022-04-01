#!/bin/sh
fdisk /dev/nvme1n1 && mkfs.fat -F32 /dev/nvme1n1p1 && mkswap /dev/nvme1n1p2 && mkfs.btrfs -L arch-pc /dev/nvme1n1p3 && swapon /dev/nvme1n1p2 && mount /dev/nvme1n1p3 /mnt && mkdir /mnt/boot && mount /dev/nvme1n1p1 /mnt/boot && pacman -Syy && pacstrap /mnt base linux linux-firmware intel-ucode btrfs-progs net-tools networkmanager dhcpcd iwd vim man-pages man-db texinfo sudo nano base-devel power-profiles-daemon gstreamer && pacstrap /mnt gst-libav gst-plugins-base gst-plugins-good gst-plugins-ugly gst-plugins-bad xfce4 mousepad parole ristretto thunar-archive-plugin thunar-media-tags-plugin xfce4-battery-plugin xfce4-datetime-plugin xfce4-mount-plugin xfce4-netload-plugin xfce4-notifyd xfce4-pulseaudio-plugin xfce4-screensaver xfce4-taskmanager xfce4-wavelan-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-xkb-plugin file-roller network-manager-applet leafpad epdfview galculator lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings capitaine-cursors arc-gtk-theme xdg-user-dirs-gtk xfce4-goodies virtualbox-guest-utils xf86-video-vmware pavucontrol pulseaudio xfwm4 cpupower && pacstrap /mnt gst-plugin-pipewire lib32-pipewire lib32-pipewire-jack pipewire pipewire-alsa pipewire-jack pipewire-media-session pipewire-pulse wireplumber && genfstab -U /mnt >> /mnt/etc/fstab && cp arch-linux-installer/arch-install_xfce_intel_nvidia_x86_64_stage2.sh /mnt && cp arch-linux-installer/arch-install_xfce_intel_nvidia_x86_64_stage4.sh /mnt && chmod a+x arch-linux-installer/arch-install_xfce_intel_nvidia_x86_64_stage3.sh && chmod a+x /mnt/arch-install_xfce_intel_nvidia_x86_64_stage2.sh && chmod a+x /mnt/arch-install_xfce_intel_nvidia_x86_64_stage4.sh
