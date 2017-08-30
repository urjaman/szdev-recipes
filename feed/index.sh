#!/bin/sh
export TERM=vt100
opkg-make-index . > Packages
gzip -9 < Packages > Packages.gz
