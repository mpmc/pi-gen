#!/bin/bash -e

install -m 644 files/resolv.conf "${ROOTFS_DIR}/etc/"

if [ -n "${ALT_RESOLV_DNS}" ]; then
	sed -i "s|^nameserver .*|nameserver ${ALT_RESOLV_DNS}|" "${ROOTFS_DIR}/etc/resolv.conf"
fi
