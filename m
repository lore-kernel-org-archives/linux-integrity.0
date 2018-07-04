Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35613 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbeGDOnw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Jul 2018 10:43:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id v3-v6so2485926wmh.0
        for <linux-integrity@vger.kernel.org>; Wed, 04 Jul 2018 07:43:51 -0700 (PDT)
Date: Wed, 4 Jul 2018 08:43:44 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shirish S <shirish.s@amd.com>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Fix NULL pointer dereference in tpm_transmit()
Message-ID: <20180704144344.GA30037@ziepe.ca>
References: <1530695020-21888-1-git-send-email-shirish.s@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1530695020-21888-1-git-send-email-shirish.s@amd.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jul 04, 2018 at 02:33:40PM +0530, Shirish S wrote:
> During system shutdown,
> tpm_class_shutdown() when called with TPM_CHIP_FLAG_TPM2
> flag set, makes chip->ops NULL.
> 
> However tpm_chip_unregister() called later in shutdown
> sequence tries to access chip->ops in tpm_try_transmit()
> leading the NULL pointer dereference.
> 
> This patch fixes this issue.
> Below is the trace for reference:
> 
> BUG: unable to handle kernel NULL pointer dereference at
> 0000000000000048
> IP: tpm_transmit+0x267/0x565
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP NOPTI
> ...
> task: ffff937c847fe580 task.stack: ffffa79f80b04000
> RIP: 0010:tpm_transmit+0x267/0x565
> RSP: 0018:ffffa79f80b07c08 EFLAGS: 00010286
> RAX: 0000000000000000 RBX: ffff937ca9bc8000 RCX: ffff937c847fe580
> RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffffff98e3cd40
> RBP: ffffa79f80b07c88 R08: 000000000001fff4 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffffa79f80b07cd4
> R13: 000000000000008c R14: ffffffffffffffc3 R15: 0000000000000000
> FS:  00007ef31f747740(0000) GS:ffff937caed00000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000048 CR3: 00000001243d2000 CR4: 00000000001406e0
> Call Trace:
> tpm_transmit_cmd+0x25/0x70
> tpm2_shutdown+0x69/0xa3
> ? __radix_tree_replace+0xd9/0x120
> ? idr_replace_ext+0x92/0xb6
> tpm_chip_unregister+0xaa/0xdb
> cr50_i2c_shutdown+0x1e/0x41

It makes no sense to call something like tpm_unregister from shutdown.

Jason
