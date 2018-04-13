Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750904AbeDMUk1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 13 Apr 2018 16:40:27 -0400
Date: Fri, 13 Apr 2018 17:40:25 -0300
From: "Bruno E. O. Meneguele" <bmeneg@redhat.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
        Luca Boccassi <bluca@debian.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lockdown: fix coordination of kernel module signature
 verification
Message-ID: <20180413204025.GC2047@rhlt>
References: <1523633272.3272.30.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
In-Reply-To: <1523633272.3272.30.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, Apr 13, 2018 at 11:27:52AM -0400, Mimi Zohar wrote:
> If both IMA-appraisal and sig_enforce are enabled, then both signatures
> are currently required.  If the IMA-appraisal signature verification
> fails, it could rely on the appended signature verification; but with the
> lockdown patch set, the appended signature verification assumes that if
> IMA-appraisal is enabled, it has verified the signature.  Basically each
> signature verification method would be relying on the other to verify the
> kernel module signature.
> 
> This patch addresses the problem of requiring both kernel module signature
> verification methods, when both are enabled, by verifying just the
> appended signature.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> ---
>  kernel/module.c                   | 4 +---
>  security/integrity/ima/ima_main.c | 7 ++++++-
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 9c1709a05037..60861eb7bc4d 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2803,9 +2803,7 @@ static int module_sig_check(struct load_info *info, int flags,
>  		if (sig_enforce) {
>  			pr_notice("%s is rejected\n", reason);
>  			return -EKEYREJECTED;
> -		}
> -
> -		if (can_do_ima_check && is_ima_appraise_enabled())
> +		} else if (can_do_ima_check && is_ima_appraise_enabled())
>  			return 0;
>  		if (kernel_is_locked_down(reason))
>  			return -EPERM;
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 754ece08e1c6..2155b1f316a4 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -480,6 +480,7 @@ static int read_idmap[READING_MAX_ID] = {
>  int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  		       enum kernel_read_file_id read_id)
>  {
> +	bool sig_enforce = is_module_sig_enforced();
>  	enum ima_hooks func;
>  	u32 secid;
>  
> @@ -490,7 +491,11 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  		return 0;
>  	}
>  
> -	if (!file && read_id == READING_MODULE) /* MODULE_SIG_FORCE enabled */
> +	/*
> +	 * If both IMA-appraisal and appended signature verification are
> +	 * enabled, rely on the appended signature verification.
> +	 */
> +	if (sig_enforce && read_id == READING_MODULE)
>  		return 0;
>  
>  	/* permit signed certs */
> -- 
> 2.7.5
> 

I agree with the solution.

Acked-by: Bruno E. O. Meneguele <bmeneg@redhat.com>


    [ Part 2, Application/PGP-SIGNATURE (Name: "signature.asc") 499 bytes. ]
    [ Unable to print this part. ]
