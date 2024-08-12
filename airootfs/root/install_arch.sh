set -e

pacstrap -K $@ base base-devel pkgs/linux-zen zfs-linux-zen \
	neovim git networkmanager yay

echo copy ~/post_install to "$1/"
cp -r ~/post_install "$1/"

echo copy pacman conf
cat /etc/pacman.conf | head -n -6 > "$1/etc/pacman.conf"

echo copy pacman poland mirrorlist
cp /etc/pacman.d/mirrorlist_poland "$1/etc/pacman.d/mirrorlist_poland"

echo > arch-chroot "$1"
arch-chroot "$1"

# Help:
# First arg: Mounted system path
# Other args: Packages
