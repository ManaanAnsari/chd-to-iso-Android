#!/bin/bash

# Verify tools
for tool in chdman bchunk; do
  if ! command -v $tool &>/dev/null; then
    echo "[-] $tool not installed. Run: apt update && apt install mame-tools bchunk"
    exit 1
  fi
done

if [ ! -f ~/game.chd ]; then
  echo "[-] game.chd not found in /root"
  exit 1
fi

echo "[*] Extracting game.chd..."
chdman extractcd -i game.chd -o game.cue -ob game.bin

echo "[*] Converting BIN/CUE to ISO..."
bchunk game.bin game.cue game.iso

echo "[+] Conversion complete: game.iso"