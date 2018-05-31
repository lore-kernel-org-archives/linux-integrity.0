Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755254AbeEaPBA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 May 2018 11:01:00 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4VEx1Zm154924
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 11:01:00 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2jahmjn77t-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 11:00:56 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 31 May 2018 16:00:54 +0100
Subject: Re: [PATCH] EVM: prevent array underflow in evm_write_xattrs()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Garrett <mjg59@google.com>
Cc: James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date: Thu, 31 May 2018 11:00:39 -0400
In-Reply-To: <20180529131128.3rkzzv66uy6h5ts7@kili.mountain>
References: <20180529131128.3rkzzv66uy6h5ts7@kili.mountain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527778839.3427.14.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-05-29 at 16:11 +0300, Dan Carpenter wrote:
> If the user sets xattr->name[0] to NUL then we would read one character
> before the start of the array.  This bug seems harmless as far as I can
> see but perhaps it would trigger a warning in KASAN.
> 
> Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks, this patch is now queued in the next-integrity branch.

Mimi

> ---
> The user can pass a zeroed buffer to memdup_user_nul() so we can't rely
> on "count" to test this.
> 
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index a7a0a1acae99..94c739180a0b 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -207,7 +207,7 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
> 
>  	/* Remove any trailing newline */
>  	len = strlen(xattr->name);
> -	if (xattr->name[len-1] == '\n')
> +	if (len && xattr->name[len-1] == '\n')
>  		xattr->name[len-1] = '\0';
> 
>  	if (strcmp(xattr->name, ".") == 0) {
> 
