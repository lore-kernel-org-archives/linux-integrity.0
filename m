Return-Path: <SRS0=tgSf=77=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA77C433DF
	for <linux-integrity@archiver.kernel.org>; Thu, 18 Jun 2020 18:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD683208DB
	for <linux-integrity@archiver.kernel.org>; Thu, 18 Jun 2020 18:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbgFRSKU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 18 Jun 2020 14:10:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:42712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgFRSKS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jun 2020 14:10:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C4CEDB19A;
        Thu, 18 Jun 2020 18:10:16 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH ima-evm-utils] cmd_ima_bootaggr: Fix for systems without TPM 2.0
Date:   Thu, 18 Jun 2020 20:10:07 +0200
Message-Id: <20200618181007.148765-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.27.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

For both kernel with and without CONFIG_IMA=y.

NOTE: ima_boot_aggregate was added in dc00c92, without TPM 2.0
it just reported:
EVP_DigestInit() failed
(null):

Fixes: 917317a ("ima_evm_utils: emit the per TPM PCR bank
"boot_aggregate" values")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 src/evmctl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 1d065ce..94ec56b 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1998,11 +1998,17 @@ static int cmd_ima_bootaggr(struct command *cmd)
 	 * Format: <hash algorithm name>:<boot_aggregate digest>\n ...
 	 */
 	for (i = 0; i < num_banks; i++) {
-		if (!tpm_banks[i].supported)
+		if (!tpm_banks[i].supported || !tpm_banks[i].algo_name)
 			continue;
 		bootaggr_len += strlen(tpm_banks[i].algo_name) + 1;
 		bootaggr_len += (tpm_banks[i].digest_size * 2) + 1;
 	}
+
+	if (!bootaggr_len) {
+		log_info("No TPM 2.0 PCR bank algorithm found (no TPM 2.0?)\n");
+		return -1;
+	}
+
 	bootaggr = malloc(bootaggr_len);
 
 	/*
@@ -2012,7 +2018,7 @@ static int cmd_ima_bootaggr(struct command *cmd)
 	 * strings.
 	 */
 	for (i = 0; i < num_banks; i++) {
-		if (!tpm_banks[i].supported)
+		if (!tpm_banks[i].supported || !tpm_banks[i].algo_name)
 			continue;
 		calc_bootaggr(&tpm_banks[i]);
 		offset += append_bootaggr(bootaggr + offset, tpm_banks + i);
-- 
2.27.0.rc0

