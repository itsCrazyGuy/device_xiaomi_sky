#!/bin/bash
#Vendor Setup Script
echo "Setting up repositories for Redmi 12 5G / Poco M6 Pro 5G (sky)..."

# Clone BCR repository
echo "Cloning BCR repository..."
rm -rf vendor/bcr && rm -rf vendor/extras/bcr && git clone https://github.com/anonytry/android_vendor_bcr.git vendor/bcr

# Clone the kernel source
echo "Cloning kernel repository..."
git clone https://github.com/anonytry/kernel_xiaomi_sky.git -b ksun kernel/xiaomi/sky
git clone https://github.com/anonytry/kernel_xiaomi_sky-modules.git kernel/xiaomi/sm8450-modules

# Clone the vendor source
echo "Cloning vendor repository..."
git clone https://github.com/anonytry/vendor_xiaomi_sky.git vendor/xiaomi/sky

# Clone the firmware source
#echo "Cloning firmware repository..."
#git clone https://codeberg.org/askthekaif/android_vendor_xiaomi_sky-firmware-af.git -b OS2.0.9.0.VMWEUXM vendor/xiaomi/sky-firmware

# Clone the dolby repository
echo "Cloning dolby hardware repository..."
git clone https://github.com/anonytry/android_hardware_dolby.git hardware/dolby

# Clone the hardware repository
echo "Cloning hardware repository..."
git clone https://github.com/anonytry/android_hardware_xiaomi.git hardware/xiaomi
rm -rf hardware/xiaomi/dolby

echo "Setup complete. Repositories are ready."

echo "Completed, proceeding to lunch"
