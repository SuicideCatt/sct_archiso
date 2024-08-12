set -e

PKGS=pkgs/x86_64

rm $PKGS/pkgs.*

ARCHIVE=https://archive.archlinux.org/packages

KPACK=linux-zen-6.9.7.zen1-1-x86_64.pkg.tar.zst
KURL="$ARCHIVE/l/linux-zen/$KPACK"

rm $PKGS/linux*.zst
curl -o "$PKGS/$KPACK" -L "$KURL"

sed 's/ParallelDownloads = 12/ParallelDownloads = $(nproc)/g' \
	pacman.conf.bak > pacman.conf
echo "Server = file://$(pwd)/\$repo/\$arch/" >> pacman.conf

cd "$PKGS"
repo-add pkgs.db.tar.zst *.zst
