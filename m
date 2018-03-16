Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752130AbeCPNZu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Mar 2018 09:25:50 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2GDOPZN082337
        for <linux-integrity@vger.kernel.org>; Fri, 16 Mar 2018 09:25:49 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2grc2jxsc5-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 16 Mar 2018 09:25:49 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 16 Mar 2018 13:25:47 -0000
Subject: Re: Problem mounting pseudo filesystems with SMACK and IMA enabled.
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Martin Townsend <mtownsend1973@gmail.com>,
        linux-integrity@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 16 Mar 2018 09:25:43 -0400
In-Reply-To: <CABatt_zunDV_g3oR5_O5GMm0EVEnT0LEnmjp5PQgu26Q6T+4SA@mail.gmail.com>
References: <CABatt_zunDV_g3oR5_O5GMm0EVEnT0LEnmjp5PQgu26Q6T+4SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521206743.3503.29.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-03-16 at 09:32 +0000, Martin Townsend wrote:
> [Resending to new integrity mailing list]
> 
> Hi,
> 
> I have a system with a pre-signed UBI root filesystem image with both
> IMA/EVM signatures on all files.  The Root CA Cert is compiled into
> the kernel and the public keys is in the rootfs.  All SMACK labels
> have also been applied although at this early stage there aren't many
> (just a few application specific ones) so it's mainly the defaults.
> This image is then flashed to the on board NAND.
> 
> The kernel bootargs for IMA are
> 
> "ima_audit=1 ima_template=ima-ng ima_hash=sha1 ima_tcb
> ima_appraise_tcb rootflags=i_version"
> 
> and I'm enabling SMACK by using the kernel bootarg
> 
> "security=smack"
> 
> now if I boot without the "security=smack" it boots fine and I can
> check the IMA/EVM signatures and can see that measurements are being
> taken, but if I enable SMACK using the above kernel bootarg it fails
> to boot and it looks like some problem early in systemd where it
> mounts the required filesystems in mount-setup.c (log provided below).
> Now if I flash an image that hasn't been signed and enable SMACK it
> boots fine and I can use SMACK to enforce access control.  So there
> seems to some interaction between the two when mounting the early
> filesystems.
> 
> Before I delve into this I would appreciate any pointers to where to
> start looking, any printk's to put in SMACK/IMA/mount code to help
> diagnose this would be really appreciated.
> 
> The Kernel is 4.9 LTSI, systemd is v229
> 
> Apologies if I have the wrong mailing list for SMACK, I couldn't find
> one on vger.kernel.org.
> 
> 
> Boot log.
> ...
> Security Framework initialized
> Smack:  Initializing.
> Smack:  IPv6 port labeling enabled.
> Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
> Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
> CPU: Testing write buffer coherency: ok
> Setting up static identity map for 0x80100000 - 0x80100058
> devtmpfs: initialized
> evm: security.SMACK64
> evm: security.SMACK64EXEC
> evm: security.SMACK64TRANSMUTE
> evm: security.SMACK64MMAP
> evm: security.ima
> evm: security.capability
> ...
> Loading compiled-in X.509 certificates
> Loaded X.509 cert 'IMA-EVM Root CA: cc972d25acf7c1efaa5329a48104efa303f0833a'
> ...
> UBIFS (ubi0:0): FS size: 201764864 bytes (192 MiB, 1589 LEBs), journal
> size 9023488 bytes (8 MiB, 72 LEBs)
> UBIFS (ubi0:0): reserved for root: 0 bytes (0 KiB)
> UBIFS (ubi0:0): media format: w4/r0 (latest is w4/r0), UUID
> F6EA70A5-1931-4049-89CB-93B82F37F6A4, small LPT model
> VFS: Mounted root (ubifs filesystem) readonly on device 0:16.
> devtmpfs: mounted
> integrity: Loaded X.509 cert 'IMA Certificate Authority:
> e2c191a6e31fd02d6beba0c7c7847720a35fd9c6': /etc/keys/ima-x509.der
> Freeing unused kernel memory: 1024K
> systemd[1]: Successfully loaded Smack policies.
> systemd[1]: Successfully loaded Smack/CIPSO policies.
> systemd[1]: System time before build time, advancing clock.
> systemd[1]: Failed to mount tmpfs at /dev/shm: No such file or directory
> systemd[1]: Failed to mount tmpfs at /dev/shm: No such file or directory
> systemd[1]: Failed to mount cgroup at /sys/fs/cgroup/systemd: No such
> file or directory
> [!!!!!!] Failed to mount API filesystems, freezing.
> systemd[1]: Freezing execution.

[Cc'ing Sascha]

Are there any additional messages in /var/log/audit/audit.log?

Mimi
