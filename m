Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE33DC43460
	for <linux-integrity@archiver.kernel.org>; Mon, 10 May 2021 14:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96D0E60241
	for <linux-integrity@archiver.kernel.org>; Mon, 10 May 2021 14:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbhEJOkU (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 10 May 2021 10:40:20 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:58289 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237375AbhEJOhv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 May 2021 10:37:51 -0400
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 May 2021 10:37:47 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 14AERGiS010690;
        Mon, 10 May 2021 17:27:16 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 5273D63A17; Mon, 10 May 2021 17:27:22 +0300 (IDT)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        peterhuewe@gmx.de, jgg@ziepe.ca
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v1] add longer timeout for verify signature command
Date:   Mon, 10 May 2021 17:27:18 +0300
Message-Id: <20210510142719.48153-1-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

while testing TPM2_CC_VERIFY_SIGNATURE with usage of RSA 3070-bit keys i
encountered a timeout error. it seems current values do not support this case
as described in ptp 1.05 6.5.1.3:
https://trustedcomputinggroup.org/wp-content/uploads/PC_Client_Specific-Platform_TPM_Profile_for-PTP_2p0-v1p05p_r14_pub.pdf

The patch was tested on Raspberry-Pie 3, using Nuvoton NPCT75X TPM.


Amir Mizinski (1):
  tpm2: add longer timout for verify signature command

 drivers/char/tpm/tpm2-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4

