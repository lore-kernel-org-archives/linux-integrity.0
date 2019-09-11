Return-Path: <SRS0=3gWa=XG=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D59AECDE27
	for <linux-integrity@archiver.kernel.org>; Wed, 11 Sep 2019 09:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DAD921A4C
	for <linux-integrity@archiver.kernel.org>; Wed, 11 Sep 2019 09:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfIKJex (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 11 Sep 2019 05:34:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:45394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725616AbfIKJex (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Sep 2019 05:34:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 537DAAEA4;
        Wed, 11 Sep 2019 09:34:51 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-kselftest@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-integrity@vger.kernel.org
Subject: [PATCH] selftests/tpm2: Add log and *.pyc to .gitignore
Date:   Wed, 11 Sep 2019 11:34:42 +0200
Message-Id: <20190911093442.13412-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.22.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Fixes: 6ea3dfe1e073 ("selftests: add TPM 2.0 tests")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tools/testing/selftests/.gitignore | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/.gitignore b/tools/testing/selftests/.gitignore
index 8059ce834247..61df01cdf0b2 100644
--- a/tools/testing/selftests/.gitignore
+++ b/tools/testing/selftests/.gitignore
@@ -2,3 +2,5 @@ gpiogpio-event-mon
 gpiogpio-hammer
 gpioinclude/
 gpiolsgpio
+tpm2/SpaceTest.log
+tpm2/*.pyc
-- 
2.22.1

