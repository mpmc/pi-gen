#!/bin/bash -e

echo "${TARGET_HOSTNAME}" > "${ROOTFS_DIR}/etc/hostname"
echo "127.0.1.1		${TARGET_HOSTNAME}" >> "${ROOTFS_DIR}/etc/hosts"

install -m 644 files/eth0 "${ROOTFS_DIR}/etc/network/interfaces.d/eth0"

# Use old style eth0
mkdir -p "${ROOTFS_DIR}/etc/systemd/network"
ln -sfv /dev/null "${ROOTFS_DIR}/etc/systemd/network/99-default.link"

on_chroot << EOF
if command -v update-initramfs >/dev/null; then
	update-initramfs -uk all
fi

if command -v systemctl >/dev/null; then
	if dpkg-query -W -f='\${Status}' ifupdown 2>/dev/null | grep -q 'install ok installed'; then
		systemctl enable networking
	fi
fi
EOF
