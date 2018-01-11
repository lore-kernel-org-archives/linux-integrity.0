Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42635 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932342AbeAKU2j (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jan 2018 15:28:39 -0500
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        linux-integrity@vger.kernel.org
Subject: [RFC PATCH 2/2] security/ima: Run measurements after policy
Date: Thu, 11 Jan 2018 21:28:21 +0100
Message-Id: <20180111202821.31639-3-pvorel@suse.cz>
In-Reply-To: <20180111202821.31639-1-pvorel@suse.cz>
References: <20180111202821.31639-1-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This fixes failing policy tests when no IMA is configured on SUT.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/ima | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/runtest/ima b/runtest/ima
index 20d2e0810..3462d12b1 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -1,5 +1,5 @@
 #DESCRIPTION:Integrity Measurement Architecture (IMA)
-ima01 ima_measurements.sh
-ima02 ima_policy.sh
+ima01 ima_policy.sh
+ima02 ima_measurements.sh
 ima03 ima_tpm.sh
 ima04 ima_violations.sh
-- 
2.15.1
