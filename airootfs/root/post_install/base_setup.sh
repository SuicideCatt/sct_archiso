set -e

hwclock --systohc

locale-gen
nvim /etc/locale.gen
locale-gen

printf "Enter hostname: "
read hostname
echo "$hostname" > /etc/hostname

echo "Set password for root"
passwd

systemctl enable NetworkManager
