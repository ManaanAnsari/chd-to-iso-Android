#!/data/data/com.termux/files/usr/bin/bash

SRC="$HOME/../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/game.iso"
DST="$HOME/storage/downloads/game.iso"

if [ ! -f "$SRC" ]; then
  echo "[-] No ISO found in Ubuntu root"
  exit 1
fi

echo "[*] Copying game.iso back to Downloads..."
cp "$SRC" "$DST"

echo "[*] Cleaning up temporary files..."
rm -f $HOME/../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/game.*

echo "[+] Done. ISO available in Downloads as game.iso"