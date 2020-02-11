Return-Path: <SRS0=Yr3x=37=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B048C352A4
	for <linux-integrity@archiver.kernel.org>; Tue, 11 Feb 2020 02:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4125920733
	for <linux-integrity@archiver.kernel.org>; Tue, 11 Feb 2020 02:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ior5+5SM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgBKCsI (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 10 Feb 2020 21:48:08 -0500
Received: from linux.microsoft.com ([13.77.154.182]:49812 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbgBKCsH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 21:48:07 -0500
Received: from tusharsu-Ubuntu.corp.microsoft.com (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id EF1842010ADD;
        Mon, 10 Feb 2020 18:48:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF1842010ADD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1581389287;
        bh=XHJmcrml0bOhkfiWegb1wXW/R0Kk93NkGo6uSyYSInU=;
        h=From:To:Cc:Subject:Date:From;
        b=ior5+5SMDkaHnxmhZynCL5epre8DclFeu9Z/Ly8qKQYsQqtotx3PBhep6uejZTu2b
         cMn5HrWIv9FihR7DsDsXm6LPodd6H3TZaqrm5MNCD2FMxXYpMnEKUA3r+HzE0cqvO4
         xruhA+FN7VyFpGZA451xvS+06pzRsVE7+DeEoZCU=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, joe@perches.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] IMA: Update KBUILD_MODNAME for IMA files to ima
Date:   Mon, 10 Feb 2020 18:47:53 -0800
Message-Id: <20200211024755.5579-1-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Log statements from ima_mok.c, ima_asymmetric_keys.c, and
ima_queue_keys.c are prefixed with the respective file names
and not with the string "ima". 

This change fixes the log statement prefix to be consistent with the rest
of the IMA files.

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 064a256f8725..67dabca670e2 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -11,6 +11,6 @@ ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
-obj-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
-obj-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
-obj-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
+ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
+ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
+ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
-- 
2.17.1

