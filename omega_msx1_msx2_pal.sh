# this script generates a japanesse version of msx2+ and an international one
# to be compatible with games, it has international keys with jap the rest
#!/bin/bash

#incluye msx1 y msx2+ con fmbasic.rom

SYSTEM_ROMS_DIR=systemroms
CBIOS_ROMS_DIR=cbios-0.29a/roms
# set PATCH_KEYS to 1 to patch the keyboard in Japanese MSX2/MSX2+ ROMs
# to match the international keyboard layout

# Create MSX1 BIOS Int NTSC image

OUTPUT_FILE=omega_msx1_msx2_pal.bin
# copy MSX1 PAL ROMs
cat ${SYSTEM_ROMS_DIR}/vg8000_basic-bios1.rom > ${OUTPUT_FILE}
dd if=/dev/zero ibs=1k count=224 | tr "\000" "\377" >> ${OUTPUT_FILE}


# High half with MSX2 PAL BIOS 
# copy MSX2 PAL ROMs
cat ${SYSTEM_ROMS_DIR}/nms8250_basic-bios2.rom >> ${OUTPUT_FILE} # 32k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${OUTPUT_FILE} #32k - 64k
cat ${SYSTEM_ROMS_DIR}/nms8250_msx2sub.rom >> ${OUTPUT_FILE} #16k - 80k
dd if=/dev/zero ibs=1k count=64 | tr "\000" "\377" >> ${OUTPUT_FILE} #64k - 144k 
cat ${SYSTEM_ROMS_DIR}/fastdrom11/fastdrom_cdx2.eprom >> ${OUTPUT_FILE} #16k -160k
dd if=/dev/zero ibs=1k count=48 | tr "\000" "\377" >> ${OUTPUT_FILE} # 48k - 208k
cat ${SYSTEM_ROMS_DIR}/phc-70fd2_fmbasic.rom >> ${OUTPUT_FILE} #16k - 224k
dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> ${OUTPUT_FILE} #32k


