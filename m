Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60480 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752524AbeEGU7v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 May 2018 16:59:51 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w47KxQZj131610
        for <linux-integrity@vger.kernel.org>; Mon, 7 May 2018 16:59:50 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2htvebvwpk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 07 May 2018 16:59:50 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 7 May 2018 21:59:49 +0100
Subject: Re: [PATCH] ima: Unify logging
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Date: Mon, 07 May 2018 16:59:44 -0400
In-Reply-To: <20180424143038.16703-1-pvorel@suse.cz>
References: <20180424143038.16703-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525726784.3551.12.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-04-24 at 16:30 +0200, Petr Vorel wrote:
> Define pr_fmt everywhere.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Queued in the next-integrity branch.

thanks,

Mimi

> ---
>  security/integrity/ima/ima_fs.c           | 7 +++++--
>  security/integrity/ima/ima_kexec.c        | 2 ++
>  security/integrity/ima/ima_template_lib.c | 2 ++
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index fa540c0469da..aae558926ac0 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -15,6 +15,9 @@
>   *	implemenents security file system for reporting
>   *	current measurement list and IMA statistics
>   */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/fcntl.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> @@ -336,7 +339,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
>  	if (data[0] == '/') {
>  		result = ima_read_policy(data);
>  	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
> -		pr_err("IMA: signed policy file (specified as an absolute pathname) required\n");
> +		pr_err("signed policy file (specified as an absolute pathname) required\n");
>  		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
>  				    "policy_update", "signed policy required",
>  				    1, 0);
> @@ -417,7 +420,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
>  		valid_policy = 0;
>  	}
> 
> -	pr_info("IMA: policy update %s\n", cause);
> +	pr_info("policy update %s\n", cause);
>  	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
>  			    "policy_update", cause, !valid_policy, 0);
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index e473eee913cb..db0de585f6c0 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,6 +15,8 @@
>  #include <linux/kexec.h>
>  #include "ima.h"
> 
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #ifdef CONFIG_IMA_KEXEC
>  static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  				     unsigned long segment_size)
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index 5afaa53decc5..43752002c222 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -13,6 +13,8 @@
>   *      Library of supported template fields.
>   */
> 
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include "ima_template_lib.h"
> 
>  static bool ima_template_hash_algo_allowed(u8 algo)
