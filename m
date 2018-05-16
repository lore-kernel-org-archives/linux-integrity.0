Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44550 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752442AbeEPFv5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 May 2018 01:51:57 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4G5nh2Z053009
        for <linux-integrity@vger.kernel.org>; Wed, 16 May 2018 01:51:56 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j08sn4atc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 16 May 2018 01:51:56 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Wed, 16 May 2018 06:51:53 +0100
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.vnet.ibm.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, tpmdd@selhorst.net,
        jgunthorpe@obsidianresearch.com, patrickc@us.ibm.com,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v4 2/2] tpm: reduce polling time to usecs for even finer granularity
Date: Wed, 16 May 2018 01:51:25 -0400
In-Reply-To: <20180516055125.5685-1-nayna@linux.vnet.ibm.com>
References: <20180516055125.5685-1-nayna@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20180516055125.5685-3-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The TPM burstcount and status commands are supposed to return very
quickly [2][3]. This patch further reduces the TPM poll sleep time to usecs
in get_burstcount() and wait_for_tpm_stat() by calling usleep_range()
directly.

After this change, performance on a system[1] with a TPM 1.2 with an 8 byte
burstcount for 1000 extends improved from ~10.7 sec to ~7 sec.

[1] All tests are performed on an x86 based, locked down, single purpose
closed system. It has Infineon TPM 1.2 using LPC Bus.

[2] From the TCG Specification "TCG PC Client Specific TPM Interface
Specification (TIS), Family 1.2":

"NOTE : It takes roughly 330 ns per byte transfer on LPC. 256 bytes would
take 84 us, which is a long time to stall the CPU. Chipsets may not be
designed to post this much data to LPC; therefore, the CPU itself is
stalled for much of this time. Sending 1 kB would take 350 us. Therefore,
even if the TPM_STS_x.burstCount field is a high value, software SHOULD
be interruptible during this period."

[3] From the TCG Specification 2.0, "TCG PC Client Platform TPM Profile
(PTP) Specification":

"It takes roughly 330 ns per byte transfer on LPC. 256 bytes would take
84 us. Chipsets may not be designed to post this much data to LPC;
therefore, the CPU itself is stalled for much of this time. Sending 1 kB
would take 350 us. Therefore, even if the TPM_STS_x.burstCount field is a
high value, software should be interruptible during this period. For SPI,
assuming 20MHz clock and 64-byte transfers, it would take about 120 usec
to move 256B of data. Sending 1kB would take about 500 usec. If the
transactions are done using 4 bytes at a time, then it would take about
1 msec. to transfer 1kB of data."

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>
---
 drivers/char/tpm/tpm.h          | 4 +++-
 drivers/char/tpm/tpm_tis_core.c | 5 +++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 7e797377e1eb..f0e4d290c347 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -54,7 +54,9 @@ enum tpm_timeout {
 	TPM_TIMEOUT = 5,	/* msecs */
 	TPM_TIMEOUT_RETRY = 100, /* msecs */
 	TPM_TIMEOUT_RANGE_US = 300,	/* usecs */
-	TPM_TIMEOUT_POLL = 1	/* msecs */
+	TPM_TIMEOUT_POLL = 1,	/* msecs */
+	TPM_TIMEOUT_USECS_MIN = 100,      /* usecs */
+	TPM_TIMEOUT_USECS_MAX = 500      /* usecs */
 };
 
 /* TPM addresses */
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index 021e6b68f2db..bbd8eed30e57 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -84,7 +84,8 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		}
 	} else {
 		do {
-			tpm_msleep(TPM_TIMEOUT_POLL);
+			usleep_range(TPM_TIMEOUT_USECS_MIN,
+				     TPM_TIMEOUT_USECS_MAX);
 			status = chip->ops->status(chip);
 			if ((status & mask) == mask)
 				return 0;
@@ -226,7 +227,7 @@ static int get_burstcount(struct tpm_chip *chip)
 		burstcnt = (value >> 8) & 0xFFFF;
 		if (burstcnt)
 			return burstcnt;
-		tpm_msleep(TPM_TIMEOUT_POLL);
+		usleep_range(TPM_TIMEOUT_USECS_MIN, TPM_TIMEOUT_USECS_MAX);
 	} while (time_before(jiffies, stop));
 	return -EBUSY;
 }
-- 
2.13.3
