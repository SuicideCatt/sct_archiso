set -e

pacman -Sy zram-generator --noconfirm

cat <<EOF > /etc/systemd/zram-generator.conf
[zram0]
zram-size = ram
compression-algorithm = zstd
EOF

systemctl enable systemd-zram-setup@zram0.service
