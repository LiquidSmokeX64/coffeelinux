#!/bin/sh
rm arch-linux_intel_nvidia_x86_64_stage2.sh && mkdir /mnt/VAAPI-Chrome && cp /Guides-Scripts/chrome-flags.conf /mnt/VAAPI-Chrome/chrome-flags.conf && umount -R /mnt && reboot
