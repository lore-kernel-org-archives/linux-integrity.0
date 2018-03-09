Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57700 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932221AbeCIPjb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Mar 2018 10:39:31 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w29FVW9K099411
        for <linux-integrity@vger.kernel.org>; Fri, 9 Mar 2018 10:39:30 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gksg6hjyv-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 09 Mar 2018 10:39:30 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Fri, 9 Mar 2018 15:39:28 -0000
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: dhowells@redhat.com
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH v2 2/3] keys: export find_keyring_by_name()
Date: Fri,  9 Mar 2018 21:08:02 +0530
In-Reply-To: <20180309153803.25859-1-nayna@linux.vnet.ibm.com>
References: <20180309153803.25859-1-nayna@linux.vnet.ibm.com>
Message-Id: <20180309153803.25859-2-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This patch exports the function find_keyring_by_name() to be used by
other subsystems.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
Changelog:

v2:
* Fix the patch description per line length as suggested by Mimi

 include/linux/key.h      | 2 ++
 security/keys/internal.h | 2 --
 security/keys/keyring.c  | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index e58ee10f6e58..c8d332d4103c 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -346,6 +346,8 @@ static inline key_serial_t key_serial(const struct key *key)
 
 extern void key_set_timeout(struct key *, unsigned);
 
+extern struct key *find_keyring_by_name(const char *name, bool uid_keyring);
+
 /*
  * The permissions required on a key that we're looking up.
  */
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 9f8208dc0e55..8aa8d347a1ab 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -141,8 +141,6 @@ extern key_ref_t keyring_search_aux(key_ref_t keyring_ref,
 extern key_ref_t search_my_process_keyrings(struct keyring_search_context *ctx);
 extern key_ref_t search_process_keyrings(struct keyring_search_context *ctx);
 
-extern struct key *find_keyring_by_name(const char *name, bool uid_keyring);
-
 extern int install_user_keyrings(void);
 extern int install_thread_keyring_to_cred(struct cred *);
 extern int install_process_keyring_to_cred(struct cred *);
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 41bcf57e96f2..4b9c3f1166d1 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1152,6 +1152,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 	read_unlock(&keyring_name_lock);
 	return keyring;
 }
+EXPORT_SYMBOL(find_keyring_by_name);
 
 static int keyring_detect_cycle_iterator(const void *object,
 					 void *iterator_data)
-- 
2.13.6
