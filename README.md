# Daxi-Linux-Installer
[Description]

A set of scripts designed to install a unique Arch Linux easily, and semi painlessly.

This Installer will create an Arch-Linux install that is a little different than usual, but in a good way.

Features: 
1. Pure Arch foundation using official repos (and a little AUR)
2. Cinnamon Desktop Environment. (Always the latest version)
3. GDM with Mutter Window Manager. (As opposed to the typical LightDM with Muffin WM).
4. Linux Mint Themes, Icons, and Backgrounds (In part 4).
5. Pamac Graphical Software Manager (Select "1 4" in part 4 when prompted for pamac-aur for full functionality)
6. Chromium Preinstalled (not Firefox)
7. Hardware Accelerated VP9 & H.264 in Chromium (with the provided config file / flags)
8. Latest Pipewire for the best possible sound.
9. Many gaming frameworks preinstalled so you can get to it right away.
10. Prebuilt with Steam (Native), Lutris, Wine, Winetricks, Protontricks, and DXVK for the best possible gaming experiences out of the box.


Note: You will need to create a new user on first login, and add it to all groups except root, nobody, and nogroup, then relogin with it (Cinnamon Session). 

Note-2: This is designed for PCs with UEFI, Intel CPUs, and Nvidia GPUs, AMD install WILL LIKELY fail because absolutely no AMD specific packages are installed.

Note-3: VAAPI-Chrome files are placed in /home/shared/VAAPI-Chrome folder.

Note-4: Ctrl+S will save while using nano editor, Ctrl+x will exit.

Instructions are as follows: For most things you just answer yes to if asked as I have already prepared everything in a certain order for your convenience.

1: Boot an official Arch Linux ISO in UEFI mode.

2: Enter: pacman -Syy

3: Enter: pacman -S git

4: Enter: git clone https://liquidsmokex64/arch-linux-installer.git

5: Enter: chmod a+x /arch-linux-installer/arch-install_cinnamon_intel_nvidia_x86_64_stage1.sh

6: Enter: nano /arch-linux-installer/arch-install_cinnamon_intel_nvidia_x86_64_stage1.sh

7: Edit the "/dev/nvme1n1pX.." parts to your desired hard drive partition ids (do not change the partition number though. You need the 3 in a specific order for the installation to succeed ie: nvme1n1p2 = partition 2 = Linux Swap and so on, then change "arch-pc" to your OS Drive name of choice (you will need to remember it for stage 2).

8: Enter: nano /arch-linux-installer/arch-install_cinnamon_intel_nvidia_x86_64_stage2.sh

9: Edit "arch-box" to whatever you want the PC name to be in 2 places. Change "archuser" to your username as well in 2 places. Change "arch-pc" to the name you chose in the stage 1 script. Save and exit

10: Enter: nano /arch-linux-installer/arch-install_cinnamon_intel_nvidia_x86_64_stage4.sh

11: Edit "archuser" to your username in 2 places. Save and exit.

12: Enter: bash /arch-linux-installer/arch-install_cinnamon_intel_nvidia_x86_64_stage1.sh

13: Enter: g

14: Enter: n

15: Enter: [enter] twice, +1G

16: Enter: n

17: Enter: [enter] twice, +16G (you can add more here but its up to you)

18: Enter: n

19: Enter: [enter] 3x times

20: Enter: t

21: Enter: 1 then 1 again

22: Enter: t

23: Enter: 2 then 19

24: Enter: w

25: Enter: arch-chroot /mnt

26: Enter: bash /arch-linux-installer/arch-install_cinnamon_intel_nvidia_x86_64_stage2.sh

27: When the nano page appears after awhile, scroll down with arrow keys and remove the "#" from in front of the %wheel ALL=(ALL) ALL part, Ctrl+S,Ctrl+X to save and exit.

28: After Stage 2 finishes, enter: exit

29: Enter: bash /arch-linux-installer/arch-install_cinnamon_intel_nvidia_x86_64_stage3.sh

30: After first login, Enter: cd /

31: Enter: bash /arch-linux-installer/arch-install_cinnamon_intel_nvidia_x86_64_stage4.sh

That should finish it off for you. Enjoy your new DaxiLinux
