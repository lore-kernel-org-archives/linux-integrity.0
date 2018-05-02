Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46556 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751148AbeEBXKq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 May 2018 19:10:46 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w42NAdDa097990
        for <linux-integrity@vger.kernel.org>; Wed, 2 May 2018 19:10:45 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2hqkdky3g2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 May 2018 19:10:41 -0400
Received: from localhost
        by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <mkayaalp@linux.vnet.ibm.com>;
        Wed, 2 May 2018 17:10:02 -0600
From: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
To: David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Keyrings <keyrings@vger.kernel.org>
Cc: Linux Integrity <linux-integrity@vger.kernel.org>,
        Linux Security <linux-security-module@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
Subject: [PATCH v6 4/4] KEYS: Print insert-sys-cert information to stdout instead of stderr
Date: Wed,  2 May 2018 19:08:11 -0400
In-Reply-To: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
References: <20180502230811.2751-1-mkayaalp@linux.vnet.ibm.com>
Message-Id: <20180502230811.2751-5-mkayaalp@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Detailed INFO output should go to stdout instead of stderr.

Signed-off-by: Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>
---
 scripts/insert-sys-cert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
index a3bd7ea8a436..caa446fe91b8 100644
--- a/scripts/insert-sys-cert.c
+++ b/scripts/insert-sys-cert.c
@@ -32,7 +32,7 @@
 #define USED_SYM  "system_extra_cert_used"
 #define LSIZE_SYM "system_certificate_list_size"
 
-#define info(format, args...) fprintf(stderr, "INFO:    " format, ## args)
+#define info(format, args...) fprintf(stdout, "INFO:    " format, ## args)
 #define warn(format, args...) fprintf(stdout, "WARNING: " format, ## args)
 #define  err(format, args...) fprintf(stderr, "ERROR:   " format, ## args)
 
-- 
2.17.0
