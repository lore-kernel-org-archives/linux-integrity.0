Return-Path: <SRS0=sVEj=RW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AC0C43381
	for <linux-integrity@archiver.kernel.org>; Tue, 19 Mar 2019 02:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15C2220850
	for <linux-integrity@archiver.kernel.org>; Tue, 19 Mar 2019 02:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbfCSCr0 (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 18 Mar 2019 22:47:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40678 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727089AbfCSCr0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Mar 2019 22:47:26 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2J2iT1O058782
        for <linux-integrity@vger.kernel.org>; Mon, 18 Mar 2019 22:47:25 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ramuh6qrv-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 18 Mar 2019 22:47:24 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 19 Mar 2019 02:47:19 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 19 Mar 2019 02:47:15 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2J2lHsk47841402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Mar 2019 02:47:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 82E96A405B;
        Tue, 19 Mar 2019 02:47:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D7D3A4054;
        Tue, 19 Mar 2019 02:47:16 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.94.3])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 19 Mar 2019 02:47:16 +0000 (GMT)
Subject: Re: [PATCH] kexec: Allow kexec_file() with appropriate IMA policy
 when locked down
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Matthew Garrett <matthewgarrett@google.com>,
        linux-integrity@vger.kernel.org
Cc:     dhowells@redhat.com, dmitry.kasatkin@gmail.com,
        kexec@lists.infradead.org, dyoung@redhat.com,
        ebiederm@xmission.com, Matthew Garrett <mjg59@google.com>
Date:   Mon, 18 Mar 2019 22:47:05 -0400
In-Reply-To: <20190318230315.232204-1-matthewgarrett@google.com>
References: <20190318230315.232204-1-matthewgarrett@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19031902-4275-0000-0000-0000031CA05F
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031902-4276-0000-0000-0000382B1EB7
Message-Id: <1552963625.4899.3.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-19_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903190019
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-03-18 at 16:03 -0700, Matthew Garrett wrote:
> Systems in lockdown mode should block the kexec of untrusted kernels.
> For x86 and ARM we can ensure that a kernel is trustworthy by validating
> a PE signature, but this isn't possible on other architectures. On those
> platforms we can use IMA digital signatures instead. Add a function to
> determine whether IMA has or will verify signatures for a given event type,
> and if so permit kexec_file() even if the kernel is otherwise locked down.
> This is restricted to cases where CONFIG_INTEGRITY_TRUSTED_KEYRING is set
> in order to prevent an attacker from loading additional keys at runtime.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
> 
> Mimi, this relies on the lockdown patchset but I /think/ is independent
> of the arch policy code - as a result I think it's possible to include
> this in lockdown PR if that works for you, otherwise it can go through
> your tree once the lockdown code is merged?

Yes, please include this patch with the rest of the lockdown patchset.

thanks,

Mimi

> 
>  include/linux/ima.h                 |  9 ++++++
>  kernel/kexec_file.c                 |  7 +++-
>  security/integrity/ima/ima.h        |  2 ++
>  security/integrity/ima/ima_main.c   |  2 +-
>  security/integrity/ima/ima_policy.c | 50 +++++++++++++++++++++++++++++
>  5 files changed, 68 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index dc12fbcf484c..a78c04580a3c 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -132,4 +132,13 @@ static inline int ima_inode_removexattr(struct dentry *dentry,
>  	return 0;
>  }
>  #endif /* CONFIG_IMA_APPRAISE */
> +
> +#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
> +extern bool ima_appraise_signature(enum kernel_read_file_id func);
> +#else
> +static inline bool ima_appraise_kexec_signature(enum kernel_read_file_id func)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */
>  #endif /* _LINUX_IMA_H */
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 0cfe4f6f7f85..8ffa4b75c620 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -240,7 +240,12 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  
>  		ret = 0;
>  
> -		if (kernel_is_locked_down(reason)) {
> +		/* If IMA is guaranteed to appraise a signature on the kexec
> +		 * image, permit it even if the kernel is otherwise locked
> +		 * down.
> +		 */
> +		if (!ima_appraise_signature(READING_KEXEC_IMAGE) &&
> +		    kernel_is_locked_down(reason)) {
>  			ret = -EPERM;
>  			goto out;
>  		}
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index cc12f3449a72..fe03cc6f1ca4 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -115,6 +115,8 @@ struct ima_kexec_hdr {
>  	u64 count;
>  };
>  
> +extern const int read_idmap[];
> +
>  #ifdef CONFIG_HAVE_IMA_KEXEC
>  void ima_load_kexec_buffer(void);
>  #else
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 357edd140c09..927fe889201a 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -473,7 +473,7 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>  	return 0;
>  }
>  
> -static const int read_idmap[READING_MAX_ID] = {
> +const int read_idmap[READING_MAX_ID] = {
>  	[READING_FIRMWARE] = FIRMWARE_CHECK,
>  	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
>  	[READING_MODULE] = MODULE_CHECK,
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> index 8bc8a1c8cb3f..33e0b64305af 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -1337,3 +1337,53 @@ int ima_policy_show(struct seq_file *m, void *v)
>  	return 0;
>  }
>  #endif	/* CONFIG_IMA_READ_POLICY */
> +
> +#if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
> +/*
> + * ima_appraise_signature: whether IMA will appraise a given function using
> + * an IMA digital signature. This is restricted to cases where the kernel
> + * has a set of built-in trusted keys in order to avoid an attacker simply
> + * loading additional keys.
> + */
> +bool ima_appraise_signature(enum kernel_read_file_id id)
> +{
> +	struct ima_rule_entry *entry;
> +	bool found = false;
> +	enum ima_hooks func;
> +
> +	if (id >= READING_MAX_ID)
> +		return false;
> +
> +	func = read_idmap[id] ?: FILE_CHECK;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(entry, ima_rules, list) {
> +		if (entry->action != APPRAISE)
> +			continue;
> +
> +		/*
> +		 * A generic entry will match, but otherwise require that it
> +		 * match the func we're looking for
> +		 */
> +		if (entry->func && entry->func != func)
> +			continue;
> +
> +		/*
> +		 * We require this to be a digital signature, not a raw IMA
> +		 * hash.
> +		 */
> +		if (entry->flags & IMA_DIGSIG_REQUIRED)
> +			found = true;
> +
> +		/*
> +		 * We've found a rule that matches, so break now even if it
> +		 * didn't require a digital signature - a later rule that does
> +		 * won't override it, so would be a false positive.
> +		 */
> +		break;
> +	}
> +
> +	rcu_read_unlock();
> +	return found;
> +}
> +#endif /* CONFIG_IMA_APPRAISE && CONFIG_INTEGRITY_TRUSTED_KEYRING */

