# this script generates a international version of msx2+ and msx2pal with fmpac & cdx2 support
# it has international keys with ntsc & pal
#!/bin/bash

#both include fmbasic.rom y fastdrom_cdx2-1.1

OUTPUT_FILE=omega_msx2+fm_msx2pal.bin
SYSTEM_ROMS_DIR=systemroms
CBIOS_ROMS_DIR=cbios-0.29a/roms
# Low half with all international mods

# set PATCH_KEYS to 1 to patch the keyboard in Japanese MSX2/MSX2+ ROMs
# to match the international keyboard layout
PATCH_KEYS=1
PATCH_BACKSLASH=1
PATCH_VERSION=1

# copy the first set of MSX2 NTSC ROMs
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_basic-bios2p.rom > ${OUTPUT_FILE} #32k               Basic 3.0
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${OUTPUT_FILE} #32 -64k
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_msx2psub.rom >> ${OUTPUT_FILE} #16k -80k             msx2+ subrom bios
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_kanjibasic.rom >> ${OUTPUT_FILE} #32k -112k          kanji bios
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${OUTPUT_FILE} #32 -148k
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> ${OUTPUT_FILE} #16 -160k        space for disk rom
#cat ${SYSTEM_ROMS_DIR}/fastdrom11/fastdrom_cdx2.eprom >> ${OUTPUT_FILE} #16k -160k    fastdisk cdx-2 1.1 diskbasic (disabled)
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${OUTPUT_FILE} # 32k - 192k
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> ${OUTPUT_FILE} #16k - 208k
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_fmbasic.rom >> ${OUTPUT_FILE} #16k - 224k            fmbasic
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_basickun.rom >> ${OUTPUT_FILE} #16k - 240 k          basic KUN
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> ${OUTPUT_FILE} #16k - 256 K
# patch the keys
if [ "$PATCH_KEYS" -eq "1" ]; then
  dd if=int_keys_patch.bin of=${OUTPUT_FILE} bs=1 seek=3529 conv=notrunc
fi
# patch the backslash
if [ "$PATCH_BACKSLASH" -eq "1" ]; then
  dd if=backslash_patch.bin of=${OUTPUT_FILE} bs=1 seek=7839 conv=notrunc
fi

# High half with MSX2 PAL BIOS 
# copy MSX2 PAL ROMs
cat ${SYSTEM_ROMS_DIR}/nms8250_basic-bios2.rom >> ${OUTPUT_FILE} # 32k                Basic 2.0
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${OUTPUT_FILE} #32k - 64k
cat ${SYSTEM_ROMS_DIR}/nms8250_msx2sub.rom >> ${OUTPUT_FILE} #16k - 80k               msx2 subrom bios
dd if=/dev/zero ibs=1k count=64 | tr "\000" "\377" >> ${OUTPUT_FILE} #64k - 144k 
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> ${OUTPUT_FILE} #16 -160k        space for disk rom
#cat ${SYSTEM_ROMS_DIR}/fastdrom11/fastdrom_cdx2.eprom >> ${OUTPUT_FILE} #16k -160k    fastdisk cdx-2 1.1 diskbasic (disabled)
dd if=/dev/zero ibs=1k count=48 | tr "\000" "\377" >> ${OUTPUT_FILE} # 48k - 208k
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> ${OUTPUT_FILE} #16 -224k        space for fmbasic
#cat ${SYSTEM_ROMS_DIR}/phc-70fd2_fmbasic.rom >> ${OUTPUT_FILE} #16k - 224k            fmbasic (disabled)
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${OUTPUT_FILE} #32k


