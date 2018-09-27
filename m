Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56156 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726817AbeI0Rvp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Sep 2018 13:51:45 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8RBRV2M009718
        for <linux-integrity@vger.kernel.org>; Thu, 27 Sep 2018 07:33:54 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mrwhj2762-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 27 Sep 2018 07:33:54 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 27 Sep 2018 12:33:51 +0100
Subject: Re: [PATCH v4 2/6] ima: prevent kexec_load syscall based on runtime
 secureboot flag
From: Mimi Zohar <zohar@linux.ibm.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        jforbes@redhat.com, Seth Forshee <seth.forshee@canonical.com>,
        kexec <kexec@lists.infradead.org>
Date: Thu, 27 Sep 2018 07:33:35 -0400
In-Reply-To: <20180926122210.14642-3-nayna@linux.vnet.ibm.com>
References: <20180926122210.14642-1-nayna@linux.vnet.ibm.com>
         <20180926122210.14642-3-nayna@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1538048015.3459.76.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

[Cc'ing the kexec mailing list, and Seth]

On Wed, 2018-09-26 at 17:52 +0530, Nayna Jain wrote:
> When CONFIG_KEXEC_VERIFY_SIG is enabled, the kexec_file_load syscall
> requires the kexec'd kernel image to be signed. Distros are concerned
> about totally disabling the kexec_load syscall. As a compromise, the
> kexec_load syscall will only be disabled when CONFIG_KEXEC_VERIFY_SIG
> is configured and the system is booted with secureboot enabled.
> 
> This patch disables the kexec_load syscall only for systems booted with
> secureboot enabled.
> 
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>

Nice!

Mimi

> ---
>  security/integrity/ima/ima_main.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index dce0a8a217bb..bdb6e5563d05 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -505,20 +505,24 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>   */
>  int ima_load_data(enum kernel_load_data_id id)
>  {
> -	bool sig_enforce;
> +	bool ima_enforce, sig_enforce;
>  
> -	if ((ima_appraise & IMA_APPRAISE_ENFORCE) != IMA_APPRAISE_ENFORCE)
> -		return 0;
> +	ima_enforce =
> +		(ima_appraise & IMA_APPRAISE_ENFORCE) == IMA_APPRAISE_ENFORCE;
>  
>  	switch (id) {
>  	case LOADING_KEXEC_IMAGE:
> -		if (ima_appraise & IMA_APPRAISE_KEXEC) {
> +#ifdef CONFIG_KEXEC_VERIFY_SIG
> +		if (arch_ima_get_secureboot())
> +			return -EACCES;
> +#endif
> +		if (ima_enforce && (ima_appraise & IMA_APPRAISE_KEXEC)) {
>  			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
>  			return -EACCES;	/* INTEGRITY_UNKNOWN */
>  		}
>  		break;
>  	case LOADING_FIRMWARE:
> -		if (ima_appraise & IMA_APPRAISE_FIRMWARE) {
> +		if (ima_enforce && (ima_appraise & IMA_APPRAISE_FIRMWARE)) {
>  			pr_err("Prevent firmware sysfs fallback loading.\n");
>  			return -EACCES;	/* INTEGRITY_UNKNOWN */
>  		}
> @@ -526,7 +530,8 @@ int ima_load_data(enum kernel_load_data_id id)
>  	case LOADING_MODULE:
>  		sig_enforce = is_module_sig_enforced();
>  
> -		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES)) {
> +		if (ima_enforce && (!sig_enforce
> +				    && (ima_appraise & IMA_APPRAISE_MODULES))) {
>  			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
>  			return -EACCES;	/* INTEGRITY_UNKNOWN */
>  		}
