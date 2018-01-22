Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44948 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750945AbeAVOyZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jan 2018 09:54:25 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0MEo8kq110424
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:24 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fne9eakw7-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:24 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 22 Jan 2018 14:54:22 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Bruno E . O . Meneguele" <brdeoliv@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 02/10] ima-evm-utils: revert the change to use printf instead of log_info()
Date: Mon, 22 Jan 2018 09:53:57 -0500
In-Reply-To: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1516632845-7087-3-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Using log_info() was commented out and replaced with printf.  Revert
this change and use log_info().

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 src/libimaevm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index eedffb4..610b0b7 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -402,8 +402,7 @@ int verify_hash_v1(const unsigned char *hash, int size, unsigned char *sig, int
 		log_err("Verification failed: %d\n", err);
 		return -1;
 	} else {
-		/*log_info("Verification is OK\n");*/
-		printf("Verification is OK\n");
+		log_info("Verification is OK\n");
 	}
 
 	return 0;
@@ -447,8 +446,7 @@ int verify_hash_v2(const unsigned char *hash, int size, unsigned char *sig, int
 		return -1;
 	}
 
-	/*log_info("Verification is OK\n");*/
-	printf("Verification is OK\n");
+	log_info("Verification is OK\n");
 
 	return 0;
 }
-- 
2.7.4
