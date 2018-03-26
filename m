Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38070 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751748AbeCZOYv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Mar 2018 10:24:51 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2QEOiYG143529
        for <linux-integrity@vger.kernel.org>; Mon, 26 Mar 2018 10:24:51 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2gy2e8gdnv-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 26 Mar 2018 10:24:48 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 26 Mar 2018 15:24:42 +0100
Subject: Re: [PATCH v6 04/12] ima: Introduce is_ima_sig()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>
Date: Mon, 26 Mar 2018 10:24:33 -0400
In-Reply-To: <20180316203837.10174-5-bauerman@linux.vnet.ibm.com>
References: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
         <20180316203837.10174-5-bauerman@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1522074273.3541.83.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-03-16 at 17:38 -0300, Thiago Jung Bauermann wrote:
> With the introduction of another IMA signature type (modsig), some places
> will need to check for both of them. It is cleaner to do that if there's a
> helper function to tell whether an xattr_value represents an IMA
> signature.

Initially the function name "is_ima_sig" is fine, since it reflects
the 'imasig' type.  Having a more generic function name would be
better when adding 'modsig' support.  As long as the function is
locally define, we can drop 'ima' from the name.  Perhaps something
like has_signature or is_signed() would be preferable.

Mimi


> 
> Suggested-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  security/integrity/ima/ima.h              | 5 +++++
>  security/integrity/ima/ima_appraise.c     | 7 +++----
>  security/integrity/ima/ima_template_lib.c | 2 +-
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 35fe91aa1fc9..4bafa6a97967 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -155,6 +155,11 @@ unsigned long ima_get_binary_runtime_size(void);
>  int ima_init_template(void);
>  void ima_init_template_list(void);
> 
> +static inline bool is_ima_sig(const struct evm_ima_xattr_data *xattr_value)
> +{
> +	return xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG;
> +}
> +
>  /*
>   * used to protect h_table and sha_table
>   */
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index a6b2995b7d0b..01172eab297b 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -325,15 +325,14 @@ int ima_appraise_measurement(enum ima_hooks func,
>  	} else if (status != INTEGRITY_PASS) {
>  		/* Fix mode, but don't replace file signatures. */
>  		if ((ima_appraise & IMA_APPRAISE_FIX) &&
> -		    (!xattr_value ||
> -		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
> +		    !is_ima_sig(xattr_value)) {
>  			if (!ima_fix_xattr(dentry, iint))
>  				status = INTEGRITY_PASS;
>  		}
> 
>  		/* Permit new files with file signatures, but without data. */
>  		if (inode->i_size == 0 && iint->flags & IMA_NEW_FILE &&
> -		    xattr_value && xattr_value->type == EVM_IMA_XATTR_DIGSIG) {
> +		    is_ima_sig(xattr_value)) {
>  			status = INTEGRITY_PASS;
>  		}
> 
> @@ -448,7 +447,7 @@ int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
>  		if (!xattr_value_len || (xvalue->type >= IMA_XATTR_LAST))
>  			return -EINVAL;
>  		ima_reset_appraise_flags(d_backing_inode(dentry),
> -			xvalue->type == EVM_IMA_XATTR_DIGSIG);
> +					 is_ima_sig(xvalue));
>  		result = 0;
>  	}
>  	return result;
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
> index 5afaa53decc5..afb52a90e532 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -380,7 +380,7 @@ int ima_eventsig_init(struct ima_event_data *event_data,
>  {
>  	struct evm_ima_xattr_data *xattr_value = event_data->xattr_value;
> 
> -	if ((!xattr_value) || (xattr_value->type != EVM_IMA_XATTR_DIGSIG))
> +	if (!is_ima_sig(xattr_value))
>  		return 0;
> 
>  	return ima_write_template_field_data(xattr_value, event_data->xattr_len,
> 
