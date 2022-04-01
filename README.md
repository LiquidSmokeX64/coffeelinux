# arch-linux-installer
[Description]

A set of scripts designed to install Arch Linux with Gnome Desktop easily, and semi painlessly.

Note: You will need to edit these scripts for your system slightly. 

Note-2: This is designed for PCs with UEFI, Intel CPUs, and Nvidia GPUs, AMD install WILL fail because absolutely no AMD packages are installed.

Instructions are as follows: 

1: Boot the Arch Linux ISO in UEFI mode.

2: Enter: pacman -Syy

3: Enter: pacman -S git

4: Enter: git clone https://liquidsmokex64/arch-linux-installer.git

5: Enter: chmod a+x /arch-linux-installer/arch-install_intel_nvidia_x86_64_stage1.sh

6: Enter: nano /arch-linux-installer/arch-install_intel_nvidia_x86_64_stage1.sh

7: Edit the "/dev/nvme.." parts to your desired hard drive partition ids, change "arch-pc" to your OS Drive name of choice (you will need to remember it for stage 2).

8: Enter: nano /arch-linux-installer/arch-install_intel_nvidia_x86_64_stage2.sh

9: Edit "arch-box" to whatever you want the PC name to be. Change "archuser" to your username, change "usernamehere" to your username as well.

10: Enter: bash /arch-linux-installer/arch-install_intel_nvidia_x86_64_stage1.sh

11: Enter: g

12: Enter: n

13: Enter: [enter] twice, +1G

14: Enter: n

15: Enter: [enter] twice, +16G (you can add more here but its up to you)

16: Enter: n

17: Enter: [enter] 3x times

18: Enter: t

19: Enter: 1 then 1 again

20: Enter: t

21: Enter: 1 then 19

22: Enter: w

23: When s nano page appears after awhile, scroll down with arrow keys and remove the "#" from in front of the %wheel ALL=(ALL) ALL part, Ctrl+S,Ctrl+X to save and exit.

24: After stage 2 finishes it should exit automatically.

25: Enter: bash /arch-linux-installer/arch-install_intel_nvidia_x86_64_stage3.sh

That should finish it off and reboot for you. Enjoy your new Arch Linux (Gnome)
