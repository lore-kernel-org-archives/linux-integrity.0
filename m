Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:47260 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754413AbeCVOny (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 22 Mar 2018 10:43:54 -0400
From: Petr Vorel <pvorel@suse.cz>
To: linux-integrity@vger.kernel.org
Cc: Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Subject: [PATCH v2 2/2] ima: Fallback to the builtin hash algorithm
Date: Thu, 22 Mar 2018 15:43:13 +0100
Message-Id: <20180322144313.28748-3-pvorel@suse.cz>
In-Reply-To: <20180322144313.28748-1-pvorel@suse.cz>
References: <20180322144313.28748-1-pvorel@suse.cz>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

IMA requires have it's hash algorithm to be compiled-in due it's early
use. Default IMA algorithm is protected by Kconfig to be compiled-in.

ima_hash kernel parameter allows to choose hash algorithm. When
specified algorithm not available or available as module, IMA
initialization fails, which leads to kernel panic (mknodat syscall calls
ima_post_path_mknod()). Therefore as fallback we force IMA to use
the default builtin Kconfig hash algorithm.

Fixed crash:

$ grep CONFIG_CRYPTO_MD4 .config
CONFIG_CRYPTO_MD4=m

[    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-4.12.14-2.3-default root=UUID=74ae8202-9ca7-4e39-813b-22287ec52f7a video=1024x768-16 plymouth.ignore-serial-consoles console=ttyS0 console=tty resume=/dev/disk/by-path/pci-0000:00:07.0-part3 splash=silent showopts ima_hash=md4
...
[    1.545190] ima: Can not allocate md4 (reason: -2)
...
[    2.610120] BUG: unable to handle kernel NULL pointer dereference at           (null)
[    2.611903] IP: ima_match_policy+0x23/0x390
[    2.612967] PGD 0 P4D 0
[    2.613080] Oops: 0000 [#1] SMP
[    2.613080] Modules linked in: autofs4
[    2.613080] Supported: Yes
[    2.613080] CPU: 0 PID: 1 Comm: systemd Not tainted 4.12.14-2.3-default #1
[    2.613080] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.0.0-prebuilt.qemu-project.org 04/01/2014
[    2.613080] task: ffff88003e2d0040 task.stack: ffffc90000190000
[    2.613080] RIP: 0010:ima_match_policy+0x23/0x390
[    2.613080] RSP: 0018:ffffc90000193e88 EFLAGS: 00010296
[    2.613080] RAX: 0000000000000000 RBX: 000000000000000c RCX: 0000000000000004
[    2.613080] RDX: 0000000000000010 RSI: 0000000000000001 RDI: ffff880037071728
[    2.613080] RBP: 0000000000008000 R08: 0000000000000000 R09: 0000000000000000
[    2.613080] R10: 0000000000000008 R11: 61c8864680b583eb R12: 00005580ff10086f
[    2.613080] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000008000
[    2.613080] FS:  00007f5c1da08940(0000) GS:ffff88003fc00000(0000) knlGS:0000000000000000
[    2.613080] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.613080] CR2: 0000000000000000 CR3: 0000000037002000 CR4: 00000000003406f0
[    2.613080] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    2.613080] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    2.613080] Call Trace:
[    2.613080]  ? shmem_mknod+0xbf/0xd0
[    2.613080]  ima_post_path_mknod+0x1c/0x40
[    2.613080]  SyS_mknod+0x210/0x220
[    2.613080]  entry_SYSCALL_64_fastpath+0x1a/0xa5
[    2.613080] RIP: 0033:0x7f5c1bfde570
[    2.613080] RSP: 002b:00007ffde1c90dc8 EFLAGS: 00000246 ORIG_RAX: 0000000000000085
[    2.613080] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f5c1bfde570
[    2.613080] RDX: 0000000000000000 RSI: 0000000000008000 RDI: 00005580ff10086f
[    2.613080] RBP: 00007ffde1c91040 R08: 00005580ff10086f R09: 0000000000000000
[    2.613080] R10: 0000000000104000 R11: 0000000000000246 R12: 00005580ffb99660
[    2.613080] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000002
[    2.613080] Code: 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41 57 41 56 44 8d 14 09 41 55 41 54 55 53 44 89 d3 09 cb 48 83 ec 38 48 8b 05 c5 03 29 01 <4c> 8b 20 4c 39 e0 0f 84 d7 01 00 00 4c 89 44 24 08 89 54 24 20
[    2.613080] RIP: ima_match_policy+0x23/0x390 RSP: ffffc90000193e88
[    2.613080] CR2: 0000000000000000
[    2.613080] ---[ end trace 9a9f0a8a73079f6a ]---
[    2.673052] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
[    2.673052]
[    2.675337] Kernel Offset: disabled
[    2.676405] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 security/integrity/ima/ima.h        |  1 +
 security/integrity/ima/ima_crypto.c | 33 ++++++++++++++++++++++++++++++++-
 security/integrity/ima/ima_main.c   | 26 +++-----------------------
 3 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 35fe91aa1fc9..ee12eb855763 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -154,6 +154,7 @@ int ima_measurements_show(struct seq_file *m, void *v);
 unsigned long ima_get_binary_runtime_size(void);
 int ima_init_template(void);
 void ima_init_template_list(void);
