# this script generates a japanesse version of msx2+ and an international one
# to be compatible with games, it has international keys with jap the rest
#!/bin/bash

#incluye ambos con fmbasic.rom

OUTPUT_FILE=omega_msx2+_all_disk_ntsc.bin
SYSTEM_ROMS_DIR=systemroms
CBIOS_ROMS_DIR=cbios-0.29a/roms
# set PATCH_KEYS to 1 to patch the keyboard in Japanese MSX2/MSX2+ ROMs
# to match the international keyboard layout
PATCH_KEYS=1
PATCH_BACKSLASH=0
PATCH_VERSION=0

# Create MSX2+ BIOS Jap + MSX2+ BIOS Int NTSC image

# copy MSX2+ NTSC ROMs
cat ${SYSTEM_ROMS_DIR}/phc-35j_basic-bios2p.rom > ${OUTPUT_FILE} #32k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${OUTPUT_FILE} #32 -64k
cat ${SYSTEM_ROMS_DIR}/phc-35j_msx2psub.rom >> ${OUTPUT_FILE} #16k -80k
cat ${SYSTEM_ROMS_DIR}/phc-35j_kanjibasic.rom >> ${OUTPUT_FILE} #32k -112k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${OUTPUT_FILE} #32 -148k
cat ${SYSTEM_ROMS_DIR}/ANGEISA_en.rom >> ${OUTPUT_FILE} #16k 
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> ${OUTPUT_FILE} # 16k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${OUTPUT_FILE} #32k
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_fmbasic.rom >> ${OUTPUT_FILE} #16k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${OUTPUT_FILE} #32k
# patch the keys
if [ "$PATCH_KEYS" -eq "1" ]; then
  dd if=int_keys_patch.bin of=${OUTPUT_FILE} bs=1 seek=3529 conv=notrunc
fi
# patch the backslash
if [ "$PATCH_BACKSLASH" -eq "1" ]; then
  dd if=backslash_patch.bin of=${OUTPUT_FILE} bs=1 seek=7839 conv=notrunc
fi

# high part with all international mods
PATCH_KEYS=1
PATCH_BACKSLASH=1
PATCH_VERSION=1

# copy the second set of MSX2 NTSC ROMs
cat ${SYSTEM_ROMS_DIR}/phc-35j_basic-bios2p.rom >> ${OUTPUT_FILE} #32
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${OUTPUT_FILE} #32
cat ${SYSTEM_ROMS_DIR}/phc-35j_msx2psub.rom >> ${OUTPUT_FILE} #16k
cat ${SYSTEM_ROMS_DIR}/phc-35j_kanjibasic.rom >> ${OUTPUT_FILE} #32k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${OUTPUT_FILE} #32
cat ${SYSTEM_ROMS_DIR}/ANGEISA_en.rom >> ${OUTPUT_FILE} #16k
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> ${OUTPUT_FILE} # 16k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${OUTPUT_FILE} #32k
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_fmbasic.rom >> ${OUTPUT_FILE} #16k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${OUTPUT_FILE} #32k
# patch the keys
if [ "$PATCH_KEYS" -eq "1" ]; then
  dd if=int_keys_patch.bin of=${OUTPUT_FILE} bs=1 seek=265673 conv=notrunc
fi
# patch the backslash
if [ "$PATCH_BACKSLASH" -eq "1" ]; then
  dd if=backslash_patch.bin of=${OUTPUT_FILE} bs=1 seek=269983 conv=notrunc
fi

