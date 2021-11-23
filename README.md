# Archery-clock-image-gen

A tool used to create Raspberry Pi OS images for [Archery-Clock](https://github.com/Athwale/Archery-clock).  
  
This is not intended to be used for anything else. If you find bugs or wish to create your own images please use the original [upstream version](https://github.com/RPi-Distro/pi-gen) from which this tool is derived.

## Docker image build usage
### Install docker
```
sudo dnf install docker-ce docker-ce-cli containerd.io
sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker
```

### Enable binfmt_misc
`sudo modprobe binfmt_misc`

### Configure and build image
Basic settings are in `config` file.  
Additional package installation is configured in `./stage3/00-install/00-packages`  
To add additional files to the image use the `./stage3/00-install/files` folder and the `./stage3/00-install/01-run.sh` script.  
Files are added like this: `install -m 644 files/test-file "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/test-file"`  the `01-run.sh` script can be used to execute commands on the rpi os during compilation. Put these commands in the `on_chroot` section.  
  
To build run: `./build-docker.sh`  
The image is placed into `./deploy`.
  
### Cleanup
`yes | docker system prune -a`  
`rm -rf deploy`
 
## Test in virtual machine


## Modifications
binfmt test in `scripts/dependencies_check` is disabled. This test failing is probably a bug.  
Stages 4 and 5 are disabled. Only stages up to 3 are used to make the system as minimal as possible.
Stage 3 is used to do all additional settings and package installation.

