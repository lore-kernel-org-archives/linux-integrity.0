Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755117AbeEANss (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 May 2018 09:48:48 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w41Dlr4v047277
        for <linux-integrity@vger.kernel.org>; Tue, 1 May 2018 09:48:48 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hpsdyg23w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 01 May 2018 09:48:47 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 1 May 2018 14:48:45 +0100
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Peter Jones <pjones@redhat.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        "Luis R . Rodriguez" <mcgrof@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/6] firmware: differentiate between signed regulatory.db and other firmware
Date: Tue,  1 May 2018 09:48:20 -0400
In-Reply-To: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1525182503-13849-1-git-send-email-zohar@linux.vnet.ibm.com>
Message-Id: <1525182503-13849-4-git-send-email-zohar@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Allow LSMs and IMA to differentiate between signed regulatory.db and
other firmware.

Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Luis R. Rodriguez <mcgrof@suse.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Seth Forshee <seth.forshee@canonical.com>
Cc: Johannes Berg <johannes.berg@intel.com>
---
 drivers/base/firmware_loader/main.c | 5 +++++
 include/linux/fs.h                  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
index eb34089e4299..d7cdf04a8681 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -318,6 +318,11 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv)
 			break;
 		}
 
+#ifdef CONFIG_CFG80211_REQUIRE_SIGNED_REGDB
+		if ((strcmp(fw_priv->fw_name, "regulatory.db") == 0) ||
+		    (strcmp(fw_priv->fw_name, "regulatory.db.p7s") == 0))
+			id = READING_FIRMWARE_REGULATORY_DB;
+#endif
 		fw_priv->size = 0;
 		rc = kernel_read_file_from_path(path, &fw_priv->data, &size,
 						msize, id);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index dc16a73c3d38..d1153c2884b9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2811,6 +2811,7 @@ extern int do_pipe_flags(int *, int);
 	id(FIRMWARE, firmware)		\
 	id(FIRMWARE_PREALLOC_BUFFER, firmware)	\
 	id(FIRMWARE_FALLBACK, firmware)	\
+	id(FIRMWARE_REGULATORY_DB, firmware)	\
 	id(MODULE, kernel-module)		\
 	id(KEXEC_IMAGE, kexec-image)		\
 	id(KEXEC_INITRAMFS, kexec-initramfs)	\
-- 
2.7.5
