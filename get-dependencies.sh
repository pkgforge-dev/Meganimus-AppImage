#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
# pacman -Syu --noconfirm PACKAGESHERE

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
PKGBUILD=$(
	wget https://api.github.com/repos/Kyuyrii/Meganimus/releases -O - \
	  | sed 's/[()",{} ]/\n/g' | grep -o -m 1 "https.*CachyOS.tar.gz"
)
wget "$PKGBUILD" -O /tmp/tar.gz
tar -xvf /tmp/tar.gz
cd ./Meganimus*CachyOS
make-aur-package

# If the application needs to be manually built that has to be done down here
