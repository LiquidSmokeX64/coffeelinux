# arch-linux-installer
[Description]

A set of scripts designed to install Arch Linux easily, and semi painlessly.

Note: You will need to edit these scripts for your system slightly. 

Note-2: This is designed for PCs with UEFI, Intel CPUs, and Nvidia GPUs, AMD install WILL fail because absolutely no AMD packages are installed.

Note-3: VAAPI-Chrome files are placed in /VAAPI-Chrome folder. I also re-enable VP9 support on Nvidia Cards and enable Pipewire.

Note-4: Ctrl+S will save while using nano editor, Ctrl+x will exit.

Instructions are as follows: For most things you just answer yes to if asked as I have already prepared everything in a certain order for your convenience.

1: Boot the Arch Linux ISO in UEFI mode.

2: Enter: pacman -Syy

3: Enter: pacman -S git

4: Enter: git clone https://liquidsmokex64/arch-linux-installer.git

5: Enter: chmod a+x /arch-linux-installer/arch-install_xyz_intel_nvidia_x86_64_stage1.sh

6: Enter: nano /arch-linux-installer/arch-install_xyz_intel_nvidia_x86_64_stage1.sh

7: Edit the "/dev/nvme1n1pX.." parts to your desired hard drive partition ids (do not change the partition number though. You need the 3 in a specific order for the installation to succeed ie: nvme1n1p2 = partition 2 = Linux Swap and so on, then change "arch-pc" to your OS Drive name of choice (you will need to remember it for stage 2).

8: Enter: nano /arch-linux-installer/arch-install_xyz_intel_nvidia_x86_64_stage2.sh

9: Edit "arch-box" to whatever you want the PC name to be in 2 places. Change "archuser" to your username as well in 2 places. Change "arch-pc" to the name you chose in the stage 1 script. Save and exit

10: Enter: nano /arch-linux-installer/arch-install_xyz_intel_nvidia_x86_64_stage4.sh

11: Edit "archuser" to your username in 2 places. Save and exit.

12: Enter: bash /arch-linux-installer/arch-install_xyz_intel_nvidia_x86_64_stage1.sh

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

26: Enter: bash /arch-linux-installer/arch-install_xyz_intel_nvidia_x86_64_stage2.sh

27: When the nano page appears after awhile, scroll down with arrow keys and remove the "#" from in front of the %wheel ALL=(ALL) ALL part, Ctrl+S,Ctrl+X to save and exit.

28: After Stage 2 finishes, enter: exit

29: Enter: bash /arch-linux-installer/arch-install_xyz_intel_nvidia_x86_64_stage3.sh

30: After first login, Enter: cd /

31: Enter: bash /arch-linux-installer/arch-install_xyz_intel_nvidia_x86_64_stage4.sh

That should finish it off for you. Enjoy your new Arch Linux
