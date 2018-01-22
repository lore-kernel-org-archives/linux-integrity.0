Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750945AbeAVOy1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jan 2018 09:54:27 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0MEnnLO083146
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:26 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fng93wjru-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 22 Jan 2018 09:54:26 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 22 Jan 2018 14:54:24 -0000
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Bruno E . O . Meneguele" <brdeoliv@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: [PATCH 04/10] ima-evm-utils: remove the unnecessary display of the keyid
Date: Mon, 22 Jan 2018 09:53:59 -0500
In-Reply-To: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1516632845-7087-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1516632845-7087-5-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Callers of calc_keyid_v2() can display the keyid, when desired.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
---
 src/libimaevm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 610b0b7..a92deed 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -606,8 +606,6 @@ void calc_keyid_v2(uint32_t *keyid, char *str, RSA *key)
 	log_debug_dump(keyid, 4);
 
 	sprintf(str, "%x", __be32_to_cpup(keyid));
-	log_info("keyid: %s\n", str);
-
 	free(pkey);
 }
 
-- 
2.7.4
