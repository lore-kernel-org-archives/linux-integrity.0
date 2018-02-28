Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58836 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934318AbeB1R5A (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Feb 2018 12:57:00 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w1SHsh6m087436
        for <linux-integrity@vger.kernel.org>; Wed, 28 Feb 2018 12:56:59 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gdysdmbfw-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 28 Feb 2018 12:56:59 -0500
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <nayna@linux.vnet.ibm.com>;
        Wed, 28 Feb 2018 17:56:57 -0000
From: Nayna Jain <nayna@linux.vnet.ibm.com>
To: dhowells@redhat.com
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Nayna Jain <nayna@linux.vnet.ibm.com>
Subject: [PATCH 2/3] keys: export find_keyring_by_name()
Date: Wed, 28 Feb 2018 23:25:20 +0530
In-Reply-To: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
References: <20180228175521.10287-1-nayna@linux.vnet.ibm.com>
Message-Id: <20180228175521.10287-2-nayna@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

This patch exports the function find_keyring_by_name()
to be used by other subsystems.

Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
---
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
index d0bccebbd3b5..0fd230534685 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1159,6 +1159,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 	read_unlock(&keyring_name_lock);
 	return keyring;
 }
+EXPORT_SYMBOL(find_keyring_by_name);
 
 static int keyring_detect_cycle_iterator(const void *object,
 					 void *iterator_data)
-- 
2.13.6
