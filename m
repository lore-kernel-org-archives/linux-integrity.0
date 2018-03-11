Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932344AbeCKWBN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 11 Mar 2018 18:01:13 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2BM0UoN029345
        for <linux-integrity@vger.kernel.org>; Sun, 11 Mar 2018 18:01:13 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gmwv6502e-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 11 Mar 2018 18:01:12 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 11 Mar 2018 22:01:10 -0000
Subject: Re: [PATCH v3] ima: drop vla in ima_audit_measurement()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Tycho Andersen <tycho@tycho.ws>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Date: Sun, 11 Mar 2018 18:01:05 -0400
In-Reply-To: <20180308230836.24329-1-tycho@tycho.ws>
References: <20180308230836.24329-1-tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1520805665.3547.7.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-03-08 at 16:08 -0700, Tycho Andersen wrote:
> In keeping with the directive to get rid of VLAs [1], let's drop the VLA
> from ima_audit_measurement(). We need to adjust the return type of
> ima_audit_measurement, because now this function can fail if an allocation
> fails.
> 
> [1]: https://lkml.org/lkml/2018/3/7/621
> 
> v2: just use audit_log_format instead of doing a second allocation
> v3: ignore failures in ima_audit_measurement()
> 
> Signed-off-by: Tycho Andersen <tycho@tycho.ws>

Thanks, this patch has been applied.

Mimi

> ---
>  security/integrity/ima/ima_api.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> index 08fe405338e1..2aab9170ef68 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -308,14 +308,17 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
>  			   const unsigned char *filename)
>  {
>  	struct audit_buffer *ab;
> -	char hash[(iint->ima_hash->length * 2) + 1];
> +	char *hash;
>  	const char *algo_name = hash_algo_name[iint->ima_hash->algo];
> -	char algo_hash[sizeof(hash) + strlen(algo_name) + 2];
>  	int i;
> 
>  	if (iint->flags & IMA_AUDITED)
>  		return;
> 
> +	hash = kzalloc((iint->ima_hash->length * 2) + 1, GFP_KERNEL);
> +	if (!hash)
> +		return;
> +
>  	for (i = 0; i < iint->ima_hash->length; i++)
>  		hex_byte_pack(hash + (i * 2), iint->ima_hash->digest[i]);
>  	hash[i * 2] = '\0';
> @@ -323,18 +326,19 @@ void ima_audit_measurement(struct integrity_iint_cache *iint,
>  	ab = audit_log_start(current->audit_context, GFP_KERNEL,
>  			     AUDIT_INTEGRITY_RULE);
>  	if (!ab)
> -		return;
> +		goto out;
> 
>  	audit_log_format(ab, "file=");
>  	audit_log_untrustedstring(ab, filename);
> -	audit_log_format(ab, " hash=");
> -	snprintf(algo_hash, sizeof(algo_hash), "%s:%s", algo_name, hash);
> -	audit_log_untrustedstring(ab, algo_hash);
> +	audit_log_format(ab, " hash=\"%s:%s\"", algo_name, hash);
> 
>  	audit_log_task_info(ab, current);
>  	audit_log_end(ab);
> 
>  	iint->flags |= IMA_AUDITED;
> +out:
> +	kfree(hash);
> +	return;
>  }
> 
>  /*
