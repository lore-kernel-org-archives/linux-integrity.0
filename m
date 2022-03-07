Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34530C433F5
	for <linux-integrity@archiver.kernel.org>; Mon,  7 Mar 2022 20:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbiCGU7C (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 7 Mar 2022 15:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbiCGU7B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Mar 2022 15:59:01 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB493DEF9;
        Mon,  7 Mar 2022 12:58:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1646686686;
        bh=pqCW5Q4jBooVQ4Ak0RS+cgqbLH7tCSHyZBzKzD6KeGM=;
        h=Message-ID:Subject:From:To:Date:From;
        b=UD85TI7VFQmmhulPSuKnt7aFjqdyDITLIZmpoOx8lpePZerV/t1J5fi2gTqQ1JRPS
         OMxKDei+Rl+xHHNr4QIBrAdW1qr2O3S+VhicYmW4ih4VPFbYCqGq+fJ5MuZGB1QQus
         X/tEYMoVZ3Q5LuptRyfo/vJ7gFsCkXCqJvf0erkw=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 48F9D1281471;
        Mon,  7 Mar 2022 15:58:06 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nnGsnpXZNI1N; Mon,  7 Mar 2022 15:58:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1646686686;
        bh=pqCW5Q4jBooVQ4Ak0RS+cgqbLH7tCSHyZBzKzD6KeGM=;
        h=Message-ID:Subject:From:To:Date:From;
        b=UD85TI7VFQmmhulPSuKnt7aFjqdyDITLIZmpoOx8lpePZerV/t1J5fi2gTqQ1JRPS
         OMxKDei+Rl+xHHNr4QIBrAdW1qr2O3S+VhicYmW4ih4VPFbYCqGq+fJ5MuZGB1QQus
         X/tEYMoVZ3Q5LuptRyfo/vJ7gFsCkXCqJvf0erkw=
Received: from jarvis.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4300:c551::527])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 5CBC1128111C;
        Mon,  7 Mar 2022 15:58:05 -0500 (EST)
Message-ID: <3953c743ce7e7fc1db26f5b849b53df671b2f221.camel@HansenPartnership.com>
Subject: [PATCH] tpm: use try_get_ops() in tpm-space.c
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 07 Mar 2022 15:58:03 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

As part of the series conversion to remove nested TPM operations:

https://lore.kernel.org/all/20190205224723.19671-1-jarkko.sakkinen@linux.intel.com/

exposure of the chip->tpm_mutex was removed from much of the upper
level code.  In this conversion, tpm2_del_space() was missed.  This
didn't matter much because it's usually called closely after a
converted operation, so there's only a very tiny race window where the
chip can be removed before the space flushing is done which causes a
NULL deref on the mutex.  However, there are reports of this window
being hit in practice, so fix this by converting tpm2_del_space() to
use tpm_try_get_ops(), which performs all the teardown checks before
acquring the mutex.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm2-space.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 265ec72b1d81..ffb35f0154c1 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -58,12 +58,12 @@ int tpm2_init_space(struct tpm_space *space, unsigned int buf_size)
 
 void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 {
-	mutex_lock(&chip->tpm_mutex);
-	if (!tpm_chip_start(chip)) {
+
+	if (tpm_try_get_ops(chip) == 0) {
 		tpm2_flush_sessions(chip, space);
-		tpm_chip_stop(chip);
+		tpm_put_ops(chip);
 	}
-	mutex_unlock(&chip->tpm_mutex);
+
 	kfree(space->context_buf);
 	kfree(space->session_buf);
 }
-- 
2.34.1


