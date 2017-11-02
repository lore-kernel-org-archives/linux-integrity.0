Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752304AbdKBRL7 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Nov 2017 13:11:59 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1509382827.3583.143.camel@linux.vnet.ibm.com>
References: <1509382827.3583.143.camel@linux.vnet.ibm.com> <1508774387.3639.128.camel@linux.vnet.ibm.com> <750.1509378910@warthog.procyon.org.uk>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: dhowells@redhat.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH] ima: require secure_boot rules in lockdown mode
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 02 Nov 2017 17:11:57 +0000
Message-ID: <22475.1509642717@warthog.procyon.org.uk>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

I've made the revisions suggested.  See the attached patch.

David
---
commit 721c0994b824b91acd3c412abe55ae41287fc64d
Author: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Mon Oct 23 11:59:47 2017 -0400

    ima: require secure_boot rules in lockdown mode
    
    Require the "secure_boot" rules, whether or not it is specified
    on the boot command line, for both the builtin and custom policies
    in secure boot lockdown mode.
    
    Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 95209a5f8595..f64f2be2dc0c 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -427,14 +427,21 @@ void ima_update_policy_flag(void)
  */
 void __init ima_init_policy(void)
 {
-	int i, measure_entries, appraise_entries, secure_boot_entries;
+	int i;
+	int measure_entries = 0;
+	int appraise_entries = 0;
+	int secure_boot_entries = 0;
+	bool kernel_locked_down = kernel_is_locked_down();
 
 	/* if !ima_policy set entries = 0 so we load NO default rules */
-	measure_entries = ima_policy ? ARRAY_SIZE(dont_measure_rules) : 0;
-	appraise_entries = ima_use_appraise_tcb ?
-			 ARRAY_SIZE(default_appraise_rules) : 0;
-	secure_boot_entries = ima_use_secure_boot ?
-			ARRAY_SIZE(secure_boot_rules) : 0;
+	if (ima_policy)
+		measure_entries = ARRAY_SIZE(dont_measure_rules);
+
+	if (ima_use_appraise_tcb)
+		appraise_entries = ARRAY_SIZE(default_appraise_rules);
+
+	if (ima_use_secure_boot || kernel_locked_down)
+		secure_boot_entries = ARRAY_SIZE(secure_boot_rules);
 
 	for (i = 0; i < measure_entries; i++)
 		list_add_tail(&dont_measure_rules[i].list, &ima_default_rules);
@@ -455,11 +462,23 @@ void __init ima_init_policy(void)
 
 	/*
 	 * Insert the appraise rules requiring file signatures, prior to
-	 * any other appraise rules.
+	 * any other appraise rules.  In secure boot lock-down mode, also
+	 * require these appraise rules for custom policies.
 	 */
-	for (i = 0; i < secure_boot_entries; i++)
-		list_add_tail(&secure_boot_rules[i].list,
-			      &ima_default_rules);
+	for (i = 0; i < secure_boot_entries; i++) {
+		struct ima_rule_entry *entry;
+
+		/* Include for builtin policies */
+		list_add_tail(&secure_boot_rules[i].list, &ima_default_rules);
+
+		/* Include for custom policies */
+		if (kernel_locked_down) {
+			entry = kmemdup(&secure_boot_rules[i], sizeof(*entry),
+					GFP_KERNEL);
+			if (entry)
+				list_add_tail(&entry->list, &ima_policy_rules);
+		}
+	}
 
 	for (i = 0; i < appraise_entries; i++) {
 		list_add_tail(&default_appraise_rules[i].list,
