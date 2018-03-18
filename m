Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42830 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752721AbeCRB2C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 17 Mar 2018 21:28:02 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2I1OIFP134689
        for <linux-integrity@vger.kernel.org>; Sat, 17 Mar 2018 21:28:02 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gry5tn9cp-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sat, 17 Mar 2018 21:28:01 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 18 Mar 2018 01:27:59 -0000
Subject: Re: [PATCH] ima: Avoid using not initialized IMA
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Sat, 17 Mar 2018 21:27:56 -0400
In-Reply-To: <20180316232827.3791-1-pvorel@suse.cz>
References: <20180316232827.3791-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521336476.3503.74.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sat, 2018-03-17 at 00:28 +0100, Petr Vorel wrote:
> IMA requires have it's hash algorithm to be compiled-in due it's early
> use. Default IMA algorithm is protected by Kconfig to be compiled-in.
> 
> ima_hash kernel parameter allows to choose hash algorithm. When
> specified algorithm not available or available as module, IMA
> initialization fails, but mknodat syscall expect it and calls
> ima_post_path_mknod(). This leads to to kernel oops:
> 
> $ grep CONFIG_CRYPTO_MD4 .config
> CONFIG_CRYPTO_MD4=m
> 
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.12.14-2.3-default root=UUID=74ae8202-9ca7-4e39-813b-22287ec52f7a video=1024x768-16 plymouth.ignore-serial-consoles console=ttyS0 console=tty resume=/dev/disk/by-path/pci-0000:00:07.0-part3 splash=silent showopts ima_hash=md4
> ...
> [    1.545190] ima: Can not allocate md4 (reason: -2)

The hash algorithm specified on the boot command line needs to be
builtin.  For whatever reason it isn't builtin, rather than skipping
measurements, a better solution I think would be to fallback to the
builtin hash algorithm.

Mimi

> ...
> [    2.610120] BUG: unable to handle kernel NULL pointer dereference at           (null)
> [    2.611903] IP: ima_match_policy+0x23/0x390
> [    2.612967] PGD 0 P4D 0
> [    2.613080] Oops: 0000 [#1] SMP
> [    2.613080] Modules linked in: autofs4
> [    2.613080] Supported: Yes
> [    2.613080] CPU: 0 PID: 1 Comm: systemd Not tainted 4.12.14-2.3-default #1
> [    2.613080] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
> [    2.613080] task: ffff88003e2d0040 task.stack: ffffc90000190000
> [    2.613080] RIP: 0010:ima_match_policy+0x23/0x390
> [    2.613080] RSP: 0018:ffffc90000193e88 EFLAGS: 00010296
> [    2.613080] RAX: 0000000000000000 RBX: 000000000000000c RCX: 0000000000000004
> [    2.613080] RDX: 0000000000000010 RSI: 0000000000000001 RDI: ffff880037071728
> [    2.613080] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000000
> [    2.613080] R10: 0000000000000008 R11: 61c8864680b583eb R12: 00005580ff10086f
> [    2.613080] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000008000
> [    2.613080] FS:  00007f5c1da08940(0000) GS:ffff88003fc00000(0000) knlGS:0000000000000000
> [    2.613080] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.613080] CR2: 0000000000000000 CR3: 0000000037002000 CR4: 00000000003406f0
> [    2.613080] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    2.613080] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    2.613080] Call Trace:
> [    2.613080]  ? shmem_mknod+0xbf/0xd0
> [    2.613080]  ima_post_path_mknod+0x1c/0x40
> [    2.613080]  SyS_mknod+0x210/0x220
> [    2.613080]  entry_SYSCALL_64_fastpath+0x1a/0xa5
> [    2.613080] RIP: 0033:0x7f5c1bfde570
> [    2.613080] RSP: 002b:00007ffde1c90dc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000085
> [    2.613080] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5c1bfde570
> [    2.613080] RDX: 0000000000000000 RSI: 0000000000008000 RDI: 00005580ff10086f
> [    2.613080] RBP: 00007ffde1c91040 R08: 00005580ff10086f R09: 0000000000000000
> [    2.613080] R10: 0000000000104000 R11: 0000000000000246 R12: 00005580ffb99660
> [    2.613080] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000002
> [    2.613080] Code: 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56 44 8d 14 09 41 55 41 54 55 53 44 89 d3 09 cb 48 83 ec 38 48 8b 05 c5 03 29 01 <4c> 8b 20 4c 39 e0 0f 84 d7 01 00 00 4c 89 44 24 08 89 54 24 20
> [    2.613080] RIP: ima_match_policy+0x23/0x390 RSP: ffffc90000193e88
> [    2.613080] CR2: 0000000000000000
> [    2.613080] ---[ end trace 9a9f0a8a73079f6a ]---
> [    2.673052] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
> [    2.673052]
> [    2.675337] Kernel Offset: disabled
> [    2.676405] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  security/integrity/ima/ima_main.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 2cfb0c714967..503366805554 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -380,6 +380,9 @@ void ima_post_path_mknod(struct dentry *dentry)
>  	struct inode *inode = dentry->d_inode;
>  	int must_appraise;
> 
> +	if (!ima_initialized)
> +		return;
> +
>  	must_appraise = ima_must_appraise(inode, MAY_ACCESS, FILE_CHECK);
>  	if (!must_appraise)
>  		return;
> --
> 2.12.3
> 
