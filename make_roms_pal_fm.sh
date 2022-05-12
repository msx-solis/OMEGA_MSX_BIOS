#!/bin/bash

SYSTEM_ROMS_DIR=systemroms
CBIOS_ROMS_DIR=cbios-0.29a/roms
FILE_OUT=omega_msx2_pal_fm.bin
# set PATCH_KEYS to 1 to patch the keyboard in Japanese MSX2 ROMs
# to match the international keyboard layout
PATCH_KEYS=1 # 1 int, 0 jap = keyboard
PATCH_BACKSLASH=0 # 1 slash 0 yen = simbol
PATCH_VERSION=0 # 1 int, 0 jap = regional zone

# Create MSX2 BIOS + C-BIOS PAL image with fm music extension

# copy MSX2 PAL ROMs
cat ${SYSTEM_ROMS_DIR}/nms8250_basic-bios2.rom > ${FILE_OUT} #32k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILE_OUT}
cat ${SYSTEM_ROMS_DIR}/nms8250_msx2sub.rom >> ${FILE_OUT} #16k
dd if=/dev/zero ibs=1k count=128 | tr "\000" "\377" >> ${FILE_OUT}
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_fmbasic.rom >> ${FILE_OUT} #16k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILE_OUT}

# copy C-BIOS PAL ROMs
cat ${CBIOS_ROMS_DIR}/cbios_main_msx2_eu.rom >>  ${FILE_OUT} #32k
cat ${CBIOS_ROMS_DIR}/cbios_logo_msx2.rom >>  ${FILE_OUT} #16k
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >>  ${FILE_OUT}
cat ${CBIOS_ROMS_DIR}/cbios_sub.rom >>  ${FILE_OUT} #16k
#dd if=/dev/zero ibs=1k count=128 | tr "\000" "\377" >>  ${FILE_OUT} #normal
dd if=/dev/zero ibs=1k count=64 | tr "\000" "\377" >>  ${FILE_OUT} #juego
cat ${SYSTEM_ROMS_DIR}/knight.rom >> ${FILE_OUT} #juego 32k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >>  ${FILE_OUT} #juego
cat ${CBIOS_ROMS_DIR}/cbios_music.rom  >>  ${FILE_OUT} #16k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >>  ${FILE_OUT}

