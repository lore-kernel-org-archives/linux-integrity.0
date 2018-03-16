Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-lf0-f50.google.com ([209.85.215.50]:33500 "EHLO
        mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbeCPJcg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Mar 2018 05:32:36 -0400
Received: by mail-lf0-f50.google.com with SMTP id x205-v6so14387589lfa.0
        for <linux-integrity@vger.kernel.org>; Fri, 16 Mar 2018 02:32:35 -0700 (PDT)
MIME-Version: 1.0
From: Martin Townsend <mtownsend1973@gmail.com>
Date: Fri, 16 Mar 2018 09:32:34 +0000
Message-ID: <CABatt_zunDV_g3oR5_O5GMm0EVEnT0LEnmjp5PQgu26Q6T+4SA@mail.gmail.com>
Subject: Problem mounting pseudo filesystems with SMACK and IMA enabled.
To: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

[Resending to new integrity mailing list]

Hi,

I have a system with a pre-signed UBI root filesystem image with both
IMA/EVM signatures on all files.  The Root CA Cert is compiled into
the kernel and the public keys is in the rootfs.  All SMACK labels
have also been applied although at this early stage there aren't many
(just a few application specific ones) so it's mainly the defaults.
This image is then flashed to the on board NAND.

The kernel bootargs for IMA are

"ima_audit=1 ima_template=ima-ng ima_hash=sha1 ima_tcb
ima_appraise_tcb rootflags=i_version"

and I'm enabling SMACK by using the kernel bootarg

"security=smack"

now if I boot without the "security=smack" it boots fine and I can
check the IMA/EVM signatures and can see that measurements are being
taken, but if I enable SMACK using the above kernel bootarg it fails
to boot and it looks like some problem early in systemd where it
mounts the required filesystems in mount-setup.c (log provided below).
Now if I flash an image that hasn't been signed and enable SMACK it
boots fine and I can use SMACK to enforce access control.  So there
seems to some interaction between the two when mounting the early
filesystems.

Before I delve into this I would appreciate any pointers to where to
start looking, any printk's to put in SMACK/IMA/mount code to help
diagnose this would be really appreciated.

The Kernel is 4.9 LTSI, systemd is v229

Apologies if I have the wrong mailing list for SMACK, I couldn't find
one on vger.kernel.org.


Boot log.
...
Security Framework initialized
Smack:  Initializing.
Smack:  IPv6 port labeling enabled.
Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
CPU: Testing write buffer coherency: ok
Setting up static identity map for 0x80100000 - 0x80100058
devtmpfs: initialized
evm: security.SMACK64
evm: security.SMACK64EXEC
evm: security.SMACK64TRANSMUTE
evm: security.SMACK64MMAP
evm: security.ima
evm: security.capability
...
Loading compiled-in X.509 certificates
Loaded X.509 cert 'IMA-EVM Root CA: cc972d25acf7c1efaa5329a48104efa303f0833a'
...
UBIFS (ubi0:0): FS size: 201764864 bytes (192 MiB, 1589 LEBs), journal
size 9023488 bytes (8 MiB, 72 LEBs)
UBIFS (ubi0:0): reserved for root: 0 bytes (0 KiB)
UBIFS (ubi0:0): media format: w4/r0 (latest is w4/r0), UUID
F6EA70A5-1931-4049-89CB-93B82F37F6A4, small LPT model
VFS: Mounted root (ubifs filesystem) readonly on device 0:16.
devtmpfs: mounted
integrity: Loaded X.509 cert 'IMA Certificate Authority:
e2c191a6e31fd02d6beba0c7c7847720a35fd9c6': /etc/keys/ima-x509.der
Freeing unused kernel memory: 1024K
systemd[1]: Successfully loaded Smack policies.
systemd[1]: Successfully loaded Smack/CIPSO policies.
systemd[1]: System time before build time, advancing clock.
systemd[1]: Failed to mount tmpfs at /dev/shm: No such file or directory
systemd[1]: Failed to mount tmpfs at /dev/shm: No such file or directory
systemd[1]: Failed to mount cgroup at /sys/fs/cgroup/systemd: No such
file or directory
[!!!!!!] Failed to mount API filesystems, freezing.
systemd[1]: Freezing execution.

Many Thanks,
Martin.
