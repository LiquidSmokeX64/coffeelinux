# Linux Mint "Alpine" (Unofficial Arch-Based, Script-Installed Distro for Gamers)
[Description]

A script designed to install a unique Linux Mint Experience via Arch Linux easily, and semi painlessly.

[This is unffocial currently, and has no actual affiliation with Arch Linux or Linux Mint. Ours is slightly different in a few ways]

This Installer will create an Arch-Linux install that is a little different than usual, but in a good way.

Features: 
1. Pure Arch foundation using official repos (and a little AUR here and there)
2. Cinnamon Desktop Environment. (Always the latest version)
4. Linux Mint Themes, Sounds, Icons, and Backgrounds.
5. Pamac Graphical Software Manager (Select "1 4" in part 4 when prompted for pamac-aur for full functionality)
6. Chromium Preinstalled (not Firefox)
8. Latest Pipewire for the best possible sound.
9. Many gaming frameworks preinstalled so you can get to it right away.
10. Prebuilt with Steam (Native), Lutris, Wine, Winetricks, Protontricks, and DXVK for the best possible gaming experiences out of the box.
11. SystemD boot (as opposed to GRUB)
12. Many useful applications preinstalled (Games,Utilities,etc), and some just to have a bit of everything.
14. Yay for CLI installation of AUR applications.
15. Emulators galore, including Virtual Machine applications.
16. LibreOffice among other office type applications.
17. FirewallD (Better configuration than the standard one)
18. Lots of Multimedia Support, Photo Editing, and other tools to do a wide range of tasks.
19. Many Development geared applications.
20. And a handfull of carfully selected additional applications just for fun, and exploration of new things.

Key Features: Arch-Based, BTRFS installation, Pipewire, GDM/Mutter, VAAPI on Chrome (with game streaming in mind), FirewallD, and SystemD-Boot.

Note: This is designed for PCs with UEFI, Intel CPUs, and Nvidia GPUs, AMD install WILL LIKELY fail because absolutely no AMD specific packages are installed.

Note-3: You will have to use fdisk to prepare your drive during installation.

Instructions are as follows: For most things you just answer yes to if asked as I have already prepared everything in a certain order for your convenience.

1: Boot an official Arch Linux ISO in UEFI mode.

2: Enter: pacman -Syy

3: Enter: pacman -S git

4: Enter: git clone https://liquidsmokex64/arch-linux-installer.git

6: Enter: bash /arch-linux-installer/arch-install_cinnamon_intel_nvidia_x86_64_stage1.sh

7: Enter: g

8: Enter: n

9: Enter: [enter] twice, +1G

10: Enter: n

11: Enter: [enter] twice, +16G (you can add more here but its up to you)

12: Enter: n

13: Enter: [enter] 3x times

14: Enter: t

15: Enter: 1 then 1 again

16: Enter: t

17: Enter: 2 then 19

18: Enter: w

That should finish it off for you. Enjoy your new Linux Mint "Alpine"
