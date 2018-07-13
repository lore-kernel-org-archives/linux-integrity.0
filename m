Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387689AbeGMSWT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Jul 2018 14:22:19 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6DI4DDL086491
        for <linux-integrity@vger.kernel.org>; Fri, 13 Jul 2018 14:06:37 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2k6wc8scgb-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 13 Jul 2018 14:06:37 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 13 Jul 2018 19:06:35 +0100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v6 8/8] ima: based on policy warn about loading firmware (pre-allocated buffer)
Date: Fri, 13 Jul 2018 14:06:03 -0400
In-Reply-To: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1531505163-20227-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1531505163-20227-9-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Some systems are memory constrained but they need to load very large
firmwares.  The firmware subsystem allows drivers to request this
firmware be loaded from the filesystem, but this requires that the
entire firmware be loaded into kernel memory first before it's provided
to the driver.  This can lead to a situation where we map the firmware
twice, once to load the firmware into kernel memory and once to copy the
firmware into the final resting place.

To resolve this problem, commit a098ecd2fa7d ("firmware: support loading
into a pre-allocated buffer") introduced request_firmware_into_buf() API
that allows drivers to request firmware be loaded directly into a
pre-allocated buffer.

Do devices using pre-allocated memory run the risk of the firmware being
accessible to the device prior to the completion of IMA's signature
verification any more than when using two buffers? (Refer to mailing list
discussion[1]).

Only on systems with an IOMMU can the access be prevented.  As long as
the signature verification completes prior to the DMA map is performed,
the device can not access the buffer.  This implies that the same buffer
can not be re-used.  Can we ensure the buffer has not been DMA mapped
before using the pre-allocated buffer?

[1] https://lkml.org/lkml/2018/7/10/56

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

---
Changelog v6:
- Change warning to comment.

Changelog v5:
- Instead of preventing loading firmware from a pre-allocate buffer,
emit a warning.

 security/integrity/ima/ima_main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ef349a761609..b82500cd6fbd 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -429,6 +429,14 @@ void ima_post_path_mknod(struct dentry *dentry)
  */
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 {
+	/*
+	 * READING_FIRMWARE_PREALLOC_BUFFER
+	 *
+	 * Do devices using pre-allocated memory run the risk of the
+	 * firmware being accessible to the device prior to the completion
+	 * of IMA's signature verification any more than when using two
+	 * buffers?
+	 */
 	return 0;
 }
 
-- 
2.7.5
