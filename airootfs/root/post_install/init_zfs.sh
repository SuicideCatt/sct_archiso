set -e

KEY=DDF7DB817396A49B2A2723F7403BD972F75D9D76
pacman-key -r "$KEY"
pacman-key --lsign-key "$KEY"

pacman -Sy

zpool set cachefile=/etc/zfs/zpool.cache "$1"
systemctl enable zfs-import-cache.service zfs-mount.service
systemctl enable zfs-import.target zfs.target

zfs set org.zfsbootmenu:commandline="spl.spl_hostid=$(hostid) rw" "$1/ROOT"
zfs set org.zfsbootmenu:keysource="$1/ROOT/archlinux" "$1"

# Help:
# First arg: Pool name
