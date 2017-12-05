Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33846 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752151AbdLENkX (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Dec 2017 08:40:23 -0500
Date: Tue, 5 Dec 2017 11:40:21 -0200
From: "Bruno E. O. Meneguele" <brdeoliv@redhat.com>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org,
        linux-ima-devel@lists.sourceforge.net,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ima: log message to module appraisal error
Message-ID: <20171205134021.GB19965@glitch>
References: <20171205133516.23454-1-brdeoliv@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
In-Reply-To: <20171205133516.23454-1-brdeoliv@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Ignore this erroneously sent email.
v2 was already superseded by v3.

On 05-12, Bruno E. O. Meneguele wrote:
> Simple but useful message log to the user in case of module appraise is
> forced and fails due to the lack of file descriptor, that might be
> caused by kmod calls to compressed modules.
> 
> Signed-off-by: Bruno E. O. Meneguele <brdeoliv@redhat.com>
> ---
>  security/integrity/ima/ima_main.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 770654694efc..95ec39910058 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -366,8 +366,12 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
>  
>  	if (!file && read_id == READING_MODULE) {
>  		if (!sig_enforce && (ima_appraise & IMA_APPRAISE_MODULES) &&
> -		    (ima_appraise & IMA_APPRAISE_ENFORCE))
> +		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> +			pr_err("impossible to appraise a module without a file \
> +			       descriptor. sig_enforce kernel parameter might \
> +			       help\n");
>  			return -EACCES;	/* INTEGRITY_UNKNOWN */
> +		}
>  		return 0;	/* We rely on module signature checking */
>  	}
>  	return 0;
> -- 
> 2.14.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


    [ Part 2, Application/PGP-SIGNATURE (Name: "signature.asc") 499 bytes. ]
    [ Unable to print this part. ]
