Return-Path: <SRS0=q+cf=DN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B875C46466
	for <linux-integrity@archiver.kernel.org>; Tue,  6 Oct 2020 14:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5812E2054F
	for <linux-integrity@archiver.kernel.org>; Tue,  6 Oct 2020 14:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgJFO3S (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 6 Oct 2020 10:29:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:33460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgJFO3S (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Oct 2020 10:29:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 68770B297;
        Tue,  6 Oct 2020 14:29:16 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 1/1] travis: Fix Tumbleweed installation
Date:   Tue,  6 Oct 2020 16:28:23 +0200
Message-Id: <20201006142824.12152-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

to prevent fail the job when /usr/lib/ibmtss/tpm_server does not exist.

Fixes: 6c78911 travis: Switch to docker based builds

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

fixed: https://travis-ci.org/github/pevik/ima-evm-utils/jobs/733339306
broken: https://travis-ci.org/github/pevik/ima-evm-utils/jobs/733310157

Sorry for not catching obvious error when using 'set -e'.

Kind regards,
Petr

 travis/tumbleweed.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/travis/tumbleweed.sh b/travis/tumbleweed.sh
index ec4dc43..ecd2372 100755
--- a/travis/tumbleweed.sh
+++ b/travis/tumbleweed.sh
@@ -42,4 +42,6 @@ zypper --non-interactive install --force-resolution --no-recommends \
 	which \
 	xsltproc
 
-[ -f /usr/lib/ibmtss/tpm_server ] && ln -s /usr/lib/ibmtss/tpm_server /usr/local/bin
+if [ -f /usr/lib/ibmtss/tpm_server ]; then
+	ln -s /usr/lib/ibmtss/tpm_server /usr/local/bin
+fi
-- 
2.28.0

