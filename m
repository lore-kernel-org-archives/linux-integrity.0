Return-Path: <SRS0=E5nz=CV=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE4FC43461
	for <linux-integrity@archiver.kernel.org>; Sat, 12 Sep 2020 19:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6E121D6C
	for <linux-integrity@archiver.kernel.org>; Sat, 12 Sep 2020 19:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgILTgT (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sat, 12 Sep 2020 15:36:19 -0400
Received: from vmicros1.altlinux.org ([194.107.17.57]:45532 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgILTgS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 12 Sep 2020 15:36:18 -0400
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 42A1172CA54;
        Sat, 12 Sep 2020 22:36:16 +0300 (MSK)
Received: from beacon.altlinux.org (unknown [83.220.44.62])
        by imap.altlinux.org (Postfix) with ESMTPSA id 175FF4A4A16;
        Sat, 12 Sep 2020 22:36:16 +0300 (MSK)
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 1/2] ima-evm-utils: Fix reading of sigfile
Date:   Sat, 12 Sep 2020 22:36:13 +0300
Message-Id: <20200912193614.12903-1-vt@altlinux.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fix reading of detached IMA signature (--sigfile). Error message:

  Reading to sha1.txt.sig
  Failed to fread 147 bytes: sha1.txt.sig
  Failed reading: sha1.txt

Reported-by: Mimi Zohar <zohar@linux.ibm.com>
Fixes: 08a51e7460fd ("ima-evm-utils: Fix file2bin stat and fopen relations")
Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
---
 src/evmctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 7ad1150..2359550 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -221,7 +221,7 @@ static unsigned char *file2bin(const char *file, const char *ext, int *size)
 		fclose(fp);
 		return NULL;
 	}
-	if (fread(data, len, 1, fp) != len) {
+	if (fread(data, len, 1, fp) != 1) {
 		log_err("Failed to fread %zu bytes: %s\n", len, name);
 		fclose(fp);
 		free(data);
-- 
2.11.0

