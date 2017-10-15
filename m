Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751165AbdJODLN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Oct 2017 23:11:13 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9F3BDL5146753
        for <linux-integrity@vger.kernel.org>; Sat, 14 Oct 2017 23:11:13 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dkdw8x0g2-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sat, 14 Oct 2017 23:11:12 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 15 Oct 2017 04:11:10 +0100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9F3B7IR27066420
        for <linux-integrity@vger.kernel.org>; Sun, 15 Oct 2017 03:11:08 GMT
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
        by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9F3B7Ef018410
        for <linux-integrity@vger.kernel.org>; Sun, 15 Oct 2017 14:11:07 +1100
Subject: Re: IMA appraisal against xz-compressed modules
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>,
        linux-integrity@vger.kernel.org
Cc: lwang@redhat.com
Date: Sat, 14 Oct 2017 23:11:03 -0400
In-Reply-To: <20171012145520.GC2495@glitch>
References: <20171012145520.GC2495@glitch>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508037063.3426.79.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-10-12 at 10:55 -0400, Bruno E. O. Meneguele wrote:
> Hi, 
> 
> recently, while playing around with IMA modules check support, I notice
> that when the kernel was compiled/installed with XZ-compressed modules
> the IMA kernel infra returns -EACCESS on modules initialization. Let me
> detail a bit more:
> 
> I created the policy file (/etc/ima/ima-policy) with
> 
> measure func=MODULE_CHECK uid=0
> (... and more, policy file is attached)
> 
> then rebooted the kernel (that was built with XZ-compressed modules) and
> a bunch of modules didn't load, e.g.:
> 
> without ima-policy:
> # lsmod | wc -l
> 32
> 
> with it:
> # lsmod | wc -l
> 14
> 
> these 14 modules were all loaded during initram booting phase, but if I
> rmmod some of them and try to modprobe (strace output):
> 
> init_module(0x55b9bcc9bba0, 17763, "") = -1 EACCES (Permission denied)
> 
> The point is that there is no violation, because the error occurs right
> after kmod calls init_module() and the call follows to ima_read_file()
> (kernel tree: security/integrity/ima/ima_main.c) which returns -EACCES,
> since there is no 'file' structure available (init_module uses memory
> region only and not file descriptor).

IMA hashes/signatures are stored as xattrs, which requires a file
descriptor.  IMA only supports the new kernel module syscall, which
provides the file descriptor.

> I notice this behavior using Fedora 26 (using SELinux as sec framework)
> and up-to-date kernel, the question is: should IMA kernel mechanism
> support memory regions integrity measurements, maybe following the steps
> that MODULE_SIGNATURE takes (that check for module signature through its
> mmap region), allowing compressed modules to be loaded? Or kernels built
> with XZ/GZ-compressed modules was never meant to be supported? Is it a
> bug or a possible enhancement?

If the IMA policy requires kernel modules to be signed, an appended
signature is permitted as long as the kernel is configured with
CONFIG_MODULE_SIG_FORCE enabled.

Mimi

> Well, thank you guys in advance.
> 
> /etc/ima/ima-policy:
> 
> # PROC_SUPER_MAGIC
> dont_measure fsmagic=0x9fa0
> # SYSFS_MAGIC
> dont_measure fsmagic=0x62656572
> # DEBUGFS_MAGIC
> dont_measure fsmagic=0x64626720
> # TMPFS_MAGIC
> dont_measure fsmagic=0x01021994
> # RAMFS_MAGIC
> dont_measure fsmagic=0x858458f6
> # SECURITYFS_MAGIC
> dont_measure fsmagic=0x73636673
> # MEASUREMENTS
> measure func=BPRM_CHECK
> measure func=FILE_MMAP mask=MAY_EXEC
> measure func=MODULE_CHECK uid=0
> 
