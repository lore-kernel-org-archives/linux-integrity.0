Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C76DC48BCD
	for <linux-integrity@archiver.kernel.org>; Wed,  9 Jun 2021 00:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20746613AC
	for <linux-integrity@archiver.kernel.org>; Wed,  9 Jun 2021 00:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhFIA1d (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 8 Jun 2021 20:27:33 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55024 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233937AbhFIA1b (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Jun 2021 20:27:31 -0400
Received: from sequoia.work.tihix.com (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 76A1A20B7188;
        Tue,  8 Jun 2021 17:25:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 76A1A20B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1623198337;
        bh=uVgZoRO1aKnahUqyjDPzyphebgzUacysdZ2smy7vuKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYdMVv5iB1LK3Di5mjMFdiLD6SdIrjgPU2ltkdhxz9aOl+MJtT9LpoaYetDpYpT79
         zPjY+7IoESwIoT68e3kdXAeA+G1TRuT6Xdg9iOtm9l7cVr52Ke0d4cebJcZwHMzmaS
         eScTtb7dT0H/VYMKZr4DmOUHQmxi2CBHsk11+5KY=
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vikas Gupta <vikas.gupta@broadcom.com>
Cc:     Thirupathaiah Annapureddy <thiruan@microsoft.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        op-tee@lists.trustedfirmware.org, linux-integrity@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/7] optee: Fix memory leak when failing to register shm pages
Date:   Tue,  8 Jun 2021 19:23:20 -0500
Message-Id: <20210609002326.210024-2-tyhicks@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
References: <20210609002326.210024-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Free the previously allocated pages when we encounter an error condition
while attempting to register the pages with the secure world.

Fixes: a249dd200d03 ("tee: optee: Fix dynamic shm pool allocations")
Fixes: 5a769f6ff439 ("optee: Fix multi page dynamic shm pool alloc")
Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
---
 drivers/tee/optee/shm_pool.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/optee/shm_pool.c b/drivers/tee/optee/shm_pool.c
index d767eebf30bd..da06ce9b9313 100644
--- a/drivers/tee/optee/shm_pool.c
+++ b/drivers/tee/optee/shm_pool.c
@@ -32,8 +32,10 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 		struct page **pages;
 
 		pages = kcalloc(nr_pages, sizeof(pages), GFP_KERNEL);
-		if (!pages)
-			return -ENOMEM;
+		if (!pages) {
+			rc = -ENOMEM;
+			goto err;
+		}
 
 		for (i = 0; i < nr_pages; i++) {
 			pages[i] = page;
@@ -44,8 +46,14 @@ static int pool_op_alloc(struct tee_shm_pool_mgr *poolm,
 		rc = optee_shm_register(shm->ctx, shm, pages, nr_pages,
 					(unsigned long)shm->kaddr);
 		kfree(pages);
+		if (rc)
+			goto err;
 	}
 
+	return 0;
+
+err:
+	__free_pages(page, order);
 	return rc;
 }
 
-- 
2.25.1

