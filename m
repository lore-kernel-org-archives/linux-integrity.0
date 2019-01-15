Return-Path: <SRS0=v/7H=PX=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A0AC43387
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 02:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E6A20659
	for <linux-integrity@archiver.kernel.org>; Tue, 15 Jan 2019 02:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfAOCPR (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:15:17 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:34999 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726886AbfAOCPR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jan 2019 21:15:17 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TIFQkVE_1547518482;
Received: from localhost(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0TIFQkVE_1547518482)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 15 Jan 2019 10:14:42 +0800
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
To:     zohar@linux.ibm.com, pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zhang.jia@linux.alibaba.com
Subject: [PATCH 5/6] ima: Rename the folder name for policy files to datafiles
Date:   Tue, 15 Jan 2019 10:14:35 +0800
Message-Id: <1547518476-34008-6-git-send-email-zhang.jia@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
References: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If we choose to run ima_policy.sh locally without installation,
a failure message is reported as following:

ima_policy 1 TCONF: missing <path>/ltp/testcases/kernel/security/integrity/ima/datafiles/measure.policy

TST_DATAROOT would be extended to datafiles but the policy files
are actually placed under policy.

In order to make it easier, just rename the folder name to datafiles.

Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
---
 testcases/kernel/security/integrity/ima/Makefile   |  2 +-
 .../security/integrity/ima/datafiles/Makefile      | 31 ++++++++++++++++++++++
 .../integrity/ima/datafiles/measure.policy         | 16 +++++++++++
 .../integrity/ima/datafiles/measure.policy-invalid | 16 +++++++++++
 .../kernel/security/integrity/ima/policy/Makefile  | 31 ----------------------
 .../security/integrity/ima/policy/measure.policy   | 16 -----------
 .../integrity/ima/policy/measure.policy-invalid    | 16 -----------
 7 files changed, 64 insertions(+), 64 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/Makefile
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/measure.policy
 create mode 100644 testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid
 delete mode 100644 testcases/kernel/security/integrity/ima/policy/Makefile
 delete mode 100644 testcases/kernel/security/integrity/ima/policy/measure.policy
 delete mode 100644 testcases/kernel/security/integrity/ima/policy/measure.policy-invalid

diff --git a/testcases/kernel/security/integrity/ima/Makefile b/testcases/kernel/security/integrity/ima/Makefile
index 1290e6f..19b10ff 100644
--- a/testcases/kernel/security/integrity/ima/Makefile
+++ b/testcases/kernel/security/integrity/ima/Makefile
@@ -24,6 +24,6 @@ top_srcdir		?= ../../../../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
-SUBDIRS			:= policy src tests
+SUBDIRS			:= datafiles src tests
 
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/Makefile b/testcases/kernel/security/integrity/ima/datafiles/Makefile
new file mode 100644
index 0000000..a960f9d
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/Makefile
@@ -0,0 +1,31 @@
+#
+#    testcases/kernel/security/integrity/ima/policy testcases Makefile.
+#
+#    Copyright (C) 2009, Cisco Systems Inc.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+# Ngie Cooper, July 2009
+#
+
+top_srcdir		?= ../../../../../..
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+
+INSTALL_DIR		:= testcases/data/ima_policy
+
+INSTALL_TARGETS		:= measure*
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/integrity/ima/datafiles/measure.policy b/testcases/kernel/security/integrity/ima/datafiles/measure.policy
new file mode 100644
index 0000000..9976ddf
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/measure.policy
@@ -0,0 +1,16 @@
+#
+# Integrity measure policy
+#
+# PROC_SUPER_MAGIC
+dont_measure fsmagic=0x9fa0
+# SYSFS_MAGIC
+dont_measure fsmagic=0x62656572
+# DEBUGFS_MAGIC
+dont_measure fsmagic=0x64626720
+# TMPFS_MAGIC
+dont_measure fsmagic=0x01021994
+# SECURITYFS_MAGIC
+dont_measure fsmagic=0x73636673
+measure func=FILE_MMAP mask=MAY_EXEC
+measure func=BPRM_CHECK mask=MAY_EXEC
+measure func=FILE_CHECK mask=MAY_READ uid=0
diff --git a/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid b/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid
new file mode 100644
index 0000000..04dff89
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid
@@ -0,0 +1,16 @@
+#
+# Integrity measure policy
+#
+# PROC_SUPER_MAGIC
+dont_measure fsmagic=0x9fa0
+# SYSFS_MAGIC
+dont_measure fsmagic=0x62656572
+# DEBUGFS_MAGIC
+dont_measure fsmagic=0x64626720
+# TMPFS_MAGIC
+dont_measure fsmagic=0x01021994
+# SECURITYFS_MAGIC
+dnt_measure fsmagic=0x73636673
+measure func=FILE_MMAP mask=MAY_EXEC
+measure func=BPRM_CHECK mask=MAY_EXEC
+measure func=FILE_CHECK mask=MAY_READ uid=0
diff --git a/testcases/kernel/security/integrity/ima/policy/Makefile b/testcases/kernel/security/integrity/ima/policy/Makefile
deleted file mode 100644
index a960f9d..0000000
--- a/testcases/kernel/security/integrity/ima/policy/Makefile
+++ /dev/null
@@ -1,31 +0,0 @@
-#
-#    testcases/kernel/security/integrity/ima/policy testcases Makefile.
-#
-#    Copyright (C) 2009, Cisco Systems Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Ngie Cooper, July 2009
-#
-
-top_srcdir		?= ../../../../../..
-
-include	$(top_srcdir)/include/mk/env_pre.mk
-
-INSTALL_DIR		:= testcases/data/ima_policy
-
-INSTALL_TARGETS		:= measure*
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/security/integrity/ima/policy/measure.policy b/testcases/kernel/security/integrity/ima/policy/measure.policy
deleted file mode 100644
index 9976ddf..0000000
--- a/testcases/kernel/security/integrity/ima/policy/measure.policy
+++ /dev/null
@@ -1,16 +0,0 @@
-#
-# Integrity measure policy
-#
-# PROC_SUPER_MAGIC
-dont_measure fsmagic=0x9fa0
-# SYSFS_MAGIC
-dont_measure fsmagic=0x62656572
-# DEBUGFS_MAGIC
-dont_measure fsmagic=0x64626720
-# TMPFS_MAGIC
-dont_measure fsmagic=0x01021994
-# SECURITYFS_MAGIC
-dont_measure fsmagic=0x73636673
-measure func=FILE_MMAP mask=MAY_EXEC
-measure func=BPRM_CHECK mask=MAY_EXEC
-measure func=FILE_CHECK mask=MAY_READ uid=0
diff --git a/testcases/kernel/security/integrity/ima/policy/measure.policy-invalid b/testcases/kernel/security/integrity/ima/policy/measure.policy-invalid
deleted file mode 100644
index 04dff89..0000000
--- a/testcases/kernel/security/integrity/ima/policy/measure.policy-invalid
+++ /dev/null
@@ -1,16 +0,0 @@
-#
-# Integrity measure policy
-#
-# PROC_SUPER_MAGIC
-dont_measure fsmagic=0x9fa0
-# SYSFS_MAGIC
-dont_measure fsmagic=0x62656572
-# DEBUGFS_MAGIC
-dont_measure fsmagic=0x64626720
-# TMPFS_MAGIC
-dont_measure fsmagic=0x01021994
-# SECURITYFS_MAGIC
-dnt_measure fsmagic=0x73636673
-measure func=FILE_MMAP mask=MAY_EXEC
-measure func=BPRM_CHECK mask=MAY_EXEC
-measure func=FILE_CHECK mask=MAY_READ uid=0
-- 
1.8.3.1

