Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33046 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S968787AbeEXULR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 May 2018 16:11:17 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4OK4D4v114163
        for <linux-integrity@vger.kernel.org>; Thu, 24 May 2018 16:11:16 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j641q8ety-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 24 May 2018 16:11:16 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Thu, 24 May 2018 16:11:14 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, sgrubb@redhat.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 5/8] integrity: Add exe= and tty= before res= to integrity audits
Date: Thu, 24 May 2018 16:11:02 -0400
In-Reply-To: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20180524201105.3179904-6-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Use the new public audit functions to add the exe= and tty=
parts to the integrity audit records. We place them before
res=.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Suggested-by: Steve Grubb <sgrubb@redhat.com>
---
 security/integrity/integrity_audit.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/integrity/integrity_audit.c b/security/integrity/integrity_audit.c
index db30763d5525..8d25d3c4dcca 100644
--- a/security/integrity/integrity_audit.c
+++ b/security/integrity/integrity_audit.c
@@ -56,6 +56,8 @@ void integrity_audit_msg(int audit_msgno, struct inode *inode,
 		audit_log_untrustedstring(ab, inode->i_sb->s_id);
 		audit_log_format(ab, " ino=%lu", inode->i_ino);
 	}
+	audit_log_d_path_exe(ab, current->mm);
+	audit_log_tty(ab, current);
 	audit_log_format(ab, " res=%d", !result);
 	audit_log_end(ab);
 }
-- 
2.13.6
