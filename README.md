# Coffee-Linux (Script-Installed Arch-Linux for Gamers)
[Description]
Key Features: Arch-Based, BTRFS installation, Hybridized Desktop Environment/s, Pipewire, VAAPI on Chrome (with game streaming in mind), FirewallD, and SystemD-Boot.

A script designed to install a unique Coffee-Linux Experience via Arch easily, and semi painlessly.
(vaapi chrome-flags.conf and premade Stadia app are located in /opt folder. place chrome-flags.conf in ~/.config/ folder, and the stadia app file in ~/.local/share/applications/ folder. and reboot after launching chrome and it fails once. Enjoy.)
This Installer will create an Coffee-Linux install.

Features: 
1. Pure Arch foundation using official repos (and a little AUR here and there)
2. A Cinnamon/Gnome Desktop Environment (Always the latest version)
4. Linux Mint Themes, Sounds, Icons, and Backgrounds.
5. Pamac Graphical Software Manager (Select "1 4" in part 4 when prompted for pamac-aur for full functionality)
6. Chrome Preinstalled via AUR (not Firefox)
8. Latest Pipewire & Wireplumber for the best possible sound.
9. Many gaming frameworks preinstalled so you can get to it right away.
10. Prebuilt with Steam, Wine, Winetricks, Protontricks, and DXVK for the best possible gaming experiences out of the box.
11. SystemD boot (as opposed to GRUB).
12. Yay for CLI installation of AUR applications.
13. FirewallD (Better configuration than the standard one)

Note: This is designed for PCs with UEFI, Intel CPUs, and Nvidia GPUs, AMD install WILL LIKELY fail because absolutely no AMD specific packages are installed.

Note-3: You will have to use fdisk to prepare your drive during installation.

Instructions are as follows: For most things you just answer yes to if asked as I have already prepared everything in a certain order for your convenience.

1: Boot an official Arch Linux ISO in UEFI mode.

2: Enter: pacman -Syy

3: Enter: pacman -Syy --noconfirm archlinux-keyring

4: Enter: pacman -S --noconfirm git

5: Enter: git clone https://liquidsmokex64/arch-linux-installer.git

6: Enter: bash /arch-linux-installer/coffeebrewer.sh

7: Follow the prompts as needed. (mostly just password prompts and confirmation/overwrite dialogues lol)

That should finish it off for you. Enjoy your Coffee. Spread the word! Coffee is hot over here.

Hashtags:
#GamingOnLinux #ArchGaming #SteamLinux #ArchInstaller #CoffeeLinux
