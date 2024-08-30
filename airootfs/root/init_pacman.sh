set -e

sed -i "s/#ParallelDownloads = 12/ParallelDownloads = $(nproc)/g" \
	/etc/pacman.conf

pacman-key --init


KEY=DDF7DB817396A49B2A2723F7403BD972F75D9D76
pacman-key -r "$KEY"
pacman-key --lsign-key "$KEY"

pacman -Sy archlinux-keyring --noconfirm
