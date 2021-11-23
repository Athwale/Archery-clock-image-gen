#!/bin/bash -e

# Commands to run as root on the pi system to prepare environment.
on_chroot << EOF
    systemctl disable wpa_supplicant
EOF

# Adding additional file from the ./files folder into the pi system.
install -m 644 files/test-file "${ROOTFS_DIR}/home/${FIRST_USER_NAME}/test-file"
