Return-Path: <SRS0=vu0O=OW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B517C65BAE
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Dec 2018 11:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2832086D
	for <linux-integrity@archiver.kernel.org>; Thu, 13 Dec 2018 11:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2832086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-integrity-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbeLML5V (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 13 Dec 2018 06:57:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:50984 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728625AbeLML5V (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Dec 2018 06:57:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 588BAAFDE;
        Thu, 13 Dec 2018 11:57:19 +0000 (UTC)
Date:   Thu, 13 Dec 2018 05:57:17 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     amir73il@gmail.com, zohar@linux.ibm.com,
        syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com, linux-integrity@vger.kernel.org,
        linux-unionfs@vger.kernel.org, dvyukov@google.com
Subject: [PATCH] fs: Evaluate O_WRONLY | O_RDWR to O_RDWR
Message-ID: <20181213115717.p7ncktng2ihxw5md@merlin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180323
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A user can open(O_WRONLY | O_RDWR) and the options are valid.
However, OPEN_FMODE() evaluates both FMODE_READ and FMODE_WRITE,
as negative. We also need to protect the lower layers from this
anomaly.

Solve it by dropping O_WRONLY, so O_RDWR takes precedence.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reported-by: syzbot+ae82084b07d0297e566b@syzkaller.appspotmail.com
Fixes: a408e4a86b36 ("ima: open a new file instance if no read permissions")
---
 fs/open.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 0285ce7dbd51..3d0a21600fa3 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -924,7 +924,12 @@ EXPORT_SYMBOL(open_with_fake_path);
 static inline int build_open_flags(int flags, umode_t mode, struct open_flags *op)
 {
 	int lookup_flags = 0;
-	int acc_mode = ACC_MODE(flags);
+	int acc_mode;
+
+	if ((flags & (O_RDWR | O_WRONLY)) == (O_RDWR | O_WRONLY))
+		flags &= ~O_WRONLY;
+
+	acc_mode = ACC_MODE(flags);
 
 	/*
 	 * Clear out all open flags we don't know about so that we don't report
-- 
2.16.4
