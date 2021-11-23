# Archery-clock-image-gen

A tool used to create Raspberry Pi OS images for [Archery-Clock](https://github.com/Athwale/Archery-clock).  
  
This is not intended to be used for anything else. If you find bugs or wish to create your own images please use the original [upstream version](https://github.com/RPi-Distro/pi-gen) from which this tool is derived.

## Usage

## Modifications
binfmt test in `scripts/dependencies_check` is disabled. This test failing is probably a bug.  
Stages 4 and 5 are disabled. Only stages up to 3 are used to make the system as minimal as possible.
Stage 3 is used to do all additional settings and package installation.

