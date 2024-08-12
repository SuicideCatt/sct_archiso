set -e

mkfs.fat -I -F32 $1 

mkdir -p "$2/boot/efi"
mount $1 "$2/boot/efi"

ZBM_PATH="$2/boot/efi/EFI/ZBM"
mkdir -p "$ZBM_PATH"
curl -o "$ZBM_PATH/VMLINUZ.EFI" -L https://get.zfsbootmenu.org/efi

efibootmgr -c -d "$1" -L "ZFSBootMenu" -l \\EFI\\ZBM\\VMLINUZ.EFI

# FIXME
genfstab -U "$2" | grep "UUID" > "$2/etc/fstab"

# Help:
# First arg: path to disk patition, idk sorry, my anglend wery bed
# 			 i recommend use /dev/disk/by-id/YOUR_DISK
# 			 	or /dev/disk/by-uuid/YOUR_DISK
# 			 ls -lsa /dev/disk/by-id
# 			 ls -lsa /dev/disk/by-uuid
# Second arg: Mounted system path
