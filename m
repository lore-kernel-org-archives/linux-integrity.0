Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:51072 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389093AbeG1DuO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 27 Jul 2018 23:50:14 -0400
Date: Sat, 28 Jul 2018 10:24:42 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Eric Richter <erichte@linux.vnet.ibm.com>
Cc: kbuild-all@01.org,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Justin Forbes <jforbes@redhat.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH] ima: arch_policy_rules can be static
Message-ID: <20180728022442.GA100797@lkp-g5>
References: <20180725233200.761-2-erichte@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180725233200.761-2-erichte@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


Fixes: b4c0791e0fac ("ima: add support for arch specific policies")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 ima_policy.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index b47db4d..e1f2ffd 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -195,8 +195,8 @@ static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 };
 
 /* An array of architecture specific rules */
-struct ima_rule_entry **arch_policy_rules __ro_after_init;
-struct ima_rule_entry *arch_policy_entry __ro_after_init;
+static struct ima_rule_entry **arch_policy_rules __ro_after_init;
+static struct ima_rule_entry *arch_policy_entry __ro_after_init;
 
 static LIST_HEAD(ima_default_rules);
 static LIST_HEAD(ima_policy_rules);
