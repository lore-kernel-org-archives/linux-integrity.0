Return-Path: <SRS0=WqK7=4H=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC56BC3404D
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Feb 2020 00:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8913C2465D
	for <linux-integrity@archiver.kernel.org>; Wed, 19 Feb 2020 00:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eQZWim38"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgBSAGW (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:06:22 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44388 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbgBSAGW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Feb 2020 19:06:22 -0500
Received: from tusharsu-Ubuntu.corp.microsoft.com (unknown [131.107.147.225])
        by linux.microsoft.com (Postfix) with ESMTPSA id BB6D52007690;
        Tue, 18 Feb 2020 16:06:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB6D52007690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1582070781;
        bh=lmmv8BwguvSfd0HKerD1hdGZVZFucntvwM9yetms1ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQZWim380eXo4NGuZOz5xcVFNBCtgOG5SBnQ7kkqq7jr9BmaenystKjJ8e6SZsADz
         NCzHkUmp1pSAQ+pTZWxfu9SFTrFatNytjLy5XKiovOb3r1xMELl+635YsioXacjhYD
         UIgb5lGIlffDMKATy0s2PgtTjK/YVdisvmACWWwk=
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
To:     zohar@linux.ibm.com, joe@perches.com, skhan@linuxfoundation.org,
        linux-integrity@vger.kernel.org
Cc:     sashal@kernel.org, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3]  IMA: Add log statements for failure conditions
Date:   Tue, 18 Feb 2020 16:06:10 -0800
Message-Id: <20200219000611.28141-3-tusharsu@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200219000611.28141-1-tusharsu@linux.microsoft.com>
References: <20200219000611.28141-1-tusharsu@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

process_buffer_measurement() does not have log messages for failure
conditions.

This change adds a log statement in the above function. 

Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Suggested-by: Joe Perches <joe@perches.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9fe949c6a530..aac1c44fb11b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -757,6 +757,9 @@ void process_buffer_measurement(const void *buf, int size,
 		ima_free_template_entry(entry);
 
 out:
+	if (ret < 0)
+		pr_devel("%s: failed, result: %d\n", __func__, ret);
+
 	return;
 }
 
-- 
2.17.1

