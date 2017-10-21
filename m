Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.14]:53905 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932202AbdJUUMB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 21 Oct 2017 16:12:01 -0400
To: linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
        =?UTF-8?Q?Peter_H=c3=bcwe?= <PeterHuewe@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] tpm_i2c_nuvoton: Use common error handling code in
 i2c_nuvoton_send()
Message-ID: <6d2dcc64-af7a-fb71-f863-10d30914269e@users.sourceforge.net>
Date: Sat, 21 Oct 2017 22:11:36 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 21 Oct 2017 22:07:39 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/char/tpm/tpm_i2c_nuvoton.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2c_nuvoton.c
index c6428771841f..f0037e9e2d0e 100644
--- a/drivers/char/tpm/tpm_i2c_nuvoton.c
+++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
@@ -440,15 +440,13 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	}
 	if (rc < 0) {
 		/* retries == TPM_RETRY */
-		i2c_nuvoton_ready(chip);
-		return rc;
+		goto write_ready;
 	}
 	/* execute the TPM command */
 	rc = i2c_nuvoton_write_status(client, TPM_STS_GO);
 	if (rc < 0) {
 		dev_err(dev, "%s() fail to write Go\n", __func__);
-		i2c_nuvoton_ready(chip);
-		return rc;
+		goto write_ready;
 	}
 	ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
 	rc = i2c_nuvoton_wait_for_data_avail(chip,
@@ -457,12 +455,15 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf, size_t len)
 					     &priv->read_queue);
 	if (rc) {
 		dev_err(dev, "%s() timeout command duration\n", __func__);
-		i2c_nuvoton_ready(chip);
-		return rc;
+		goto write_ready;
 	}
 
 	dev_dbg(dev, "%s() -> %zd\n", __func__, len);
 	return len;
+
+write_ready:
+	i2c_nuvoton_ready(chip);
+	return rc;
 }
 
 static bool i2c_nuvoton_req_canceled(struct tpm_chip *chip, u8 status)
-- 
2.14.2
