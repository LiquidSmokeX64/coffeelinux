#!/bin/sh
sudo git clone https://aur.archlinux.org/yay.git && sudo chown -R archuser:users ./yay && id archuser && cd yay && makepkg -si && cd && yay nvidia-vaapi-driver && yay pamac-aur && yay libva-vdpau-driver-vp9-git && yay google-chrome && yay protontricks
