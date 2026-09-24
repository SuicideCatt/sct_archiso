set -e

hwclock --systohc

locale-gen
nvim /etc/locale.gen
locale-gen

echo 'LANG="C.UTF-8"' > /etc/locale.conf
nvim /etc/locale.conf

printf "Enter hostname: "
read hostname
echo "$hostname" > /etc/hostname

echo "Set password for root"
passwd

systemctl enable NetworkManager
