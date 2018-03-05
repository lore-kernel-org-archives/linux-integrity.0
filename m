Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60596 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932837AbeCENnY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Mar 2018 08:43:24 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w25Devfi001748
        for <linux-integrity@vger.kernel.org>; Mon, 5 Mar 2018 08:43:23 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gh5djcfd9-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 05 Mar 2018 08:43:23 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 5 Mar 2018 13:43:17 -0000
Subject: [PATCH] audit: add containerid support for IMA-audit
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Richard Guy Briggs <rgb@redhat.com>
Cc: containers@lists.linux-foundation.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date: Mon, 05 Mar 2018 08:43:13 -0500
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1520257393.10396.291.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Richard,

This patch has been compiled, but not runtime tested.

---

If the containerid is defined, include it in the IMA-audit record.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 33b4458cdbef..41d29a06f28f 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -335,6 +335,9 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
 	audit_log_untrustedstring(ab, algo_hash);
 
 	audit_log_task_info(ab, current);
+	if (audit_containerid_set(current))
+		audit_log_format(ab, " contid=%llu",
+				 audit_get_containerid(current));
 	audit_log_end(ab);
 
 	iint->flags |= IMA_AUDITED;
-- 
2.7.5
