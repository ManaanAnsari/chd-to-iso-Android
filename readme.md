# CHD to ISO Converter for Android

## Overview

This project provides a streamlined workflow for converting CHD (MAME Compressed Hunks of Data) files to ISO format directly on an Android device. This method is primarily intended for playing PlayStation 2 games on Android, as there's currently no native Android application capable of converting CHD to ISO. It's a workaround that leverages Termux and PRoot-Distro to run necessary Linux tools (`chdman` and `bchunk`) within an Ubuntu environment on your Android device.

## Prerequisites

- Android device (Android 7+ recommended)
- Sufficient free storage for CHD and resulting ISO files
- A CHD file placed in your device's Downloads folder

## Setup & Conversion Steps

Follow these steps to perform the conversion:

1. **Install Termux**
   - Download and install Termux from the official GitHub releases page.

2. **Initial Setup**
   ```bash
   pkg update && pkg upgrade -y
   termux-setup-storage
   pkg install -y coreutils git proot-distro
   ```

3. **Clone the Repository**
   ```bash
   git clone <repository_url> # Replace with your actual repository URL
   cd <repository_directory> # Navigate to the cloned directory
   ```

4. **Prepare Scripts**
   - Ensure all `.sh` files have execute permissions:
   ```bash
   chmod +x *.sh
   ```

5. **Run Conversion Workflow**
   - **Step 1: Send CHD**
     ```bash
     ./send.sh
     ```
     The script will list all `.chd` files found in your Downloads folder and prompt you to select one. It will then copy the selected file to the Ubuntu environment as `game.chd` and also transfer the `convert.sh` script.
   
   - **Step 2: Convert (in Ubuntu)**
     - First, install the Ubuntu distribution (if not already done):
       ```bash
       proot-distro install ubuntu
       ```
     - Login to the Ubuntu environment:
       ```bash
       proot-distro login ubuntu
       ```
     - Inside the Ubuntu environment, install required tools:
       ```bash
       apt update
       apt install -y mame-tools bchunk
       ```
     - Run the conversion script:
       ```bash
       ./convert.sh
       ```
     - Exit the Ubuntu environment:
       ```bash
       exit
       ```
   
   - **Step 3: Fetch ISO**
     ```bash
     ./fetch.sh
     ```
     The resulting `game.iso` will be available in your Downloads folder.

## Notes

- This process assumes you have followed the initial Termux setup correctly, including granting storage permissions.
- The scripts are designed to work with files named `game.chd` and `game.iso` internally. The `send.sh` script handles renaming your source file.
- Make sure your Android device has enough space for both the CHD and ISO files, as they can be several gigabytes in size.
