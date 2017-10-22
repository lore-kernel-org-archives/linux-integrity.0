Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:63482 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751583AbdJVL3p (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 Oct 2017 07:29:45 -0400
Subject: [PATCH 1/2] xen-tpmfront: Use common error handling code in
 vtpm_send()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <cf592c7d-8fbc-833b-fa1a-ff9e91c3734c@users.sourceforge.net>
Message-ID: <9cfcbfd0-75c3-4de5-f735-0ace23d2abcb@users.sourceforge.net>
Date: Sun, 22 Oct 2017 13:29:33 +0200
MIME-Version: 1.0
In-Reply-To: <cf592c7d-8fbc-833b-fa1a-ff9e91c3734c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 22 Oct 2017 12:56:42 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/char/tpm/xen-tpmfront.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index 656e8af95d52..873a5631937a 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -90,10 +90,8 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 
 	/* Wait for completion of any existing command or cancellation */
 	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE, chip->timeout_c,
-			&priv->read_queue, true) < 0) {
-		vtpm_cancel(chip);
-		return -ETIME;
-	}
+			      &priv->read_queue, true) < 0)
+		goto cancel_vtpm;
 
 	memcpy(offset + (u8 *)shr, buf, count);
 	shr->length = count;
@@ -108,11 +106,14 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 	if (wait_for_tpm_stat(chip, VTPM_STATUS_IDLE, duration,
 			&priv->read_queue, true) < 0) {
 		/* got a signal or timeout, try to cancel */
-		vtpm_cancel(chip);
-		return -ETIME;
+		goto cancel_vtpm;
 	}
 
 	return count;
+
+cancel_vtpm:
+	vtpm_cancel(chip);
+	return -ETIME;
 }
 
 static int vtpm_recv(struct tpm_chip *chip, u8 *buf, size_t count)
-- 
2.14.2
