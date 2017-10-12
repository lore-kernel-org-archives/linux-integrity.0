Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750716AbdJLNzY (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Oct 2017 09:55:24 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 20BC147A
        for <linux-integrity@vger.kernel.org>; Thu, 12 Oct 2017 13:55:24 +0000 (UTC)
Date: Thu, 12 Oct 2017 10:55:20 -0400
From: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: lwang@redhat.com
Subject: IMA appraisal against xz-compressed modules
Message-ID: <20171012145520.GC2495@glitch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p2kqVDKq5asng8Dg"
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi, 

recently, while playing around with IMA modules check support, I notice
that when the kernel was compiled/installed with XZ-compressed modules
the IMA kernel infra returns -EACCESS on modules initialization. Let me
detail a bit more:

I created the policy file (/etc/ima/ima-policy) with

measure func=MODULE_CHECK uid=0
(... and more, policy file is attached)

then rebooted the kernel (that was built with XZ-compressed modules) and
a bunch of modules didn't load, e.g.:

without ima-policy:
# lsmod | wc -l
32

with it:
# lsmod | wc -l
14

these 14 modules were all loaded during initram booting phase, but if I
rmmod some of them and try to modprobe (strace output):

init_module(0x55b9bcc9bba0, 17763, "") = -1 EACCES (Permission denied)

The point is that there is no violation, because the error occurs right
after kmod calls init_module() and the call follows to ima_read_file()
(kernel tree: security/integrity/ima/ima_main.c) which returns -EACCES,
since there is no 'file' structure available (init_module uses memory
region only and not file descriptor).

I notice this behavior using Fedora 26 (using SELinux as sec framework)
and up-to-date kernel, the question is: should IMA kernel mechanism
support memory regions integrity measurements, maybe following the steps
that MODULE_SIGNATURE takes (that check for module signature through its
mmap region), allowing compressed modules to be loaded? Or kernels built
with XZ/GZ-compressed modules was never meant to be supported? Is it a
bug or a possible enhancement?

Well, thank you guys in advance.

/etc/ima/ima-policy:

# PROC_SUPER_MAGIC
dont_measure fsmagic=0x9fa0
# SYSFS_MAGIC
dont_measure fsmagic=0x62656572
# DEBUGFS_MAGIC
dont_measure fsmagic=0x64626720
# TMPFS_MAGIC
dont_measure fsmagic=0x01021994
# RAMFS_MAGIC
dont_measure fsmagic=0x858458f6
# SECURITYFS_MAGIC
dont_measure fsmagic=0x73636673
# MEASUREMENTS
measure func=BPRM_CHECK
measure func=FILE_MMAP mask=MAY_EXEC
measure func=MODULE_CHECK uid=0

-- 
bmeneg 
PGP Key: http://bmeneg.com/pubkey.txt


    [ Part 2, Application/PGP-SIGNATURE (Name: "signature.asc") 499 bytes. ]
    [ Unable to print this part. ]
