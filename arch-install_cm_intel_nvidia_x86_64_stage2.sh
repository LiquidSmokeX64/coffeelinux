#!/bin/sh
echo Setting Locale && ln -sf /usr/share/zoneinfo/Los_Angeles /etc/localtime && hwclock --systohc && echo en_US ISO-8859-1 >> /etc/locale.gen && echo en_US.UTF-8 UTF-8 >> /etc/locale.gen && echo KEYMAP=us > /etc/vconsole.conf && echo LANG=en_US.UTF-8 > /etc/locale.conf && export LANG=en_US.UTF-8 && locale-gen && echo Setting Hostname && echo arch-box > /etc/hostname && echo 127.0.0.1 localhost >> /etc/hosts && echo ::1 localhost >> /etc/hosts && echo 127.0.1.1 arch-box >> /etc/hosts && echo [multilib] >> /etc/pacman.conf && echo Include = /etc/pacman.d/mirrorlist >> /etc/pacman.conf && pacman -Syy && echo Set Root Password && passwd && echo Adding User Account && useradd -m -G wheel archuser && echo Set User Password && passwd archuser && echo Set User in Sudoers file && EDITOR=nano visudo && mkinitcpio -P && echo Installing Bootloader && bootctl install && echo default arch.conf > /boot/loader/loader.conf && echo timeout 1 >> /boot/loader/loader.conf && echo console-mode max >> /boot/loader/loader.conf && echo editor no >> /boot/loader/loader.conf && echo title Arch-Linux > /boot/loader/entries/arch.conf && echo linux /vmlinuz-linux >> /boot/loader/entries/arch.conf && echo initrd /intel-ucode.img >> /boot/loader/entries/arch.conf && echo initrd /initramfs-linux.img >> /boot/loader/entries/arch.conf && echo options root="LABEL=arch-pc" rw nvidia-drm.modeset=1 >> /boot/loader/entries/arch.conf && echo Installing Drivers and dependencies && pacman -S git xdg-utils gettext && pacman -S xorg xorg-server xorg-apps && pacman -S virtualbox-guest-utils xf86-video-vmware nvidia nvidia-utils nvidia-settings && systemctl enable gdm && systemctl enable dhcpcd && systemctl enable NetworkManager && pacman -S ufw libva-utils libva-vdpau-driver neofetch wine-staging winetricks lib32-gamemode lib32-vkd3d vkd3d innoextract giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader cups samba dosbox jre-openjdk-headless jre-openjdk jdk-openjdk openjdk-doc openjdk-src && archlinux-java set java-17-openjdk && pacman -S lib32-opencl-nvidia zenity lutris discord egl-wayland steam gnome-menus polkit-gnome && pacman -S gst-plugin-pipewire lib32-pipewire lib32-pipewire-jack pipewire pipewire-alsa pipewire-jack pipewire-pulse wireplumber && pacman -Syu && echo Please type exit and run the next script
