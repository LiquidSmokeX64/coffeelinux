echo 'Cleaning up' && 
rm /mnt/arch-install_cinnamon_intel_nvidia_x86_64_stage2.sh && 
mkdir /mnt/VAAPI-Chrome && 
cp arch-linux-installer/chrome-flags.conf /mnt/VAAPI-Chrome/chrome-flags.conf && 
chmod a+x /mnt/VAAPI-Chrome/chrome-flags.conf && 
cp arch-linux-installer/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop /mnt/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop && 
chmod a+x /mnt/VAAPI-Chrome/chrome-pnkcfpnngfokcnnijgkllghjlhkailce-Default.desktop && 
umount -R /mnt && reboot
