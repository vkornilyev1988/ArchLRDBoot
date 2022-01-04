#!/bin/bash
zfs snap st0/img@a8:0a:59:4f:55:b5
 mount -t zfs st0/img@a8:0a:59:4f:55:b5 /storage/st0/snap/a8_0a_59_4f_55_b5/
qemu-img create -f qcow2 -F qcow2 -b /storage/st0/snap/a8_0a_59_4f_55_b5/test_c.qcow2 /storage/st0/wb/nbd1.qcow2
qemu-img create -f qcow2 -F qcow2 -b /storage/st0/snap/a8_0a_59_4f_55_b5/games.qcow2 /storage/st0/wb/nbd2.qcow2
tgtadm --lld iscsi --op new --mode target --tid 1 --targetname iqn.2021-lord.com:pc1001
tgtadm --lld iscsi --op new --mode logicalunit --tid 1 --lun 1  --backing-store /dev/nbd1
tgtadm --lld iscsi --op new --mode logicalunit --tid 1 --lun 2  --backing-store /dev/nbd2

qemu-nbd -c /dev/nbd1 /storage/st0/wb/nbd1.qcow2
qemu-nbd -c /dev/nbd2 /storage/st0/wb/nbd2.qcow2
tgtadm --lld iscsi --op show --mode target
