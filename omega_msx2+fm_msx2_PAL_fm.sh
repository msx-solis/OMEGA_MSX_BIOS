SYSTEM_ROMS_DIR=systemroms
CBIOS_ROMS_DIR=cbios-0.29a/roms
# set PATCH_KEYS to 1 to patch the keyboard in Japanese MSX2/MSX2+ ROMs
# to match the international keyboard layout

# Create MSX2+ BIOS EU NTSC FM + BIOS MSX2 PAL FM image

PATCH_KEYS=1
PATCH_BACKSLASH=1
PATCH_VERSION=1

# copy MSX2+ NTSC ROMs FM EU
FILENAME=omega_msx2+fm_msx2_PAL_fm.bin
cat ${SYSTEM_ROMS_DIR}/phc-35j_basic-bios2p.rom > ${FILENAME} #32k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME} #32k
cat ${SYSTEM_ROMS_DIR}/phc-35j_msx2psub.rom >> ${FILENAME} #16K
cat ${SYSTEM_ROMS_DIR}/phc-35j_kanjibasic.rom >> ${FILENAME} #32k
dd if=/dev/zero ibs=1k count=96 | tr "\000" "\377" >> ${FILENAME} #96k
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_fmbasic.rom >> ${FILENAME} #16k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME} #32K
# patch the keys
if [ "$PATCH_KEYS" -eq "1" ]; then
  dd if=int_keys_patch.bin of=${FILENAME} bs=1 seek=3529 conv=notrunc
fi
# patch the backslash
if [ "$PATCH_BACKSLASH" -eq "1" ]; then
  dd if=backslash_patch.bin of=${FILENAME} bs=1 seek=7839 conv=notrunc
fi

# copy MSX2 PAL ROMs
cat ${SYSTEM_ROMS_DIR}/nms8250_basic-bios2.rom >> ${FILENAME} # 32k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME} #32k
cat ${SYSTEM_ROMS_DIR}/nms8250_msx2sub.rom >> ${FILENAME} #16k
dd if=/dev/zero ibs=1k count=128 | tr "\000" "\377" >> ${FILENAME} #126k
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_fmbasic.rom >> ${FILENAME} #16k 
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${FILENAME} #32k

