Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752654AbeAQS1W (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jan 2018 13:27:22 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0HIOvmc042439
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jan 2018 13:27:22 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fjbrar3f9-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jan 2018 13:27:21 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <rppt@linux.vnet.ibm.com>;
        Wed, 17 Jan 2018 18:27:19 -0000
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH] ima/policy: fix parsing of fsuuid
Date: Wed, 17 Jan 2018 20:27:11 +0200
Message-Id: <1516213631-8974-1-git-send-email-rppt@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The switch to uuid_t invereted the logic of verfication that &entry->fsuuid
is zero during parsing of "fsuuid=" rule. Instead of making sure the
&entry->fsuuid field is not attempted to be overwriten, we bail out for
perfectly correct rule.

Fixes: 787d8c530af7 ("ima/policy: switch to use uuid_t")

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 security/integrity/ima/ima_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index ee4613fa5840..f19f4841a97a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -743,7 +743,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 		case Opt_fsuuid:
 			ima_log_string(ab, "fsuuid", args[0].from);
 
-			if (uuid_is_null(&entry->fsuuid)) {
+			if (!uuid_is_null(&entry->fsuuid)) {
 				result = -EINVAL;
 				break;
 			}
-- 
2.7.4
