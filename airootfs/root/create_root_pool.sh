set -e

# https://codeberg.org/okhsunrog/arch_sway/src/branch/main/install_arch.sh
mkdir -p /etc/zfs/
read -p "Enter ZFS encryption password: " -s zfspass
echo "$zfspass" > "/etc/zfs/$1.key"
chmod 000 "/etc/zfs/$1.key"

sync

zpool create -f -o ashift=12 -O acltype=posixacl -O relatime=on \
	-O xattr=sa -o autotrim=on -O dnodesize=auto -O normalization=formD \
	-O devices=off -O compression=lz4 -O encryption=aes-256-gcm \
	-O keyformat=passphrase -O keylocation="file:///etc/zfs/$1.key" \
	-m none $@

sync

zfs create -o mountpoint=none "$1/home"
zfs create -o mountpoint=none "$1/ROOT"
zfs create -o mountpoint=/ -o canmount=noauto "$1/ROOT/archlinux"

zfs create -o mountpoint=/root "$1/home/root"
zfs create -o mountpoint=/home "$1/home/users"

zfs create -o mountpoint=/var -o canmount=off "$1/var"
zfs create "$1/var/log"
zfs create "$1/var/lib"
zfs create "$1/var/cache"

zfs create "$1/var/lib/AccountsService"
zfs create "$1/var/lib/NetworkManager"

MOUNT="/mnt/install"

zpool set bootfs="$1/ROOT/archlinux" "$1"
zpool export "$1"
zpool import -N -R "$MOUNT" "$1"
zfs load-key "$1"
zfs mount "$1/ROOT/archlinux"
zfs mount -a

zpool set cachefile=/etc/zfs/zpool.cache "$1"

mkdir -p "$MOUNT/etc/zfs/"

cp /etc/zfs/zpool.cache "$MOUNT/etc/zfs/zpool.cache"
echo $(hostid) > "$MOUNT/etc/hostid"
cp "/etc/zfs/$1.key" "$MOUNT/etc/zfs/$1.key"

echo New system mounted to "$MOUNT"
echo Key in "$MOUNT/etc/zfs/$1.key"
echo Cache in "$MOUNT/etc/zfs/zpool.cache"

# Help:
# First arg: Pool name
# Other args: Pool disks
