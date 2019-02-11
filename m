Return-Path: <SRS0=a4os=QS=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E945C169C4
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 16:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517552229F
	for <linux-integrity@archiver.kernel.org>; Mon, 11 Feb 2019 16:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfBKQzA (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:55:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:36074 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726036AbfBKQy6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Feb 2019 11:54:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 53AE8AC8D;
        Mon, 11 Feb 2019 16:54:57 +0000 (UTC)
From:   Ignaz Forster <iforster@suse.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Cc:     Fabian Vogt <fvogt@suse.com>
Subject: [PATCH 1/5] evm: instead of using the overlayfs i_ino, use the real i_ino
Date:   Mon, 11 Feb 2019 17:53:19 +0100
Message-Id: <20190211165323.9369-2-iforster@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190211165323.9369-1-iforster@suse.com>
References: <20190211165323.9369-1-iforster@suse.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Mimi Zohar <zohar@linux.ibm.com>

Using the overlayfs i_ino value in the HMAC calculation results in not
being able to validate the EVM HMAC.  This patch calculates the HMAC
using the real i_ino.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/evm/evm_crypto.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index 43e2dc3a60d0..baddbbce6ac7 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -241,6 +241,9 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		if (is_ima)
 			ima_present = true;
 	}
+
+	/* Use the real i_ino to calculate the HMAC */
+	inode = d_real_inode(dentry);
 	hmac_add_misc(desc, inode, type, data->digest);
 
 	/* Portable EVM signatures must include an IMA hash */
-- 
2.20.1

