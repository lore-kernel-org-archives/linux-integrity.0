Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751293AbeEQMFP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 May 2018 08:05:15 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4HBww7T108095
        for <linux-integrity@vger.kernel.org>; Thu, 17 May 2018 08:05:14 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2j183qbybg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 17 May 2018 08:05:13 -0400
Received: from localhost
        by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 17 May 2018 13:05:12 +0100
Subject: Re: [PATCH] ima: Fix pr_fmt() redefinition
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 17 May 2018 08:04:55 -0400
In-Reply-To: <20180517104702.24689-1-pvorel@suse.cz>
References: <20180517104702.24689-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1526558695.3306.11.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Petr,

On Thu, 2018-05-17 at 12:47 +0200, Petr Vorel wrote:
> Previous definition was too late and caused problems in powerpc allyesconfig:
> security/integrity/ima/ima_kexec.c:18:0: warning: "pr_fmt" redefined
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> 
> In file included from include/linux/kernel.h:14:0,
>                  from include/asm-generic/bug.h:18,
>                  from arch/powerpc/include/asm/bug.h:128,
>                  from include/linux/bug.h:5,
>                  from include/linux/seq_file.h:7,
>                  from security/integrity/ima/ima_kexec.c:13:
> include/linux/printk.h:288:0: note: this is the location of the previous definition
>  #define pr_fmt(fmt) fmt
> 
> Fixes: 3dea0d93d257 ("ima: Unify logging")
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>

As the original patch hasn't been upstreamed yet, I'll squash this fix
with the original patch.

thanks!

Mimi

> ---
>  security/integrity/ima/ima_kexec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index db0de585f6c0..16bd18747cfa 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -10,13 +10,13 @@
>   * the Free Software Foundation; either version 2 of the License, or
>   * (at your option) any later version.
>   */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
>  #include <linux/seq_file.h>
>  #include <linux/vmalloc.h>
>  #include <linux/kexec.h>
>  #include "ima.h"
> 
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #ifdef CONFIG_IMA_KEXEC
>  static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  				     unsigned long segment_size)
