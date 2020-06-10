Return-Path: <SRS0=hV4h=7X=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA99CC433DF
	for <linux-integrity@archiver.kernel.org>; Wed, 10 Jun 2020 17:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA83D204EC
	for <linux-integrity@archiver.kernel.org>; Wed, 10 Jun 2020 17:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Qm/JAsji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgFJRBm (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:01:42 -0400
Received: from linux.microsoft.com ([13.77.154.182]:57138 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgFJRBm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Jun 2020 13:01:42 -0400
Received: by linux.microsoft.com (Postfix, from userid 1066)
        id 88CF620B71CC; Wed, 10 Jun 2020 10:01:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88CF620B71CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591808501;
        bh=D1wH1dK8bNPhiuEReUqysKhlwE/xussjWlR2j7MN71c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qm/JAsjiOas+sAhE/RT9H1QcoyBm6nm/IECJpdCRiIoBJhdS/S6Dlo6U7dRmYde6O
         zaR46+fy/fmLB67LTtkt0w31dhdpvkVIL1Zy28guFYgNV9szayJVDUM4a9VAp7fNaC
         9pWvb3kW64IRRhF0V1JSE7lqSltgth6yrMajaIgc=
From:   Lachlan Sneff <t-josne@linux.microsoft.com>
To:     ltp@lists.linux.it, pvorel@suse.cz, zohar@linux.ibm.com
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org,
        Lachlan Sneff <t-josne@linux.microsoft.com>
Subject: [PATCH 2/2] IMA: Add a test to verify importing a certificate into keyring
Date:   Wed, 10 Jun 2020 10:01:23 -0700
Message-Id: <1591808483-22040-2-git-send-email-t-josne@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1591808483-22040-1-git-send-email-t-josne@linux.microsoft.com>
References: <1591808483-22040-1-git-send-email-t-josne@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add an IMA measurement test that verifies that an x509 certificate
can be imported into the .ima keyring and measured correctly.

Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
---
 .../security/integrity/ima/tests/ima_keys.sh  | 44 ++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index 1b0dd0aed..6904fabfa 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -7,7 +7,7 @@
 
 TST_NEEDS_CMDS="awk cut"
 TST_SETUP="setup"
-TST_CNT=1
+TST_CNT=2
 TST_NEEDS_DEVICE=1
 
 . ima_setup.sh
@@ -69,4 +69,46 @@ $(echo "$line" | cut -d' ' -f5) keyring"
 	tst_res TPASS "specified keyrings were measured correctly"
 }
 
+
+# Test that a cert can be imported into the ".ima" keyring correctly.
+test2() {
+	local keyring_id key_id
+	CERT_FILE="/etc/keys/x509_ima.der" # Default
+
+	[ -f $CERT_FILE ] || tst_brk TCONF "missing $CERT_FILE"
+
+	if ! openssl x509 -in $CERT_FILE -inform der > /dev/null; then
+		tst_brk TCONF "The suppled cert file ($CERT_FILE) is not \
+a valid x509 certificate"
+	fi
+
+	tst_res TINFO "adding a cert to the \".ima\" keyring ($CERT_FILE)"
+
+	keyring_id=$(sudo keyctl show %:.ima | sed -n 2p | \
+		sed 's/^[[:space:]]*//' | cut -d' ' -f1) || \
+		tst_btk TCONF "unable to retrieve .ima keyring id"
+
+	if ! tst_is_num	"$keyring_id"; then
+		tst_brk TCONF "unable to parse keyring id from keyring"
+	fi
+
+	sudo evmctl import $CERT_FILE "$keyring_id" > /dev/null || \
+		tst_brk TCONF "unable to import a cert into the .ima keyring"
+
+	grep -F ".ima" "$ASCII_MEASUREMENTS" | tail -n1 | cut -d' ' -f6 | \
+		xxd -r -p > $TEST_FILE || \
+		tst_brk TCONF "cert not found in ascii_runtime_measurements log"
+
+	if ! openssl x509 -in $TEST_FILE -inform der > /dev/null; then
+		tst_brk TCONF "The cert logged in ascii_runtime_measurements \
+($CERT_FILE) is not a valid x509 certificate"
+	fi
+
+	if cmp -s "$TEST_FILE" $CERT_FILE; then
+		tst_res TPASS "logged cert matches original cert"
+	else
+		tst_res TFAIL "logged cert does not match original cert"
+	fi
+}
+
 tst_run
-- 
2.25.1

