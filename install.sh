#!/bin/bash

MICRO_SPEECH_BASE=$(pwd)
cd zephyr-on-litex-vexriscv
./install.sh

pip3 install Pillow

cd $MICRO_SPEECH_BASE

