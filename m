Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:45778 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbdLDTzD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Dec 2017 14:55:03 -0500
From: "Bruno E. O. Meneguele" <bmeneguele@gmail.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org,
        linux-ima-devel@lists.sourceforge.net,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ima: log message to module appraisal error
Date: Mon,  4 Dec 2017 17:54:56 -0200
Message-Id: <20171204195456.17193-1-bmeneguele@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Simple but useful message log to the user in case of module appraise is
forced and fails due to the lack of file descriptor, that might be
caused by kmod calls to compressed modules.

Signed-off-by: Bruno E. O. Meneguele <bmeneguele@gmail.com>
---
 security/integrity/ima/ima_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 770654694efc..95ec39910058 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -366,8 +366,12 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 
 	if (!file && read_id == READING_MODULE) {
 		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
-		    (ima_appraise & IMA_APPRAISE_ENFORCE))
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("impossible to appraise a module without a file \
+			       descriptor. sig_enforce kernel parameter might \
+			       help\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
 		return 0;	/* We rely on module signature checking */
 	}
 	return 0;
-- 
2.14.3
