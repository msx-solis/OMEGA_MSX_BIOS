#!/bin/bash

SYSTEM_ROMS_DIR=systemroms
CBIOS_ROMS_DIR=cbios-0.29a/roms
# set PATCH_KEYS to 1 to patch the keyboard in Japanese MSX2/MSX2+ ROMs
# to match the international keyboard layout
PATCH_KEYS=1
PATCH_BACKSLASH=1
PATCH_VERSION=1


# Create MSX1 BIOS + C-BIOS MSX1 PAL image

FILENAME=omega_msx1_pal.bin
# copy MSX1 PAL ROMs
cat ${SYSTEM_ROMS_DIR}/vg8020_basic-bios1.rom > ${FILENAME}
dd if=/dev/zero ibs=1k count=224 | tr "\000" "\377" >> ${FILENAME}

# copy C-BIOS PAL ROMs
cat ${CBIOS_ROMS_DIR}/cbios_main_msx1_eu.rom >> ${FILENAME}
cat ${CBIOS_ROMS_DIR}/cbios_logo_msx1.rom >> ${FILENAME}
dd if=/dev/zero ibs=1k count=208 | tr "\000" "\377" >> ${FILENAME}

# Create MSX1 BIOS + C-BIOS MSX1 PAL image

FILENAME=omega_msx1_ntsc.bin
# copy MSX1 PAL ROMs
cat ${SYSTEM_ROMS_DIR}/mpc2_basic-bios1.rom > ${FILENAME}
dd if=/dev/zero ibs=1k count=224 | tr "\000" "\377" >> ${FILENAME}

# copy C-BIOS PAL ROMs
cat ${CBIOS_ROMS_DIR}/cbios_main_msx1_jp.rom >> ${FILENAME}
cat ${CBIOS_ROMS_DIR}/cbios_logo_msx1.rom >> ${FILENAME}
dd if=/dev/zero ibs=1k count=208 | tr "\000" "\377" >> ${FILENAME}

# Create MSX2+ BIOS + C-BIOS MSX2+ PAL image

FILENAME=omega_msx2+EU+cbios_msx2+PAL.bin
# copy MSX2+ NTSC ROMs
cat ${SYSTEM_ROMS_DIR}/phc-35j_basic-bios2p.rom > ${FILENAME}
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME}
cat ${SYSTEM_ROMS_DIR}/phc-35j_msx2psub.rom >> ${FILENAME}
cat ${SYSTEM_ROMS_DIR}/phc-35j_kanjibasic.rom >> ${FILENAME}
dd if=/dev/zero ibs=1k count=144 | tr "\000" "\377" >> ${FILENAME}
# patch the keys
if [ "$PATCH_KEYS" -eq "1" ]; then
  dd if=int_keys_patch.bin of=${FILENAME} bs=1 seek=3529 conv=notrunc
fi
# patch the backslash
if [ "$PATCH_BACKSLASH" -eq "1" ]; then
  dd if=backslash_patch.bin of=${FILENAME} bs=1 seek=7839 conv=notrunc
fi

# copy C-BIOS MSX+ NTSC ROMs
cat ${CBIOS_ROMS_DIR}/cbios_main_msx2+_eu.rom >> ${FILENAME}
cat ${CBIOS_ROMS_DIR}/cbios_logo_msx2+.rom >> ${FILENAME}
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> ${FILENAME}
cat ${CBIOS_ROMS_DIR}/cbios_sub.rom >> ${FILENAME}
dd if=/dev/zero ibs=1k count=128 | tr "\000" "\377" >> ${FILENAME}
cat ${CBIOS_ROMS_DIR}/cbios_music.rom >> ${FILENAME}
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME}

# Create MSX2+ BIOS JP NTSC + BIOS MSX2 PAL image

PATCH_KEYS=1
PATCH_BACKSLASH=0
PATCH_VERSION=0

# copy MSX2+ NTSC ROMs
FILENAME=omega_msx2+JP_msx2_PAL_fmpac.bin
cat ${SYSTEM_ROMS_DIR}/phc-35j_basic-bios2p.rom > ${FILENAME}
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME}
cat ${SYSTEM_ROMS_DIR}/phc-35j_msx2psub.rom >> ${FILENAME}
cat ${SYSTEM_ROMS_DIR}/phc-35j_kanjibasic.rom >> ${FILENAME}
dd if=/dev/zero ibs=1k count=144 | tr "\000" "\377" >> ${FILENAME}
# patch the keys
if [ "$PATCH_KEYS" -eq "1" ]; then
  dd if=int_keys_patch.bin of=${FILENAME} bs=1 seek=3529 conv=notrunc
fi
# patch the backslash
if [ "$PATCH_BACKSLASH" -eq "1" ]; then
  dd if=backslash_patch.bin of=${FILENAME} bs=1 seek=7839 conv=notrunc
fi

# copy MSX2 PAL ROMs
cat ${SYSTEM_ROMS_DIR}/nms8250_basic-bios2.rom >> ${FILENAME}
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME}
cat ${SYSTEM_ROMS_DIR}/nms8250_msx2sub.rom >> ${FILENAME}
dd if=/dev/zero ibs=1k count=128 | tr "\000" "\377" >> ${FILENAME} #176
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_fmbasic.rom >> ${FILENAME} #16k 
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME} #176


