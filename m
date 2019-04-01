Return-Path: <SRS0=wDMX=SD=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D85C43381
	for <linux-integrity@archiver.kernel.org>; Mon,  1 Apr 2019 18:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BB620896
	for <linux-integrity@archiver.kernel.org>; Mon,  1 Apr 2019 18:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nqGC2Lb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbfDAScP (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:32:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40620 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbfDAScP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Apr 2019 14:32:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id u9so5182609pgo.7
        for <linux-integrity@vger.kernel.org>; Mon, 01 Apr 2019 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=MQ0O1mmB+oNGhDova//RYIhWLAO6da/Vm26gjBguPdg=;
        b=nqGC2Lb4Pu4vnyS8A2Wzh7NqHsmc/DUcZ+y6kRoiUsBeB+qNJI33YSr8nUlHRfz3+5
         l3Bu1m5E4j+Aqs8rxoWBjpTBiVnWAe6NnqlPv5BBUhvKALIIzOeklfg4UHQ5KtBMId89
         ohOFs13LMOn3R/dXFxH5lFrBMbswBaN++jSvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=MQ0O1mmB+oNGhDova//RYIhWLAO6da/Vm26gjBguPdg=;
        b=OFHXgr3dAqh95e4tr7QpAFVM09axJZ1z4EZ6K3tMpFqjVNQuj0Z7NVgOI8Fovyi6Cl
         7GXhCR4RNe6mebMPhgImVZ0FVxmjxlot+PKN0q3FeTSrGmWe80PF9cMLWIBoaXEYz9yf
         +XWUuxayfoqyInBIhJwzURuAtbDA3goYI4+U2aKzPPs8HSph7zPLTPj4l2i79K3LmjnQ
         sM8SHoWhOIznZTcq39Ct+USf6TNh6Ez9yrfp317aplH2bS6W9XbT7WdM0I3IpzXwLvE2
         RSGezbLBERwFjMpPGpfJNGJshutrn8Z8IvfFKa9k+pUZlVlJTg0mp+GeixC7Op20+ayr
         oKRw==
X-Gm-Message-State: APjAAAWBsf+9vZv+cJ/pzhRV7JtLiStobox7O9B7EHu4CR2rf6yr8DxR
        nUj/dPnL3xU1UoOweIGJijPDyA==
X-Google-Smtp-Source: APXvYqyQss9q65Nw3XQCSKUkIvnQVl9B/POraABeJVAzzMtJVZmdBEpNbaoevBPbOFPCMjRJzWeiKA==
X-Received: by 2002:a63:6786:: with SMTP id b128mr52832993pgc.318.1554143534143;
        Mon, 01 Apr 2019 11:32:14 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id 71sm22703762pgc.23.2019.04.01.11.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 11:32:12 -0700 (PDT)
Date:   Mon, 1 Apr 2019 11:32:11 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>
Cc:     Phil Baker <baker1tex@gmail.com>, Craig Robson <craig@zhatt.com>,
        Laura Abbott <labbott@redhat.com>,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        linux-integrity@vger.kernel.org
Subject: [PATCH] tpm: Actually fail on TPM errors during "get random"
Message-ID: <20190401183211.GA21228@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A "get random" may fail with a TPM error, but those codes were returned
as-is to the caller, which assumed the result was the number of bytes
that had been written to the target buffer, which could lead to an kernel
heap memory exposure and over-read.

This fixes tpm1_get_random() to mask positive TPM errors into -EIO, as
before.

[   18.092103] tpm tpm0: A TPM error (379) occurred attempting get random
[   18.092106] usercopy: Kernel memory exposure attempt detected from SLUB object 'kmalloc-64' (offset 0, size 379)!

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1650989
Reported-by: Phil Baker <baker1tex@gmail.com>
Reported-by: Craig Robson <craig@zhatt.com>
Fixes: 7aee9c52d7ac ("tpm: tpm1: rewrite tpm1_get_random() using tpm_buf structure")
Cc: Laura Abbott <labbott@redhat.com>
Cc: Tomas Winkler <tomas.winkler@intel.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/char/tpm/tpm1-cmd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
index 85dcf2654d11..faeb78ecf960 100644
--- a/drivers/char/tpm/tpm1-cmd.c
+++ b/drivers/char/tpm/tpm1-cmd.c
@@ -510,7 +510,7 @@ struct tpm1_get_random_out {
  *
  * Return:
  * *  number of bytes read
- * * -errno or a TPM return code otherwise
+ * * -errno (positive TPM return codes are masked to -EIO)
  */
 int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 {
@@ -524,7 +524,7 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 
 	rc = tpm_buf_init(&buf, TPM_TAG_RQU_COMMAND, TPM_ORD_GET_RANDOM);
 	if (rc)
-		return rc;
+		goto fail;
 
 	do {
 		tpm_buf_append_u32(&buf, num_bytes);
@@ -559,7 +559,10 @@ int tpm1_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	rc = total ? (int)total : -EIO;
 out:
 	tpm_buf_destroy(&buf);
-	return rc;
+fail:
+	if (rc < 0)
+		return rc;
+	return -EIO;
 }
 
 #define TPM_ORD_PCRREAD 21
-- 
2.17.1


-- 
Kees Cook
