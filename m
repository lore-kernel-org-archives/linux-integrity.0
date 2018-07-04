Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-co1nam03on0079.outbound.protection.outlook.com ([104.47.40.79]:26899
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932324AbeGDJEK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Jul 2018 05:04:10 -0400
From: Shirish S <shirish.s@amd.com>
To: linux-integrity@vger.kernel.org
Cc: Shirish S <shirish.s@amd.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: Fix NULL pointer dereference in tpm_transmit()
Date: Wed,  4 Jul 2018 14:33:40 +0530
Message-Id: <1530695020-21888-1-git-send-email-shirish.s@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

During system shutdown,
tpm_class_shutdown() when called with TPM_CHIP_FLAG_TPM2
flag set, makes chip->ops NULL.

However tpm_chip_unregister() called later in shutdown
sequence tries to access chip->ops in tpm_try_transmit()
leading the NULL pointer dereference.

This patch fixes this issue.
Below is the trace for reference:

BUG: unable to handle kernel NULL pointer dereference at
0000000000000048
IP: tpm_transmit+0x267/0x565
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP NOPTI
...
task: ffff937c847fe580 task.stack: ffffa79f80b04000
RIP: 0010:tpm_transmit+0x267/0x565
RSP: 0018:ffffa79f80b07c08 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff937ca9bc8000 RCX: ffff937c847fe580
RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffffffff98e3cd40
RBP: ffffa79f80b07c88 R08: 000000000001fff4 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffa79f80b07cd4
R13: 000000000000008c R14: ffffffffffffffc3 R15: 0000000000000000
FS:  00007ef31f747740(0000) GS:ffff937caed00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000048 CR3: 00000001243d2000 CR4: 00000000001406e0
Call Trace:
tpm_transmit_cmd+0x25/0x70
tpm2_shutdown+0x69/0xa3
? __radix_tree_replace+0xd9/0x120
? idr_replace_ext+0x92/0xb6
tpm_chip_unregister+0xaa/0xdb
cr50_i2c_shutdown+0x1e/0x41
device_shutdown+0x157/0x193
kernel_power_off+0x35/0x6e
SYSC_reboot+0x120/0x1a3
? do_writepages+0x36/0x6e
? do_writepages+0x36/0x6e
? sync_inodes_one_sb+0x17/0x17
? _raw_spin_unlock+0xe/0x20
? iput+0x87/0x1bd
do_syscall_64+0x64/0x72
entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 drivers/char/tpm/tpm-interface.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index e32f6e8..b14d196 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -411,6 +411,14 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip,
 	unsigned long stop;
 	bool need_locality;
 
+	/* chip->ops is made NULL in tpm_class_shutdown()
+	 * This case is hit when tpm_chip_unregister() is called post
+	 * tpm_class_shutdown(), hence exit early and return
+	 * transmit operation not permitted
+	 */
+	if (!chip->ops)
+		return -EPERM;
+
 	rc = tpm_validate_command(chip, space, buf, bufsiz);
 	if (rc == -EINVAL)
 		return rc;
-- 
2.7.4
