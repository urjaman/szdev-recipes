#!/bin/bash
# This is a little hack of a script to load the big git repos from outside dchrt
# by just abusing makepkg
set -e
set -x

MAKEPKG=makepkg

for d in gcc-new binutils; do
	cd $d
	$MAKEPKG -A -d -o -p PNDBUILD
	cd ..
done
