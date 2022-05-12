# this script generates a japanesse version of msx2+ and an international one
# to be compatible with games, it has international keys with jap the rest
#!/bin/bash

#incluye msx1 y msx2+ con fmbasic.rom

SYSTEM_ROMS_DIR=systemroms
CBIOS_ROMS_DIR=cbios-0.29a/roms
# set PATCH_KEYS to 1 to patch the keyboard in Japanese MSX2/MSX2+ ROMs
# to match the international keyboard layout

# Create MSX1 BIOS Int NTSC image

FILENAME=omega_msx1_msx2+fm_ntsc.bin
# copy MSX1 PAL ROMs
cat ${SYSTEM_ROMS_DIR}/mpc2_basic-bios1.rom > ${FILENAME}
dd if=/dev/zero ibs=1k count=224 | tr "\000" "\377" >> ${FILENAME}


# high part with all international mods
PATCH_KEYS=1
PATCH_BACKSLASH=1
PATCH_VERSION=1

# copy the second set of MSX2+ NTSC ROMs
cat ${SYSTEM_ROMS_DIR}/phc-35j_basic-bios2p.rom >> ${FILENAME}
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME} 
cat ${SYSTEM_ROMS_DIR}/phc-35j_msx2psub.rom >> ${FILENAME} #16k
cat ${SYSTEM_ROMS_DIR}/phc-35j_kanjibasic.rom >> ${FILENAME} #32k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME}
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME} # solo normal
#cat ${SYSTEM_ROMS_DIR}/knight.rom >> ${FILENAME} #32k solo test audio
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME}
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_fmbasic.rom >> ${FILENAME} #16k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME}
# patch the keys
if [ "$PATCH_KEYS" -eq "1" ]; then
  dd if=int_keys_patch.bin of=${FILENAME} bs=1 seek=265673 conv=notrunc
fi
# patch the backslash
if [ "$PATCH_BACKSLASH" -eq "1" ]; then
  dd if=backslash_patch.bin of=${FILENAME} bs=1 seek=269983 conv=notrunc
fi

