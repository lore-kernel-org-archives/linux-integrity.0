Return-Path: <SRS0=1gI3=RU=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E856BC43381
	for <linux-integrity@archiver.kernel.org>; Sun, 17 Mar 2019 11:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A213621871
	for <linux-integrity@archiver.kernel.org>; Sun, 17 Mar 2019 11:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfCQLjw (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 17 Mar 2019 07:39:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46428 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726223AbfCQLjw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 17 Mar 2019 07:39:52 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2HBdmU2129212
        for <linux-integrity@vger.kernel.org>; Sun, 17 Mar 2019 07:39:50 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r9ee7u9e8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 17 Mar 2019 07:39:49 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 17 Mar 2019 11:39:38 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 17 Mar 2019 11:39:34 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2HBdYdp49873104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Mar 2019 11:39:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3C495204F;
        Sun, 17 Mar 2019 11:39:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.241])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E73325204E;
        Sun, 17 Mar 2019 11:39:32 +0000 (GMT)
Subject: Re: [RFC] kexec: Allow kexec_file() with appropriate IMA policy
 when locked down
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, dmitry.kasatkin@gmail.com,
        Matthew Garrett <mjg59@google.com>,
        kexec <kexec@lists.infradead.org>,
        Dave Young <dyoung@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Sun, 17 Mar 2019 07:39:21 -0400
In-Reply-To: <20190315220336.220554-1-matthewgarrett@google.com>
References: <1552607929.8658.54.camel@linux.ibm.com>
         <20190315220336.220554-1-matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031711-4275-0000-0000-0000031BF7E5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031711-4276-0000-0000-0000382A70C0
Message-Id: <1552822761.8658.158.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-17_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903170093
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-03-15 at 15:03 -0700, Matthew Garrett wrote:
> Systems in lockdown mode should block the kexec of untrusted kernels.
> For x86 and ARM we can ensure that a kernel is trustworthy by validating
> a PE signature, but this isn't possible on other architectures. On those
> platforms we can use IMA digital signatures instead. Add a function to
> determine whether IMA will verify signatures for a given event type,

In both the kexec and kernel modules cases, this should be in the past
tense.  Perhaps change it to something like, "whether IMA has already
or will verify signatures ...".

>  and
> if so permit kexec_file() even if the kernel is otherwise locked down.
> This is restricted to cases where CONFIG_INTEGRITY_TRUSTED_KEYRING is set
> in order to prevent an attacker from loading additional keys at runtime.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  include/linux/evm.h                 |  6 ++++
>  include/linux/ima.h                 | 28 +++++++++++++++++++
>  kernel/kexec_file.c                 |  9 ++++--
>  security/integrity/evm/evm_main.c   |  2 +-
>  security/integrity/ima/ima.h        | 20 +-------------
>  security/integrity/ima/ima_policy.c | 43 +++++++++++++++++++++++++++++
>  6 files changed, 86 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/evm.h b/include/linux/evm.h
> index 8302bc29bb35..6e89d046b716 100644
> --- a/include/linux/evm.h
> +++ b/include/linux/evm.h
> @@ -15,6 +15,7 @@
>  struct integrity_iint_cache;
>  
>  #ifdef CONFIG_EVM
> +extern bool evm_key_loaded(void);
>  extern int evm_set_key(void *key, size_t keylen);
>  extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
>  					     const char *xattr_name,
> @@ -45,6 +46,11 @@ static inline int posix_xattr_acl(const char *xattrname)
>  #endif
>  #else
>  
> +static inline bool evm_key_loaded(void)
> +{
> +	return false;
> +}
> +

Remove remaining EVM fragment.

