#!/bin/bash

CSV_FILE="/home/hooregi/halofiles/.bootstrap/pkgs.csv"
CSV_PACKAGES=$(tail -n +2 "$CSV_FILE" | cut -d, -f2)
INSTALLED_PACKAGES=$(pacman -Qe | awk '{print $1}')

for package in $CSV_PACKAGES; do
  if ! grep -q "^$package$" <<<"$INSTALLED_PACKAGES"; then
    echo "Package $package from CSV is not installed."
  fi
done

for package in $INSTALLED_PACKAGES; do
  if ! grep -q "^$package$" <<<"$CSV_PACKAGES"; then
    echo "Package $package is installed but not in CSV."
  fi
done
