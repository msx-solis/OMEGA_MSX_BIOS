#!/bin/bash

SYSTEM_ROMS_DIR=systemroms
CBIOS_ROMS_DIR=cbios-0.29a/roms

# Create MSX2+ C-BIOS NTSC image + C-BIOS PAL image

# copy C-BIOS MSX+ NTSC ROMs
cat ${CBIOS_ROMS_DIR}/cbios_main_msx2+_jp.rom >> omega_msx2+_cbios.bin
cat ${CBIOS_ROMS_DIR}/cbios_logo_msx2+.rom >> omega_msx2+_cbios.bin
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> omega_msx2+_cbios.bin
cat ${CBIOS_ROMS_DIR}/cbios_sub.rom >> omega_msx2+_cbios.bin
dd if=/dev/zero ibs=1k count=176 | tr "\000" "\377" >> omega_msx2+_cbios.bin

# copy C-BIOS PAL ROMs
cat ${CBIOS_ROMS_DIR}/cbios_main_msx2_eu.rom >> omega_msx2+_cbios.bin
cat ${CBIOS_ROMS_DIR}/cbios_logo_msx2.rom >> omega_msx2+_cbios.bin
dd if=/dev/zero ibs=1k count=16 | tr "\000" "\377" >> omega_msx2+_cbios.bin
cat ${CBIOS_ROMS_DIR}/cbios_sub.rom >> omega_msx2+_cbios.bin
dd if=/dev/zero ibs=1k count=176 | tr "\000" "\377" >> omega_msx2+_cbios.bin


