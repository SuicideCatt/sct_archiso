set -e

sed -i 's/#ParallelDownloads = 12/ParallelDownloads = $(nproc)/g' \
	/etc/pacman.conf

pacman -Sy --noconfirm
pacman -Sy archlinux-keyring --noconfirm
