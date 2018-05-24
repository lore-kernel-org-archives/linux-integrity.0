Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S968817AbeEXULR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 May 2018 16:11:17 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4OK4Fgi145157
        for <linux-integrity@vger.kernel.org>; Thu, 24 May 2018 16:11:17 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j61p9xbkt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 24 May 2018 16:11:16 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Thu, 24 May 2018 16:11:15 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, sgrubb@redhat.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 4/8] audit: Allow others to call audit_log_d_path_exe()
Date: Thu, 24 May 2018 16:11:01 -0400
In-Reply-To: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20180524201105.3179904-5-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Add the prototype for audit_log_d_path_exe() so that it can be
called by IMA later in this series.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 include/linux/audit.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 2deb76c74d10..65eca0795308 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -144,6 +144,8 @@ extern void		    audit_log_untrustedstring(struct audit_buffer *ab,
 extern void		    audit_log_d_path(struct audit_buffer *ab,
 					     const char *prefix,
 					     const struct path *path);
+extern void		    audit_log_d_path_exe(struct audit_buffer *ab,
+						 struct mm_struct *mm);
 extern void		    audit_log_key(struct audit_buffer *ab,
 					  char *key);
 extern void		    audit_log_link_denied(const char *operation);
@@ -192,6 +194,9 @@ static inline void audit_log_d_path(struct audit_buffer *ab,
 				    const char *prefix,
 				    const struct path *path)
 { }
+static inline void audit_log_d_path_exe(struct audit_buffer *ab,
+					struct mm_struct *mm)
+{}
 static inline void audit_log_key(struct audit_buffer *ab, char *key)
 { }
 static inline void audit_log_link_denied(const char *string)
-- 
2.13.6