>  static inline int evm_set_key(void *key, size_t keylen)
>  {
>  	return -EOPNOTSUPP;
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index dc12fbcf484c..a42e2a9a08b7 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -27,6 +27,25 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  			      enum kernel_read_file_id id);
>  extern void ima_post_path_mknod(struct dentry *dentry);
>  
> +#define __ima_hooks(hook)		\
> +	hook(NONE)			\
> +	hook(FILE_CHECK)		\
> +	hook(MMAP_CHECK)		\
> +	hook(BPRM_CHECK)		\
> +	hook(CREDS_CHECK)		\
> +	hook(POST_SETATTR)		\
> +	hook(MODULE_CHECK)		\
> +	hook(FIRMWARE_CHECK)		\
> +	hook(KEXEC_KERNEL_CHECK)	\
> +	hook(KEXEC_INITRAMFS_CHECK)	\
> +	hook(POLICY_CHECK)		\
> +	hook(MAX_CHECK)
> +#define __ima_hook_enumify(ENUM)	ENUM,
> +
> +enum ima_hooks {
> +	__ima_hooks(__ima_hook_enumify)
> +};
> +
>  #ifdef CONFIG_IMA_KEXEC
>  extern void ima_add_kexec_buffer(struct kimage *image);
>  #endif
> @@ -132,4 +151,13 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
>  	return 0;
>  }
>  #endif /* CONFIG_IMA_APPRAISE */
> +
> +#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
> +extern bool ima_appraise_signature(enum ima_hooks func);
> +#else
> +static inline bool ima_appraise_kexec_signature(enum ima_hooks func)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
>  #endif /* _LINUX_IMA_H */
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 0cfe4f6f7f85..3e04506a00a2 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -20,11 +20,11 @@
>  #include <linux/mutex.h>
>  #include <linux/list.h>
>  #include <linux/fs.h>
> -#include <linux/ima.h>
>  #include <crypto/hash.h>
>  #include <crypto/sha.h>
>  #include <linux/elf.h>
>  #include <linux/elfcore.h>
> +#include <linux/ima.h>
>  #include <linux/kernel.h>
>  #include <linux/syscalls.h>
>  #include <linux/vmalloc.h>
> @@ -240,7 +240,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  
>  		ret = 0;
>  
> -		if (kernel_is_locked_down(reason)) {
> +		/* If IMA is guaranteed to appraise a signature on the kexec
> +		 * image, permit it even if the kernel is otherwise locked
> +		 * down.
> +		 */
> +		if (!ima_appraise_signature(KEXEC_KERNEL_CHECK) &&
> +		    kernel_is_locked_down(reason)) {
>  			ret = -EPERM;
>  			goto out;

[Cc'ing Dave Young, Eric Biederman, kexec mailing list]

There was a discussion about using KEXEC_KERNEL_CHECK as an argument
when replacing copy_file_from_fd() with kernel_read_file_from_fd().
There was a subsequent discussion when adding a security call in
kexec_load_check.  The end result was defining two enumerations named
kernel_read_file_id and kernel_load_data_id with READING_KEXEC_IMAGE
and LOADING_KECEC_IMAGE respectively.

Instead of making the ima_hooks enumeration global, as we're already
relying on READING_KEXEC_IMAGE, use it.

>  		}
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index b6d9f14bc234..aad61bc0f774 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -87,7 +87,7 @@ static void __init evm_init_config(void)
>  	pr_info("HMAC attrs: 0x%x\n", evm_hmac_attrs);
>  }
>  
> -static bool evm_key_loaded(void)
> +bool evm_key_loaded(void)
>  {
>  	return (bool)(evm_initialized & EVM_KEY_MASK);
>  }

Remove remaining EVM fragment.

> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index cc12f3449a72..71614a8ed2aa 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -20,6 +20,7 @@
>  #include <linux/types.h>
>  #include <linux/crypto.h>
>  #include <linux/fs.h>
> +#include <linux/ima.h>
>  #include <linux/security.h>
>  #include <linux/hash.h>
>  #include <linux/tpm.h>
> @@ -171,25 +172,6 @@ static inline unsigned long ima_hash_key(u8 *digest)
>  	return hash_long(*digest, IMA_HASH_BITS);
>  }
>  
> -#define __ima_hooks(hook)		\
> -	hook(NONE)			\
> -	hook(FILE_CHECK)		\
> -	hook(MMAP_CHECK)		\
> -	hook(BPRM_CHECK)		\
> -	hook(CREDS_CHECK)		\
> -	hook(POST_SETATTR)		\
> -	hook(MODULE_CHECK)		\
> -	hook(FIRMWARE_CHECK)		\
> -	hook(KEXEC_KERNEL_CHECK)	\
> -	hook(KEXEC_INITRAMFS_CHECK)	\
> -	hook(POLICY_CHECK)		\
> -	hook(MAX_CHECK)
> -#define __ima_hook_enumify(ENUM)	ENUM,
> -
> -enum ima_hooks {
> -	__ima_hooks(__ima_hook_enumify)
> -};
> -
>  /* LIM API function definitions */
>  int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
>  		   int mask, enum ima_hooks func, int *pcr);
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 8bc8a1c8cb3f..adeae1ab9ee9 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -21,6 +21,7 @@
>  #include <linux/genhd.h>
>  #include <linux/seq_file.h>
>  #include <linux/ima.h>
> +#include <linux/evm.h>
>  
>  #include "ima.h"
>  
> @@ -1336,4 +1337,46 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	seq_puts(m, "\n");
>  	return 0;
>  }
> +
>  #endif	/* CONFIG_IMA_READ_POLICY */
> +
> +#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
> +/*
> + * ima_appraise_signature: whether IMA will appraise a given function using
> + * an IMA digital signature. This is restricted to cases where the kernel
> + * has a set of built-in trusted keys in order to avoid an attacker simply
> + * loading additional keys.
> + */
> +bool ima_appraise_signature(enum ima_hooks func)
> +{
> +	struct ima_rule_entry *entry;
> +	bool found = false;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(entry, ima_rules, list) {
> +		if (entry->action != APPRAISE)
> +			continue;
> +
> +		/* A generic entry will match, but otherwise require that it
> +		 * match the func we're looking for
> +		 */
> +		if (entry->func && entry->func != func)
> +			continue;
> +
> +		/* We require this to be a digital signature, not a raw IMA
> +		 * hash.
> +		 */

Comments should either be a single line or "/*" on a separate line.

> +		if (entry->flags & IMA_DIGSIG_REQUIRED)
> +			found = true;
> +
> +		/* We've found a rule that matches, so break now even if it
> +		 * didn't require a digital signature - a later rule that does
> +		 * won't override it, so would be a false positive.
> +		 */
> +		break;
> +	}
> +

Much better.

thanks,

Mimi

> +	rcu_read_unlock();
> +	return found;
> +}
> +#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */

