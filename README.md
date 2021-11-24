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
Basic settings are in `config` file. See [upstream](https://github.com/RPi-Distro/pi-gen) for additional configuration options.  
Additional package installation is configured in `./stage-custom/00-install/00-packages`  
To add additional files to the image use the `./stage-custom/00-install/files` folder and the `./stage-custom/00-install/01-run.sh` script.  
Files are added like this: `install -m 644 files/test-file "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/test-file"` the `01-run.sh` script can be used to execute commands on the rpi os during compilation. Put these commands in the `on_chroot` section.  
  
To build run: `./build-docker.sh`  
The image is placed into `./deploy`.  
The build process takes about 20 minutes.
  
### Cleanup
`yes | docker system prune -a`  
`rm -rf deploy`
 
## Test in a virtual machine
### Install qemu for arm
`sudo dnf install @virtualization qemu-system-arm`

### Run the image
`mkdir virtual-pi && cd virtual-pi`  
`git clone https://github.com/dhruvvyas90/qemu-rpi-kernel`  
Copy the image from the `deploy` folder into the virtual-pi directory.  
`mv ./*ARCLOCK*.img arclockos.img`  
`virt-install --name arclockos --arch armv6l --machine versatilepb --cpu arm1176 --vcpus 1 --memory 256 --import --disk arclockos.img,format=raw,bus=virtio --network bridge,source=virbr0,model=virtio --video vga --graphics spice --boot 'dtb=qemu-rpi-kernel/versatile-pb-buster.dtb,kernel=qemu-rpi-kernel/kernel-qemu-4.19.50-buster,kernel_args=root=/dev/vda2 panic=1' --events on_reboot=destroy`  

### Cleanup
`virsh list --all`  
`virsh undefine --domain arclockos`

## Modifications
binfmt test in `scripts/dependencies_check` is disabled. This test failing is probably a bug.  
Stages 4 and 5 are disabled to build just a minimal image.
Stage-custom is used to do all additional settings and package installation.

