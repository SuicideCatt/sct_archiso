set -e

sudo mkarchiso -v -w /tmp/archiso -o . .
sudo rm -r /tmp/archiso
