Return-Path: <linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D86EBC433ED
	for <linux-integrity@archiver.kernel.org>; Thu, 15 Apr 2021 11:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B62536137D
	for <linux-integrity@archiver.kernel.org>; Thu, 15 Apr 2021 11:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhDOL17 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 15 Apr 2021 07:27:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:51624 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbhDOL17 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Apr 2021 07:27:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 663EEAE20;
        Thu, 15 Apr 2021 11:27:35 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH v3 2/2] tests/install-swtpm.sh: Add tar option --no-same-owner
Date:   Thu, 15 Apr 2021 13:27:28 +0200
Message-Id: <20210415112728.9307-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415112728.9307-1-pvorel@suse.cz>
References: <20210415112728.9307-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

to workaround running out of subuids/subgids when using podman:
tar: ./LICENSE: Cannot change ownership to uid 339315, gid 578953: Invalid argument

(run script under sudo would also work, but this does not require it)

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3:
* new commit

Feel free to squash it to the previous commit.

Kind regards,
Petr

 tests/install-swtpm.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/install-swtpm.sh b/tests/install-swtpm.sh
index 2d8293a..2666748 100755
--- a/tests/install-swtpm.sh
+++ b/tests/install-swtpm.sh
@@ -6,7 +6,7 @@ version=1637
 wget --no-check-certificate https://sourceforge.net/projects/ibmswtpm2/files/ibmtpm${version}.tar.gz/download
 mkdir ibmtpm$version
 cd ibmtpm$version
-tar -xvzf ../download
+tar --no-same-owner -xvzf ../download
 cd src
 make -j$(nproc)
 sudo cp tpm_server /usr/local/bin/
-- 
2.31.1

