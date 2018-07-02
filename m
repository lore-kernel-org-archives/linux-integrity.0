Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752620AbeGBOjC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Jul 2018 10:39:02 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w62EcZdJ116754
        for <linux-integrity@vger.kernel.org>; Mon, 2 Jul 2018 10:39:02 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jymmgusda-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 02 Jul 2018 10:39:01 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 2 Jul 2018 15:38:59 +0100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v5 4/8] firmware: add call to LSM hook before firmware sysfs fallback
Date: Mon,  2 Jul 2018 10:37:59 -0400
In-Reply-To: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1530542283-26145-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1530542283-26145-5-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Add an LSM hook prior to allowing firmware sysfs fallback loading.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

---
Changelog v4:
- call new LSM security_kernel_load_data hook

Changelog v2:
- call security_kernel_read_blob()
- rename the READING_FIRMWARE_FALLBACK kernel_read_file_id enumeration to
READING_FIRMWARE_FALLBACK_SYSFS.

 drivers/base/firmware_loader/fallback.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
index 7f732744f0d3..202324291542 100644
--- a/drivers/base/firmware_loader/fallback.c
+++ b/drivers/base/firmware_loader/fallback.c
@@ -651,6 +651,8 @@ static bool fw_force_sysfs_fallback(enum fw_opt opt_flags)
 
 static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
 {
+	int ret;
+
 	if (fw_fallback_config.ignore_sysfs_fallback) {
 		pr_info_once("Ignoring firmware sysfs fallback due to sysctl knob\n");
 		return false;
@@ -659,6 +661,11 @@ static bool fw_run_sysfs_fallback(enum fw_opt opt_flags)
 	if ((opt_flags & FW_OPT_NOFALLBACK))
 		return false;
 
+	/* Also permit LSMs and IMA to fail firmware sysfs fallback */
+	ret = security_kernel_load_data(LOADING_FIRMWARE);
+	if (ret < 0)
+		return ret;
+
 	return fw_force_sysfs_fallback(opt_flags);
 }
 
-- 
2.7.5
