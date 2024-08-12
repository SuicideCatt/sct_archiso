set -e

cat <<EOF > /etc/mkinitcpio.conf
MODULES=""
BINARIES=""
FILES="/etc/zfs/$1.key"
HOOKS="base udev autodetect modconf block keyboard zfs filesystems"
COMPRESSION="zstd"
EOF

cat <<EOF > /etc/mkinitcpio.d/linux-zen.preset
ALL_kver="/boot/vmlinuz-linux-zen"
PRESETS=('default')
default_image="/boot/initramfs-linux-zen.img"
EOF

mkinitcpio -P

# Help:
# First arg: Pool name
