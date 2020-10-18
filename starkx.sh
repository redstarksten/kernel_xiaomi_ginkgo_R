#!/usr/bin/env bash
CONFIG=vendor/ginkgo-perf_defconfig
EXTRA=$HOME/Extra
START=$(date +"%s")
tanggal=$(TZ=Asia/Jakarta date '+%Y%m%d'-'%H%M')
KERNEL_DIR=$HOME/A11
KERNEL_NAME=StarkX
KERNEL_VERSION=$(make kernelversion)
DEVICE=Ginkgo
ZIPNAME=${KERNEL_NAME}-${DEVICE}-${tanggal}
IMG_DIR=${KERNEL_DIR}/out/arch/arm64/boot/Image.gz-dtb
ANY_DIR=${EXTRA}/Anykernel
ANY_IMG=${ANY_DIR}/Image.gz-dtb
DTB=${KERNEL_DIR}/out/arch/arm64/boot/dts/qcom/*.dtb
SIGNER_DIR=${EXTRA}/signer
PAGES_DIR=${EXTRA}/redstarksten.github.io
LOG_DIR=${PAGES_DIR}/build_log/${tanggal}-log.txt
log="https://redstarksten.github.io/build_log/${tanggal}-log.txt"

function check() {
	echo -e ""
	echo -e "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
	echo -e "Extra Checker..."
	echo -e "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
	echo -e ""

    if ! [[ -d ${ANY_DIR} ]]; then
      	cd ..${EXTRA}
      	echo -e ""
	echo -e "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
	echo -e "Cloning Anykernel..."	
	echo -e "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
	echo -e ""
	git clone https://github.com/redstarksten/Anykernel.git
   else
   	echo -e ""
	echo -e "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
	echo -e "Anykernel already exist." 	
	echo -e "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
	echo -e ""
    fi

    if ! [[ -d ${SIGNER_DIR} ]]; then
    	echo -e ""
	echo -e "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
	echo -e "Download signer..."  	
	echo -e "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
	echo -e ""
    	mkdir signer && curl -sLo signer/zipsigner-3.0.jar https://raw.githubusercontent.com/najahiiii/Noob-Script/noob/bin/zipsigner-3.0.jar && cd
    else
    	echo -e ""
	echo -e "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
	echo -e "Signer already exist."  	
	echo -e "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
	echo -e ""
    fi
}
#telegram
export token="1290161744:AAGMv7NlfFdjRG-OR1L644TU8J8dyqDcfH8"
export chat_id="-1001169205147"
export sticker_id="CAACAgUAAxkBAAEBY1BfcfdHj0mZ__wpN2xvPpGAb9VIngACiwAD7OCaHpbj1BCmgcEbGwQ"
export stickerr_id="CAACAgUAAxkBAAEBYwlfcdkduys5zAvVpek_kvzSSOOXZwACGgADwNuQOaZM4AdxOsmJGwQ"
export logo=${EXTRA}/logo.jpg
#env
export PATH="$HOME/clang/bin:$PATH"
export ARCH=arm64
export SUBARCH=arm64
export KBUILD_BUILD_USER=Bukandewa
export KBUILD_BUILD_HOST=Desktop
export CLANG_VERSION="$($HOME/clang/bin/clang --version | head -n 1 | perl -pe 's/\((?:http|git).*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//')"
export PATH="/usr/lib/ccache:$PATH"
export USE_CCACHE=1
export CCACHE_DIR="$HOME/.ccache"
git config --global user.email "mahadewanto2@gmail.com"
git config --global user.name "bukandewa"
git config --global user.signingkey C9F589F7D1A390DC

# sticker plox
function sticker() {
	echo -e ""
	echo -e "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
	echo -e "Send sticker success!"  	
	echo -e "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
	echo -e ""
        ./telegram -s ${sticker_id}
}
# Stiker Error
function stikerr() {
	echo -e ""
	echo -e "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
	echo -e "Send sticker error!"  	
	echo -e "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
	echo -e ""
	./telegram -s ${stickerr_id}
}
#Upload to gdrive
function upload() {
	echo -e ""
	echo -e "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
	echo -e "Upload to Gdrive Folder...."	
	echo -e "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
	echo -e ""
	gdrive upload --share $(echo ${SIGNER_DIR}/${ZIPNAME}-signed.zip) | tee ${EXTRA}/link.txt
	link=$(echo $(cat /home/bukandewa/Extra/link.txt | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u))
	rm -rf ${SIGNER_DIR}/*.zip
	rm -rf ${IMG_DIR}
	rm -rf ${ANY_IMG}
}	
# Push kernel to channel
function push() {
      	echo -e ""
	echo -e "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
	echo -e "Push message to telegram..."  	
	echo -e "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
	echo -e ""
	./telegram -f ${SIGNER_DIR}/*.zip "Build took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) second(s)."
}
#Push build log to github
function log() {
	echo -e ""
	echo -e "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
	echo -e "Push build log to github"  	
	echo -e "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
	echo -e ""
	cd ~/Extra/redstarksten.github.io
	git add .
	git commit -s -S -m "${tanggal} build log"
	git push && cd ..
}
	
#send image and caption info
function image() {
	echo -e ""
	echo -e "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
	echo -e "Send image and caption..."  	
	echo -e "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
	echo -e ""
        ./telegram -i $(echo ${logo}) -H -D \
-T "<b>${KERNEL_NAME}</b> New Update!
<b>Release Date: 15/10/2020</b>
<b>By @bukandewa</b>

<a href='${link}'>Download</a> | <a href='https://redstarksten.github.io/changelog.html'>Changelog</a>

<b>Started on :</b> <code>$(TZ=Asia/Jakarta date)</code>
<b>Build on :</b> <code>${KBUILD_BUILD_USER}-${KBUILD_BUILD_HOST}</code>
<b>For device :</b> <b>${DEVICE}</b> (Redmi Note 8/8T)
<b>Kernel Version :</b> <code>${KERNEL_VERSION}</code>
<b>Using compiler :</b> <code>$CLANG_VERSION</code>
<b>Build took $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) second(s).</b>

<a href='https://redstarksten.github.io/index.html'>Pages</a> | <a href='https://t.me/StarkXKernel'>Channel</a> | <a href='https://t.me/StarkXOfficial'>Group</a> | <a href='https://github.com/redstarksten'>Github</a>

<b>Notes :</b>
- Just flash then reboot.
- If not boot on MIUI, please use this <a href='https://drive.google.com/uc?id=15I9uvNLG-YnndBOwpO_eDp8S74OhkQPk&export=download'>MIUI Kernel</a> version."

}
# Fin Error
function finerr() {
      	echo -e ""
	echo -e "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
	echo -e "Error!"  	
	echo -e "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
	echo -e ""
      	paste
     	curl -X POST "https://api.telegram.org/bot$token/sendMessage" \
			-d chat_id="$chat_id" \
			-d "disable_web_page_preview=true" \
			-d "parse_mode=markdown" \
			-d text="Build throw an error(s)"
}
# Compile plox
function compile() {
	echo -e ""
	echo -e "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
	echo -e "Clean oldconfig exist..."  	
	echo -e "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
	echo -e ""
cd out
make clean && make mrproper && cd ..
        echo -e ""
	echo -e "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
	echo -e "Compile kernel process..."  	
	echo -e "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
	echo -e ""
make O=out ARCH=arm64 ${CONFIG}
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      LD=ld.lld \
                      AR=llvm-ar \
                      AS=llvm-as \
                      NM=llvm-nm \
                      READELF=llvm-readelf \
                      OBJSIZE=llvm-size \
                      OBJCOPY=llvm-objcopy \
                      OBJDUMP=llvm-objdump \
                      STRIP=llvm-strip \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-gnu- \
                      CROSS_COMPILE_ARM32=arm-linux-gnueabi- \
                      Image.gz-dtb | tee ${LOG_DIR}

        if ! [[ -a ${IMG_DIR} ]]; then
              	finerr
		stikerr
              	exit 1
        fi
}
# Zipping
function zipping() {
        echo -e ""
	echo -e "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
	echo -e "Zipping to anykernel..."  	
	echo -e "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
	echo -e ""
        if [[ -f ${IMG_DIR} ]]; then
        cat ${IMG_DIR} ${DTB} > ${ANY_IMG}
        cd /${ANY_DIR}
        zip -r9 unsigned.zip *
        mv unsigned.zip ${SIGNER_DIR} && cd ..
        else
        echo -e "Failed!"
        fi
}
#signer
function signer() {
        echo -e ""
	echo -e "▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀"
	echo -e "Signing zip process..."  	
	echo -e "▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄"
	echo -e ""
        if [[ -f ${SIGNER_DIR}/unsigned.zip ]]; then
        cd signer
        java -jar zipsigner-3.0.jar unsigned.zip ${ZIPNAME}-signed.zip
        rm unsigned.zip && cd ../telegram.sh
        else
        echo -e "Failed!"
        fi
}
check
compile
log
zipping
signer
END=$(date +"%s")
DIFF=$(($END - $START))
upload
image
#push
sticker
