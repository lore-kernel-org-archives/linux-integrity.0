Return-Path: <SRS0=IrrW=RQ=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D21CC43381
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Mar 2019 11:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B15B2171F
	for <linux-integrity@archiver.kernel.org>; Wed, 13 Mar 2019 11:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfCML64 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 13 Mar 2019 07:58:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfCML64 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Mar 2019 07:58:56 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2DBt4rI109252
        for <linux-integrity@vger.kernel.org>; Wed, 13 Mar 2019 07:58:55 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2r70vmhuj4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 13 Mar 2019 07:58:54 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 13 Mar 2019 11:58:52 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 13 Mar 2019 11:58:49 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2DBwmY550528268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Mar 2019 11:58:48 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 472DEAE063;
        Wed, 13 Mar 2019 11:58:48 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 864ABAE045;
        Wed, 13 Mar 2019 11:58:47 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.217])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Mar 2019 11:58:47 +0000 (GMT)
Subject: Re: [RFC] kexec: Allow kexec_file() with appropriate IMA policy
 when locked down
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, dmitry.kasatkin@gmail.com,
        Matthew Garrett <mjg59@google.com>
Date:   Wed, 13 Mar 2019 07:58:36 -0400
In-Reply-To: <20190312195715.101995-1-matthewgarrett@google.com>
References: <20190312195715.101995-1-matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031311-0016-0000-0000-000002615C6E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031311-0017-0000-0000-000032BC0909
Message-Id: <1552478316.24794.210.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-13_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903130087
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2019-03-12 at 12:57 -0700, Matthew Garrett wrote:
> Systems in lockdown mode should block the kexec of untrusted kernels.
> For x86 and ARM we can ensure that a kernel is trustworthy by validating
> a PE signature, but this isn't possible on other architectures. On those
> platforms we can use IMA instead, either with native IMA digital
> signatures or EVM-protected IMA hashes. Add a function to determine
> whether IMA will verify signatures on kexec files, and if so permit
> kexec_file() even if the kernel is otherwise locked down. This is
> restricted to cases where CONFIG_INTEGRITY_TRUSTED_KEYRING is set in
> order to prevent an attacker from loading additional keys at runtime.

Thank you for working on this!  With the changes suggested below, it
might work.  :)

> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
>  include/linux/evm.h                 |  6 +++++
>  include/linux/ima.h                 |  9 ++++++++
>  kernel/kexec_file.c                 |  9 ++++++--
>  security/integrity/evm/evm_main.c   |  2 +-
>  security/integrity/ima/ima_policy.c | 35 +++++++++++++++++++++++++++++
>  5 files changed, 58 insertions(+), 3 deletions(-)
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
>  static inline int evm_set_key(void *key, size_t keylen)
>  {
>  	return -EOPNOTSUPP;
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index dc12fbcf484c..2ec593537c9b 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -132,4 +132,13 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
>  	return 0;
>  }
>  #endif /* CONFIG_IMA_APPRAISE */
> +
> +#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
> +extern bool ima_appraise_kexec_signature(void);
> +#else
> +static inline bool ima_appraise_kexec_signature(void)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
>  #endif /* _LINUX_IMA_H */
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 0cfe4f6f7f85..8ca607f1b515 100644
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
> +		if (!ima_appraise_kexec_signature() &&
> +		    kernel_is_locked_down(reason)) {
>  			ret = -EPERM;
>  			goto out;
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

This might be sufficient for your environment, but in general it
isn't.


> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 8bc8a1c8cb3f..c06b1a6b3528 100644
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
> @@ -1336,4 +1337,38 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	seq_puts(m, "\n");
>  	return 0;
>  }
> +
>  #endif	/* CONFIG_IMA_READ_POLICY */
> +
> +#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)

With these defines, the function isn't limited to just "lockdown".
 Either fix the defines or the patch description.

> +/*
> + * ima_appraise_kexec: whether IMA will appraise a kexec image, either via
> + * IMA digital signatures or with a hash and EVM validation
> + */
> +bool ima_appraise_kexec_signature(void)

Instead of making this specific to kexec, how about naming the
function something like ima_require_appraise_signature() and pass the
kernel_read_file_id (eg. READING_KEXEC_IMAGE, READING_MODULE).

> +{
> +	struct ima_rule_entry *entry;
> +	bool found = false;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(entry, ima_rules, list) {
> +		if (entry->func != KEXEC_KERNEL_CHECK ||
> +		    entry->action != APPRAISE)
> +			continue;
> +
> +		/*
> +		 * We require this to be a digital signature, not a raw IMA
> +		 * hash. An IMA hash is acceptable as long as it's covered
> +		 * by an EVM signature.
> +		 */
> +		if (entry->flags & IMA_DIGSIG_REQUIRED ||
> +		    evm_key_loaded()) {

evm_key_loaded() is a problem.

> +			found = true;
> +			break;
> +		}

The first matching rule dictates the policy.  Move the "break" here.

Walking the list looking for a specific rule might not be a true
indication of the policy.  For example, with a generic rule prior to a
specific rule, the generic rule might take precedence.

As long as the generic rules require a signature, there isn't a
problem.  I would stop walking the policy rules after the first
"appraise" rule that doesn't require a signature.  This will prevent
returning a false positive.

The builtin and arch policy rules are by design forced to be first.

Mimi


> +	}
> +
> +	rcu_read_unlock();
> +	return found;
> +}
> +#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */

