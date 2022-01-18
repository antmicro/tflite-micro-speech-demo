#!/bin/bash

MICRO_SPEECH_BASE=$(pwd)
cd tflite-micro
make -f tensorflow/lite/micro/tools/make/Makefile TARGET=zephyr_vexriscv TARGET_ARCH=vexriscv micro_speech_bin

if [ ! -e tensorflow/lite/micro/tools/make/gen/zephyr_vexriscv_vexriscv_default/micro_speech/build/zephyr/zephyr.bin ] ; then
  make -f tensorflow/lite/micro/tools/make/Makefile TARGET=zephyr_vexriscv TARGET_ARCH=vexriscv micro_speech_bin
fi
cd $MICRO_SPEECH_BASE

cd zephyr-on-litex-vexriscv
./make.py --board=arty --build --with_mmcm --with_i2s --with_ethernet
cd $MICRO_SPEECH_BASE

mkdir -p build
cp tflite-micro/tensorflow/lite/micro/tools/make/gen/zephyr_vexriscv_vexriscv_default/micro_speech/build/zephyr/zephyr.bin build/micro_speech.bin
cp zephyr-on-litex-vexriscv/build/arty/gateware/arty.bit build/micro_speech.bit

