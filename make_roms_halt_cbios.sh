#!/bin/bash

SYSTEM_ROMS_DIR=systemroms
CBIOS_ROMS_DIR=cbios-0.29a/roms

# Create HALT ROM & MSX2+ C-BIOS NTSC image 

cat 256K-HALT.BIN > omega_halt+cbios.bin
# copy C-BIOS MSX+ NTSC ROMs
cat ${CBIOS_ROMS_DIR}/cbios_main_msx2+.rom >> omega_halt+cbios.bin #32k
cat ${CBIOS_ROMS_DIR}/cbios_logo_msx2+.rom >> omega_halt+cbios.bin #16K
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> omega_halt+cbios.bin #16K
cat ${CBIOS_ROMS_DIR}/cbios_sub.rom >> omega_halt+cbios.bin # 16K
dd if=/dev/zero ibs=1k count=64 | tr "\000" "\377" >> omega_halt+cbios.bin
cat ${SYSTEM_ROMS_DIR}/msxdiag.rom >> omega_halt+cbios.bin #32k programa diagnosticos
#cat ${SYSTEM_ROMS_DIR}/GOONIES.ROM >> omega_halt+cbios.bin #32k solo test juego
#dd if=/dev/zero ibs=1k count=32 | tr "\000" "\377" >> omega_halt+cbios.bin #cambiar por la anterior para anular juego
dd if=/dev/zero ibs=1k count=80 | tr "\000" "\377" >> omega_halt+cbios.bin


