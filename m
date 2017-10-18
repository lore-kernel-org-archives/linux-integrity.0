Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from szxga05-in.huawei.com ([45.249.212.191]:8526 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756892AbdJRDg7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 23:36:59 -0400
From: Boshi Wang <wangboshi@huawei.com>
To: <linux-integrity@vger.kernel.org>
CC: <zohar@linux.vnet.ibm.com>
Subject: [PATCH] ima: fix ineffective default hash algorithm due to invalid hash algorithm boot argument
Date: Wed, 18 Oct 2017 11:38:01 +0800
Message-ID: <20171018033801.220383-1-wangboshi@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

The hash_setup function always sets hash_setup_done variable. If an
invalid hash algorithm is passed, the default hash algorithm specified
by CONFIG_IMA_DEFAULT_HASH could not be used.

Signed-off-by: Boshi Wang <wangboshi@huawei.com>
---
 security/integrity/ima/ima_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2aebb79..ab70a39 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -51,6 +51,8 @@ static int __init hash_setup(char *str)
 			ima_hash_algo = HASH_ALGO_SHA1;
 		else if (strncmp(str, "md5", 3) == 0)
 			ima_hash_algo = HASH_ALGO_MD5;
+		else
+			return 1;
 		goto out;
 	}
 
@@ -60,6 +62,8 @@ static int __init hash_setup(char *str)
 			break;
 		}
 	}
+	if (i == HASH_ALGO__LAST)
+		return 1;
 out:
 	hash_setup_done = 1;
 	return 1;
-- 
2.10.1
