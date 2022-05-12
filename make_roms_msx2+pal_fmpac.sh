# this script generates a japanesse version of msx2+ and an international one
# to be compatible with games, is a test with only international keys with jap the rest
#!/bin/bash

#incluye solo uno con fmbasic.rom

FILENAME=omega_msx2+_ntsc+pal.bin
VAJ=BIOS_VAJ_LEHENAK/bios_sony_700s_msx2+
SYSTEM_ROMS_DIR=systemroms
CBIOS_ROMS_DIR=cbios-0.29a/roms
# set PATCH_KEYS to 1 to patch the keyboard in Japanese MSX2/MSX2+ ROMs
# to match the international keyboard layout
PATCH_KEYS=1
PATCH_BACKSLASH=0
PATCH_VERSION=0

# Create MSX2+ BIOS Jap + MSX2+ BIOS Int NTSC image

# copy MSX2+ NTSC ROMs compatibility version
cat ${SYSTEM_ROMS_DIR}/phc-35j_basic-bios2p.rom > ${FILENAME} #32k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME} 
cat ${SYSTEM_ROMS_DIR}/phc-35j_msx2psub.rom >> ${FILENAME} #16k
cat ${SYSTEM_ROMS_DIR}/phc-35j_kanjibasic.rom >> ${FILENAME} #32k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME} #16+16k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME} # solo normal 32k
#cat ${SYSTEM_ROMS_DIR}/knight.rom >> ${FILENAME} #32k solo test audio
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME} #32k
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> ${FILENAME} #16k
#cat ${SYSTEM_ROMS_DIR}/phc-70fd2_fmbasic.rom >> ${FILENAME} #16k #desactivado en version Japo jp1=0
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME} #32k
# patch the keys
if [ "$PATCH_KEYS" -eq "1" ]; then
  dd if=int_keys_patch.bin of=${FILENAME} bs=1 seek=3529 conv=notrunc
fi
# patch the backslash
if [ "$PATCH_BACKSLASH" -eq "1" ]; then
  dd if=backslash_patch.bin of=${FILENAME} bs=1 seek=7839 conv=notrunc
fi

# high part with msx2+ PAL

# copy the second set of MSX2 NTSC ROMs full experience version
cat ${VAJ}/700S2PLS.ROM >> ${FILENAME} # msx2+pal vaj lehenak 32K
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME} 
cat ${SYSTEM_ROMS_DIR}/phc-35j_msx2psub.rom >> ${FILENAME} #16k
cat ${SYSTEM_ROMS_DIR}/phc-35j_kanjibasic.rom >> ${FILENAME} #32k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME}
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME} # solo normal
#cat ${SYSTEM_ROMS_DIR}/knight.rom >> ${FILENAME} #32k solo test audio
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME}
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_fmbasic.rom >> ${FILENAME} #16k
#cat ${SYSTEM_ROMS_DIR}/obsobios.rom >> ${FILENAME} #16k #esto no va
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> ${FILENAME} #16k
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> ${FILENAME} #16k


