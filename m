Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44390C4707A
	for <linux-integrity@archiver.kernel.org>; Sun, 23 May 2021 15:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A8A61244
	for <linux-integrity@archiver.kernel.org>; Sun, 23 May 2021 15:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbhEWPhz (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 23 May 2021 11:37:55 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:60495 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231820AbhEWPhy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 May 2021 11:37:54 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 14NFaEPb020104;
        Sun, 23 May 2021 18:36:14 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id DE39E63A1B; Sun, 23 May 2021 18:36:20 +0300 (IDT)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko@kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v3] tpm2: add longer timeout for verify signature command
Date:   Sun, 23 May 2021 18:36:10 +0300
Message-Id: <20210523153610.86927-2-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20210523153610.86927-1-amirmizi6@gmail.com>
References: <20210523153610.86927-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

While running a TPM2_CC_VERIFY_SIGNATURE operation with RSA 3072-bit
keys the TPM driver fails with the following error:

"kernel: [ 2416.187522] tpm tpm0: Operation Timed out"

Since the TPM PC Client specification does not specify a number for
verify signature operation timeout, and the duration of
TPM2_CC_VERIFY_SIGNATURE with RSA 3070-bit keys exceeds the current timeout
of TPM_LONG (2 seconds), it is preferable to pick the longest timeout
possible.

Therefore, set the duration for TPM2_CC_VERIFY_SIGNATUE to TPM_LONG_LONG
(5 minutes).

link: https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/

Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm2-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 7603295..e71154b 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -87,7 +87,7 @@ static u8 tpm2_ordinal_duration_index(u32 ordinal)
 		return TPM_MEDIUM;
 
 	case TPM2_CC_VERIFY_SIGNATURE:        /* 177 */
-		return TPM_LONG;
+		return TPM_LONG_LONG;
 
 	case TPM2_CC_PCR_EXTEND:              /* 182 */
 		return TPM_MEDIUM;
-- 
2.7.4

