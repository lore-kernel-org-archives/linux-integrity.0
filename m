Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S967788AbeEXULN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 May 2018 16:11:13 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4OK4Dpt036005
        for <linux-integrity@vger.kernel.org>; Thu, 24 May 2018 16:11:13 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j61cnff16-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 24 May 2018 16:11:13 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <stefanb@linux.vnet.ibm.com>;
        Thu, 24 May 2018 16:11:12 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
To: zohar@linux.vnet.ibm.com, sgrubb@redhat.com
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-audit@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH 3/8] audit: Implement audit_log_tty()
Date: Thu, 24 May 2018 16:11:00 -0400
In-Reply-To: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
References: <20180524201105.3179904-1-stefanb@linux.vnet.ibm.com>
Message-Id: <20180524201105.3179904-4-stefanb@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Implement audit_log_tty() so that IMA can add tty= to its audit records.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/linux/audit.h | 5 +++++
 kernel/audit.c        | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 90aa63ddc9be..2deb76c74d10 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -154,6 +154,7 @@ extern void audit_log_task_info(struct audit_buffer *ab,
 				struct task_struct *tsk);
 
 extern int		    audit_update_lsm_rules(void);
+extern void audit_log_tty(struct audit_buffer *ab, struct task_struct *tsk);
 
 				/* Private API (for audit.c only) */
 extern int audit_rule_change(int type, int seq, void *data, size_t datasz);
@@ -202,6 +203,10 @@ static inline int audit_log_task_context(struct audit_buffer *ab)
 static inline void audit_log_task_info(struct audit_buffer *ab,
 				       struct task_struct *tsk)
 { }
+
+static inline void audit_log_tty(struct audit_buffer *ab,
+				 struct task_struct *tsk)
+{ }
 #define audit_enabled 0
 #endif /* CONFIG_AUDIT */
 
diff --git a/kernel/audit.c b/kernel/audit.c
index 670665c6e2a6..fa54695962b4 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2305,6 +2305,14 @@ void audit_log_task_info(struct audit_buffer *ab, struct task_struct *tsk)
 }
 EXPORT_SYMBOL(audit_log_task_info);
 
+void audit_log_tty(struct audit_buffer *ab, struct task_struct *tsk)
+{
+	struct tty_struct *tty = audit_get_tty(tsk);
+
+	audit_log_format(ab, " tty=%s", tty ? tty_name(tty) : "(none)");
+	audit_put_tty(tty);
+}
+
 /**
  * audit_log_link_denied - report a link restriction denial
  * @operation: specific link operation
-- 
2.13.6
