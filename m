Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbeJDGwc (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Oct 2018 02:52:32 -0400
From: Eric Biggers <ebiggers@kernel.org>
To: linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH v2] ima: fix showing large 'violations' or 'runtime_measurements_count'
Date: Wed,  3 Oct 2018 17:01:06 -0700
Message-Id: <20181004000106.153693-1-ebiggers@kernel.org>
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

The 12 character temporary buffer is not necessarily long enough to hold
a 'long' value.  Increase it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/integrity/ima/ima_fs.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index ae9d5c766a3ce..4b50fe9c18edd 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -42,14 +42,15 @@ static int __init default_canonical_fmt_setup(char *str)
 __setup("ima_canonical_fmt", default_canonical_fmt_setup);
 
 static int valid_policy = 1;
-#define TMPBUFLEN 12
+
 static ssize_t ima_show_htable_value(char __user *buf, size_t count,
 				     loff_t *ppos, atomic_long_t *val)
 {
-	char tmpbuf[TMPBUFLEN];
+	/* temporary buffer that is plenty long enough */
+	char tmpbuf[32];
 	ssize_t len;
 
-	len = scnprintf(tmpbuf, TMPBUFLEN, "%li\n", atomic_long_read(val));
+	len = scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", atomic_long_read(val));
 	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
 }
 
-- 
2.19.0.605.g01d371f741-goog
