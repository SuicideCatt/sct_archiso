set -e

sed -i "s/#ParallelDownloads = 12/ParallelDownloads = $(nproc)/g" \
	/etc/pacman.conf

pacman-key --init
pacman -Sy --noconfirm
pacman -Sy archlinux-keyring --noconfirm
