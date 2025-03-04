PKGS=pkgs/x86_64

rm $PKGS/pkgs.*

ARCHIVE=https://archive.archlinux.org/packages

KPACK=linux-zen-6.12.9.zen1-1-x86_64.pkg.tar.zst
KURL="$ARCHIVE/l/linux-zen/$KPACK"

KHPACK=linux-zen-headers-6.12.9.zen1-1-x86_64.pkg.tar.zst
KHURL="$ARCHIVE/l/linux-zen-headers/$KHPACK"

rm $PKGS/linux*.zst
curl -o "$PKGS/$KPACK" -L "$KURL"
curl -o "$PKGS/$KHPACK" -L "$KHURL"

sed "s/ParallelDownloads = .*/ParallelDownloads = $(nproc)/g" \
	pacman.conf.bak > pacman.conf
cp pacman.conf airootfs/etc/pacman.conf

echo "Server = file://$(pwd)/\$repo/\$arch" >> pacman.conf
echo "Server = file:///\$repo/\$arch" >> airootfs/etc/pacman.conf

cd "$PKGS"
repo-add pkgs.db.tar.zst *.zst
