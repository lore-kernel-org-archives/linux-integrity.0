Return-Path: <SRS0=KvCx=U6=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F633C06510
	for <linux-integrity@archiver.kernel.org>; Mon,  1 Jul 2019 15:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20870208E4
	for <linux-integrity@archiver.kernel.org>; Mon,  1 Jul 2019 15:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561995245;
	bh=ffYV/l6ccu4lXg/FKpsd2YnmOvw809vDuYKn+yvO5GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EFJfmwIwZ9X3JE/F3ArkK856pPNlLYRh4P3IA6BETkosfAB/Ne8lZA1h+IFEN+dsZ
	 Cjgd5jCeBI/dlUz74Vqj8AbulQH03Wnh8zR49D9hTLpy0PdiOcQwN4MH+i3jhJoJ6e
	 iuAdqAxef7qNsCVusXgZtbdQhpD0SgjYyruDAREI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbfGAPeE (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:34:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbfGAPeE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Jul 2019 11:34:04 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5D5E2146F;
        Mon,  1 Jul 2019 15:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561995243;
        bh=ffYV/l6ccu4lXg/FKpsd2YnmOvw809vDuYKn+yvO5GQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gtp2PxjpSVA8IQlhUWw9Ep55B2LPFOrylyfNrc/ruiF8N9mx3ILr62VlaLkj1r6uw
         v2epniiugEqNEn49O56OEPhEUkdI1RZbNuJlnEfH8zRlvH2GXS1FO0erymVMfiKcEA
         gvZDNTfQOxwM79RwWRc2XErAmMUSY1Qkc1JvloRQ=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-fscrypt@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v6 02/17] fs-verity: add MAINTAINERS file entry
Date:   Mon,  1 Jul 2019 08:32:22 -0700
Message-Id: <20190701153237.1777-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190701153237.1777-1-ebiggers@kernel.org>
References: <20190701153237.1777-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

fs-verity will be jointly maintained by Eric Biggers and Theodore Ts'o.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6954776a37e..655065116f92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6505,6 +6505,18 @@ S:	Maintained
 F:	fs/notify/
 F:	include/linux/fsnotify*.h
 
+FSVERITY: READ-ONLY FILE-BASED AUTHENTICITY PROTECTION
+M:	Eric Biggers <ebiggers@kernel.org>
+M:	Theodore Y. Ts'o <tytso@mit.edu>
+L:	linux-fscrypt@vger.kernel.org
+Q:	https://patchwork.kernel.org/project/linux-fscrypt/list/
+T:	git git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git fsverity
+S:	Supported
+F:	fs/verity/
+F:	include/linux/fsverity.h
+F:	include/uapi/linux/fsverity.h
+F:	Documentation/filesystems/fsverity.rst
+
 FUJITSU LAPTOP EXTRAS
 M:	Jonathan Woithe <jwoithe@just42.net>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.22.0

