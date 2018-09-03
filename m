Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:19822 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725762AbeICF2L (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Sep 2018 01:28:11 -0400
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] tpm: fix response size validation in tpm_get_random()
Date: Mon,  3 Sep 2018 04:10:04 +0300
Message-Id: <20180903011004.12161-1-jarkko.sakkinen@linux.intel.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

When checking whether the response is large enough to be able to contain
the received random bytes in tpm_get_random() and tpm2_get_random(),
they fail to take account the header size, which should be added to the
minimum size. This commit fixes this issue.

Cc: stable@vger.kernel.org
Fixes: c659af78eb7b ("tpm: Check size of response before accessing data")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 drivers/char/tpm/tpm-interface.c | 3 ++-
 drivers/char/tpm/tpm2-cmd.c      | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index 1a803b0cf980..318a7078b2ba 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -1321,7 +1321,8 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
 		}
 
 		rlength = be32_to_cpu(tpm_cmd.header.out.length);
-		if (rlength < offsetof(struct tpm_getrandom_out, rng_data) +
+		if (rlength < TPM_HEADER_SIZE +
+			      offsetof(struct tpm_getrandom_out, rng_data) +
 			      recd) {
 			total = -EFAULT;
 			break;
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index c31b490bd41d..3acf4fd4e5a5 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -329,7 +329,9 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 			&buf.data[TPM_HEADER_SIZE];
 		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
 		if (tpm_buf_length(&buf) <
-		    offsetof(struct tpm2_get_random_out, buffer) + recd) {
+		    TPM_HEADER_SIZE +
+		    offsetof(struct tpm2_get_random_out, buffer) +
+		    recd) {
 			err = -EFAULT;
 			goto out;
 		}
-- 
2.17.1
