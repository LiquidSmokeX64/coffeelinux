#!/bin/sh
rm /mnt/arch-linux_kde_intel_nvidia_x86_64_stage2.sh && mkdir /mnt/VAAPI-Chrome && cp arch-linux-installer/chrome-flags.conf /mnt/VAAPI-Chrome/chrome-flags.conf && umount -R /mnt && chmod a+x /mnt/VAAPI-Chrome/chrome-flags.conf && reboot
