Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751344AbeEBNdz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 May 2018 09:33:55 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w42DUECM013475
        for <linux-integrity@vger.kernel.org>; Wed, 2 May 2018 09:33:55 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hqchcn55q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 May 2018 09:33:54 -0400
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 2 May 2018 14:33:52 +0100
Subject: Re: [PATCH 2/3] kexec: call LSM hook for kexec_load syscall
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Eric Biederman <ebiederm@xmission.com>
Cc: kexec@lists.infradead.org,
        linux-integrity <linux-integrity@vger.kernel.org>
Date: Wed, 02 May 2018 09:33:48 -0400
In-Reply-To: <1523572911-16363-3-git-send-email-zohar@linux.vnet.ibm.com>
References: <1523572911-16363-1-git-send-email-zohar@linux.vnet.ibm.com>
         <1523572911-16363-3-git-send-email-zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525268028.5669.276.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Eric,

I'd really appreciate your reviewing/ack'ing this patch.

thanks,

Mimi

On Thu, 2018-04-12 at 18:41 -0400, Mimi Zohar wrote:
> Allow LSMs and IMA to differentiate between the kexec_load and
> kexec_file_load syscalls by adding an "unnecessary" call to
> security_kernel_read_file() in kexec_load.  This would be similar to the
> existing init_module syscall calling security_kernel_read_file().
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  kernel/kexec.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index aed8fb2564b3..d1386cfc6796 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -11,6 +11,7 @@
>  #include <linux/capability.h>
>  #include <linux/mm.h>
>  #include <linux/file.h>
> +#include <linux/security.h>
>  #include <linux/kexec.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
> @@ -195,11 +196,21 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  static inline int kexec_load_check(unsigned long nr_segments,
>  				   unsigned long flags)
>  {
> +	int result;
> +
>  	/* We only trust the superuser with rebooting the system. */
>  	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
>  		return -EPERM;
> 
>  	/*
> +	 * Allow LSMs and IMA to differentiate between kexec_load and
> +	 * kexec_file_load syscalls.
> +	 */
> +	result = security_kernel_read_file(NULL, READING_KEXEC_IMAGE);
> +	if (result < 0)
> +		return result;
> +
> +	/*
>  	 * Verify we have a legal set of flags
>  	 * This leaves us room for future extensions.
>  	 */
