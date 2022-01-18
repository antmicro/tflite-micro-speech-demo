# TensorFlow Lite Micro Speech example for Zephyr on LiteX/VexRiscv

Copyright (c) 2021-2022 [Antmicro](https://www.antmicro.com)

## Overview

This example runs a 20 kB model that can recognize 2 keywords,
"yes" and "no", from speech data. The application listens to its surroundings with a microphone and indicates
when it has detected a word by printing data on UART.

This port of the example is dedicated to run on [Zephyr](https://www.zephyrproject.org/) RTOS on
[LiteX-VexRiscv](https://github.com/litex-hub/zephyr-on-litex-vexriscv) design.

It has been tested on [Arty A7](https://digilent.com/reference/programmable-logic/arty-a7/start)
equipped with a [Pmod I2S2 module](https://digilent.com/reference/pmod/pmodi2s2/start) connected to `JA`
connector and working in master mode.

## Device configuration

The I2S2 Pmod can be connected to any Pmod connector on the Arty-7 board.
By default, LiteX is configured to support Pmod on `JA` connector.
The PMOD I2S2 jumper has to switch the device into master mode. To do so, put the jumper in the `MST` position.
This allows the device to generate required signals using its internal circuits.

## Example setup

![](pmod2-i2s-arty-setup.png)

## Prerequisites
Download Zephyr SDK, version at least 2.5.0. The instructions
can be found [here](https://docs.zephyrproject.org/latest/getting_started/index.html).

Install the Vivado toolchain. You can download Vivado using this
[link](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/archive.html).
The 2017.3 or newer version of Vivado is recommended. Then set:
```
export PATH_TO_VIVADO_TOOLCHAIN=[path to your vivado toolchain]
```
to your installation directory of Vivado.

Get all required submodules:
```
git submodule update --init --recursive
```

And obtain all required packages:
```
apt update
apt install build-essential bzip2 python3 python3-dev python3-pip
pip3 install pyyaml pillow
./install.sh
```

## Building
```
source ./init
./build.sh
```

The resulting files will be placed in the `build/` directory:
- `micro_speech.bit`: the Arty A7 bitstream
- `micro_speech.bin`: the executables

## Running
To run the demo on Arty A7 you can use
[openFPGALoader](https://github.com/trabucayre/openFPGALoader) to load the gateware and
[litex_term](https://github.com/enjoy-digital/litex/blob/master/litex/tools/litex_term.py)
to run the software.

If you have `litex_term.py` and `openFPGALoader` on your `PATH`, you can enter the `build/`
directory and run:
```
openFPGALoader -b arty micro_speech.bit
litex_term.py --speed 1000000 --kernel micro_speech.bin /dev/ttyUSB0
```

Notice that ttyUSB's number on which the board expects the software to be sent may vary,
but typically the correct device name is `/dev/ttyUSB0` or `/dev/ttyUSB1`.

You can expect output similar to that from the following logs.

When the input is repeated "yes" sound:
```
Heard yes (208) @5376ms
```

And repeated "no" sound:
```
Heard no (201) @22936ms
```
