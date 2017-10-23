Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932084AbdJWM5H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Oct 2017 08:57:07 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9NCsOP5031279
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2017 08:57:07 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dsdtc0ur4-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2017 08:57:06 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 23 Oct 2017 13:57:05 +0100
Subject: Re: [PATCH 1/2] module: export module signature enforcement status
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, serge@hallyn.com,
        james.l.morris@oracle.com, dmitry.kasatkin@gmail.com,
        rusty@rustcorp.com.au, jeyu@kernel.org
Date: Mon, 23 Oct 2017 08:56:55 -0400
In-Reply-To: <5aea5786954da170e171fc9ddd1f591c0e36afc7.1508524595.git.brdeoliv@redhat.com>
References: <cover.1508524595.git.brdeoliv@redhat.com>
         <5aea5786954da170e171fc9ddd1f591c0e36afc7.1508524595.git.brdeoliv@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508763415.3639.91.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-10-20 at 17:19 -0200, Bruno E. O. Meneguele wrote:
> A static variable sig_enforce is used as status var to indicate the real
> value of CONFIG_MODULE_SIG_FORCE, once this one is set the var will hold
> true, but if the CONFIG is not set the status var will hold whatever
> value is present in the module.sig_enforce kernel cmdline param: true
> when =1 and false when =0 or not present.
> 
> Considering this cmdline param take place over the CONFIG value when
> it's not set, other places in the kernel could missbehave since they

^misbehave

> would have only the CONFIG_MODULE_SIG_FORCE value to rely on. Exporting
> this status var allows the kernel to rely in the effective value of
> module signature enforcement, being it from CONFIG value or cmdline
> param.

Thanks!  There's a minor checkpatch warning below.

> Signed-off-by: Bruno E. O. Meneguele <brdeoliv@redhat.com>
> ---
>  include/linux/module.h | 2 ++
>  kernel/module.c        | 8 ++++++++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index fe5aa3736707..ddfe17e3a85c 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -806,4 +806,6 @@ static inline bool module_sig_ok(struct module *module)
>  }
>  #endif	/* CONFIG_MODULE_SIG */
> 
> +bool is_module_sig_enforced(void);
> +
>  #endif /* _LINUX_MODULE_H */
> diff --git a/kernel/module.c b/kernel/module.c
> index de66ec825992..b93c7ff44066 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -278,6 +278,14 @@ static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
>  module_param(sig_enforce, bool_enable_only, 0644);
>  #endif /* !CONFIG_MODULE_SIG_FORCE */
> 
> +/* Export sig_enforce kernel cmdline parameter to allow other subsystems rely
> + * on that instead of directly to CONFIG_MODULE_SIG_FORCE config. */

Checkpatch complains.  Please use the normal format:
/*
 *
 */

> +bool is_module_sig_enforced(void)
> +{
> +	return sig_enforce;
> +}
> +EXPORT_SYMBOL(is_module_sig_enforced);
> +
>  /* Block module loading/unloading? */
>  int modules_disabled = 0;
>  core_param(nomodule, modules_disabled, bint, 0);