+int __init ima_get_hash_algo_key(char *const str);
 
 /*
  * used to protect h_table and sha_table
diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima/ima_crypto.c
index ddc18f4633e5..74aa48323617 100644
--- a/security/integrity/ima/ima_crypto.c
+++ b/security/integrity/ima/ima_crypto.c
@@ -77,7 +77,16 @@ static int ima_alloc_shash(struct crypto_shash **tfm, const char *alg_name)
 
 int __init ima_init_crypto(void)
 {
-	return ima_alloc_shash(&ima_shash_tfm, hash_algo_name[ima_hash_algo]);
+	long rc;
+
+	rc = ima_alloc_shash(&ima_shash_tfm, hash_algo_name[ima_hash_algo]);
+	if (rc && strcmp(hash_algo_name[ima_hash_algo],
+					 CONFIG_IMA_DEFAULT_HASH) != 0) {
+		ima_hash_algo = ima_get_hash_algo_key(CONFIG_IMA_DEFAULT_HASH);
+		pr_err("Fallback to %s\n", CONFIG_IMA_DEFAULT_HASH);
+		rc = ima_alloc_shash(&ima_shash_tfm, CONFIG_IMA_DEFAULT_HASH);
+	}
+	return rc;
 }
 
 static struct crypto_shash *ima_alloc_tfm(enum hash_algo algo)
@@ -677,3 +686,25 @@ int __init ima_calc_boot_aggregate(struct ima_digest_data *hash)
 
 	return rc;
 }
+
+int __init ima_get_hash_algo_key(char *const str)
+{
+	struct ima_template_desc *template_desc = ima_template_desc_current();
+	int i;
+
+	if (strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) == 0) {
+		if (strncmp(str, "sha1", 4) == 0)
+			return HASH_ALGO_SHA1;
+		else if (strncmp(str, "md5", 3) == 0)
+			return HASH_ALGO_MD5;
+		else
+			return -1;
+	}
+
+	for (i = 0; i < HASH_ALGO__LAST; i++) {
+		if (strcmp(str, hash_algo_name[i]) == 0) {
+			return i;
+		}
+	}
+	return -1;
+}
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5d122daf5c8a..c1ec8f4b8544 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -42,32 +42,12 @@ static int hash_setup_done;
 
 static int __init hash_setup(char *str)
 {
-	struct ima_template_desc *template_desc = ima_template_desc_current();
-	int i;
-
 	if (hash_setup_done)
 		return 1;
 
-	if (strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) == 0) {
-		if (strncmp(str, "sha1", 4) == 0)
-			ima_hash_algo = HASH_ALGO_SHA1;
-		else if (strncmp(str, "md5", 3) == 0)
-			ima_hash_algo = HASH_ALGO_MD5;
-		else
-			return 1;
-		goto out;
-	}
-
-	for (i = 0; i < HASH_ALGO__LAST; i++) {
-		if (strcmp(str, hash_algo_name[i]) == 0) {
-			ima_hash_algo = i;
-			break;
-		}
-	}
-	if (i == HASH_ALGO__LAST)
-		return 1;
-out:
-	hash_setup_done = 1;
+	ima_hash_algo = ima_get_hash_algo_key(str);
+	if (ima_hash_algo != -1)
+		hash_setup_done = 1;
 	return 1;
 }
 __setup("ima_hash=", hash_setup);
-- 
2.12.3
