Return-Path: <SRS0=ac69=3K=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4612C2D0CE
	for <linux-integrity@archiver.kernel.org>; Tue, 21 Jan 2020 17:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EBF2465B
	for <linux-integrity@archiver.kernel.org>; Tue, 21 Jan 2020 17:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZoLn8nS6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgAURNN (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:13:13 -0500
Received: from linux.microsoft.com ([13.77.154.182]:51160 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgAURNN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jan 2020 12:13:13 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8088220B4798;
        Tue, 21 Jan 2020 09:13:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8088220B4798
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1579626792;
        bh=4d23IOuwwmeJeaRu6c99Bav9ImfA/rQDKq2tTLeuCSw=;
        h=From:To:Cc:Subject:Date:From;
        b=ZoLn8nS6Z9bPDtkxbcGdFOzZk7EQ/di/T3/lGGtUIDG56B4I5sTOaLb/tixqmK339
         Y6qssmNlw9YNwm/2g4pMie6I2/aQ6VI1M7kibgZrTr0RemrH0mY8W1aylfIFh2d9T4
         UrP1/labEksJ5r43pqdWBlz6nMCdFGPF8yWHydeQ=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] IMA: Turn IMA_MEASURE_ASYMMETRIC_KEYS off by default
Date:   Tue, 21 Jan 2020 09:13:02 -0800
Message-Id: <20200121171302.4935-1-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Enabling IMA and ASYMMETRIC_PUBLIC_KEY_SUBTYPE configs will
automatically enable the IMA hook to measure asymmetric keys. Keys
created or updated early in the boot process are queued up whether
or not a custom IMA policy is provided. Although the queued keys will
be freed if a custom IMA policy is not loaded within 5 minutes, it could
still cause significant performance impact on smaller systems.

This patch turns the config IMA_MEASURE_ASYMMETRIC_KEYS off by default.
Since a custom IMA policy that defines key measurement is required to
measure keys, systems that require key measurement can enable this
config option in addition to providing a custom IMA policy.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/Kconfig | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 355754a6b6ca..8e678219ee9e 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -312,7 +312,19 @@ config IMA_APPRAISE_SIGNED_INIT
 	   This option requires user-space init to be signed.
 
 config IMA_MEASURE_ASYMMETRIC_KEYS
-	bool
+	bool "Enable asymmetric keys measurement on key create or update"
 	depends on IMA
 	depends on ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
-	default y
+	default n
+	help
+	   This option enables measuring asymmetric keys when the key
+	   is created or updated. Additionally a custom IMA policy that
+	   defines key measurement should also be loaded.
+
+	   If this option is enabled, keys created or updated early in
+	   the boot process are queued up. The queued keys are processed
+	   when a custom IMA policy is loaded. But if a custom IMA policy
+	   is not loaded within 5 minutes after IMA subsystem is initialized,
+	   any queued keys are just freed. Keys created or updated after
+	   a custom IMA policy is loaded will be processed immediately and
+	   not queued.
-- 
2.17.1

