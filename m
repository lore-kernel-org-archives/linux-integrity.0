Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59318 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932267AbdJWM53 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Oct 2017 08:57:29 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9NCsJKL106736
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2017 08:57:29 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dsgm90ss5-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2017 08:57:28 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 23 Oct 2017 13:57:26 +0100
Subject: Re: [PATCH 2/2] ima: check signature enforcement against cmdline
 param instead of CONFIG
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, serge@hallyn.com,
        james.l.morris@oracle.com, dmitry.kasatkin@gmail.com,
        rusty@rustcorp.com.au, jeyu@kernel.org
Date: Mon, 23 Oct 2017 08:57:15 -0400
In-Reply-To: <2530819c121999268c2c40ad9b907d1ca7726919.1508524595.git.brdeoliv@redhat.com>
References: <cover.1508524595.git.brdeoliv@redhat.com>
         <2530819c121999268c2c40ad9b907d1ca7726919.1508524595.git.brdeoliv@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508763435.3639.92.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-10-20 at 17:19 -0200, Bruno E. O. Meneguele wrote:
> When the user requests MODULE_CHECK policy and its kernel is compiled
> with CONFIG_MODULE_SIG_FORCE not set, all modules would not load, just
> those loaded in initram time. One option the user would have would be
> set a kernel cmdline param (module.sig_enforce) to true, but the IMA
> module check code doesn't rely on this value, it checks just
> CONFIG_MODULE_SIG_FORCE.
> 
> This patch solves this problem checking for the exported value of
> module.sig_enforce cmdline param intead of CONFIG_MODULE_SIG_FORCE,
> which holds the effective value (CONFIG || param).
> 
> Signed-off-by: Bruno E. O. Meneguele <brdeoliv@redhat.com>

Thanks!
> ---
>  security/integrity/ima/ima_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index e4ab8ef8016e..d11a7fcc5c8b 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -356,12 +356,12 @@ void ima_post_path_mknod(struct dentry *dentry)
>   */
>  int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>  {
> +	bool sig_enforce = is_module_sig_enforced();
> +
>  	if (!file && read_id == READING_MODULE) {
> -#ifndef CONFIG_MODULE_SIG_FORCE
> -		if ((ima_appraise & IMA_APPRAISE_MODULES) &&
> +		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
>  		    (ima_appraise & IMA_APPRAISE_ENFORCE))
>  			return -EACCES;	/* INTEGRITY_UNKNOWN */
> -#endif
>  		return 0;	/* We rely on module signature checking */
>  	}
>  	return 0;
