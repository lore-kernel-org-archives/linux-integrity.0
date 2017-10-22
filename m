Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:51163 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751589AbdJVLa4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 Oct 2017 07:30:56 -0400
Subject: [PATCH 2/2] xen-tpmfront: Combine two condition checks into one
 statement in vtpm_send()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <cf592c7d-8fbc-833b-fa1a-ff9e91c3734c@users.sourceforge.net>
Message-ID: <f1d76752-d5b4-649d-b11d-63348d439505@users.sourceforge.net>
Date: Sun, 22 Oct 2017 13:30:46 +0200
MIME-Version: 1.0
In-Reply-To: <cf592c7d-8fbc-833b-fa1a-ff9e91c3734c@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 22 Oct 2017 13:15:16 +0200

A return was performed with the same error code after two condition checks.
Thus use a single statement instead.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/char/tpm/xen-tpmfront.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/tpm/xen-tpmfront.c b/drivers/char/tpm/xen-tpmfront.c
index 873a5631937a..0d02743e7a87 100644
--- a/drivers/char/tpm/xen-tpmfront.c
+++ b/drivers/char/tpm/xen-tpmfront.c
@@ -82,10 +82,7 @@ static int vtpm_send(struct tpm_chip *chip, u8 *buf, size_t count)
 	u32 ordinal;
 	unsigned long duration;
 
-	if (offset > PAGE_SIZE)
-		return -EINVAL;
-
-	if (offset + count > PAGE_SIZE)
+	if (offset > PAGE_SIZE || offset + count > PAGE_SIZE)
 		return -EINVAL;
 
 	/* Wait for completion of any existing command or cancellation */
-- 
2.14.2
