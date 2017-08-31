#!/bin/bash
set -e
shopt -s nullglob

do_build() {
	makepnd --config ../autobuild-makepnd.conf
	if [ $(echo *.ipk | wc -w) -eq 0 ]; then
		echo "No .ipk generated?"
		exit 1
	fi
	cp -v *.ipk ../feed/
	# Still at the same "cd" level, so ok :P.
	cd ../feed/
	# Regenerate the feed index
	./index.sh
}

# git: We autobuild only committed things, not WIP hacks
for d in $(git ls-tree -d --name-only HEAD); do
	[ ! -f $d/PNDBUILD ] && continue
	if [ $(echo $d/*.ipk | wc -w) -ne 0 ]; then
		echo "$d is already built"
		continue
	fi
	echo "Trying to build $d"
	cd $d
	do_build
	cd ..
done


