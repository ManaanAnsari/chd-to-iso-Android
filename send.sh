#!/data/data/com.termux/files/usr/bin/bash

# Function to display .chd files and get user selection
select_chd_file() {
    local download_dir="$HOME/storage/downloads"
    local chd_files=()
    
    # Find all .chd files in the downloads directory
    while IFS= read -r -d '' file; do
        chd_files+=("$(basename "$file")")
    done < <(find "$download_dir" -maxdepth 1 -type f -name "*.chd" -print0 2>/dev/null)
    
    # Check if any .chd files were found
    if [ ${#chd_files[@]} -eq 0 ]; then
        echo "[-] No .chd files found in Downloads."
        exit 1
    fi
    
    # Display the list of .chd files
    echo "Available .chd files in Downloads:"
    for i in "${!chd_files[@]}"; do
        echo "$((i+1)). ${chd_files[i]}"
    done
    
    # Get user selection
    local choice
    while true; do
        echo -n "Select a file (1-${#chd_files[@]}): "
        read -r choice
        
        # Validate the input
        if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#chd_files[@]}" ]; then
            break
        else
            echo "[-] Invalid selection. Please enter a number between 1 and ${#chd_files[@]}."
        fi
    done
    
    # Return the selected file name
    echo "${chd_files[$((choice-1))]}"
}

# Get the selected .chd file
SELECTED_CHD=$(select_chd_file)

# Define source and destination paths
SRC_CHD="$HOME/storage/downloads/$SELECTED_CHD"
DST_CHD="$HOME/../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/game.chd"

echo "[*] Copying $SELECTED_CHD to Ubuntu as game.chd ..."
cp "$SRC_CHD" "$DST_CHD"

# Also copy the convert.sh script to the Ubuntu environment
SRC_CONVERT="$(dirname "$0")/convert.sh"
DST_CONVERT="$HOME/../usr/var/lib/proot-distro/installed-rootfs/ubuntu/root/convert.sh"
echo "[*] Copying convert.sh to Ubuntu ..."
cp "$SRC_CONVERT" "$DST_CONVERT"

echo "[+] Done. Now login to Ubuntu and run ./convert.sh"