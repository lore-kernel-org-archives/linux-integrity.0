Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45891 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbeH3SnF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Aug 2018 14:43:05 -0400
Received: by mail-wr1-f67.google.com with SMTP id 20-v6so8289827wrb.12
        for <linux-integrity@vger.kernel.org>; Thu, 30 Aug 2018 07:40:37 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] tpm: suppress transmit cmd error logs when TPM 1.2 is disabled/deactivated
Date: Thu, 30 Aug 2018 16:40:05 +0200
Message-Id: <20180830144005.6768-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

For TPM 1.2 chips the system setup utility allows to set the TPM device in
one of the following states:

  * Active: Security chip is functional
  * Inactive: Security chip is visible, but is not functional
  * Disabled: Security chip is hidden and is not functional

When choosing the "Inactive" state, the TPM 1.2 device is enumerated and
registered, but sending TPM commands fail with either TPM_DEACTIVATED or
TPM_DISABLED depending if the firmware deactivated or disabled the TPM.

Since these TPM 1.2 error codes don't have special treatment, inactivating
the TPM leads to a very noisy kernel log buffer that shows messages like
the following:

  tpm_tis 00:05: 1.2 TPM (device-id 0x0, rev-id 78)
  tpm tpm0: A TPM error (6) occurred attempting to read a pcr value
  tpm tpm0: TPM is disabled/deactivated (0x6)
  tpm tpm0: A TPM error (6) occurred attempting get random
  tpm tpm0: A TPM error (6) occurred attempting to read a pcr value
  ima: No TPM chip found, activating TPM-bypass! (rc=6)
  tpm tpm0: A TPM error (6) occurred attempting get random
  tpm tpm0: A TPM error (6) occurred attempting get random
  tpm tpm0: A TPM error (6) occurred attempting get random
  tpm tpm0: A TPM error (6) occurred attempting get random

Let's just suppress error log messages for the TPM_{DEACTIVATED,DISABLED}
return codes, since this is expected when the TPM 1.2 is set to Inactive.

In that case the kernel log is cleaner and less confusing for users, i.e:

  tpm_tis 00:05: 1.2 TPM (device-id 0x0, rev-id 78)
  tpm tpm0: TPM is disabled/deactivated (0x6)
  ima: No TPM chip found, activating TPM-bypass! (rc=6)

Reported-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

---

 drivers/char/tpm/tpm-interface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1a803b0cf98..9f61106502a 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -663,7 +663,8 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_space *space,
 		return len;
 
 	err = be32_to_cpu(header->return_code);
-	if (err != 0 && desc)
+	if (err != 0 && err != TPM_ERR_DISABLED && err != TPM_ERR_DEACTIVATED
+	    && desc)
 		dev_err(&chip->dev, "A TPM error (%d) occurred %s\n", err,
 			desc);
 	if (err)
-- 
2.17.1
