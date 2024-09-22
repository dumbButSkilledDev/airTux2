#!/bin/bash

# build kernel script for the ipad air 2.
# this is designed to run, but we all know how that goes.

function displayBanner {
    echo "============= $1 ============="
}

displayBanner "AirTux Kernel Build Script"
# peak humor
echo "   Gotta love the ewast... wonderfull hardeware of the ipad air 2"

sudo apt-get update
sudo apt-get install -y clang bison flex libssl-dev libelf-dev bc libncurses5-dev
git clone https://github.com/konradybcio/linux-apple
cd linux-apple
wget https://raw.githubusercontent.com/SoMainline/linux-apple-resources/master/example.config -O ./.config
make ARCH=arm64 LLVM=1 menuconfig
make ARCH=arm64 LLVM=1 -j$(nproc) Image.lmza dtbs

echo "Kernel build complete, but since were here, lets pack the dtbs!"
wget https://raw.githubusercontent.com/SoMainline/linux-apple-resources/master/dtbpack.sh
chmod +x dtbpack.sh
./dtbpack.sh
echo "Done! copying bins..."
mkdir -p ../bin
cp arch/arm64/boot/Image.lmza ../bin/
cp dtbpack ../bin
echo "Done! Kernel build complete!"
