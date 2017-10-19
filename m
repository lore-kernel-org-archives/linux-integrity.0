Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752892AbdJSPHN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2017 11:07:13 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9JF7AX3052326
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 11:07:13 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2dpvu3ffuj-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 11:07:10 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 19 Oct 2017 16:05:24 +0100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9JF5JLQ28770454
        for <linux-integrity@vger.kernel.org>; Thu, 19 Oct 2017 15:05:21 GMT
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
        by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9JF5Odo025623
        for <linux-integrity@vger.kernel.org>; Fri, 20 Oct 2017 02:05:24 +1100
Subject: Re: [PATCH] ima: fix ineffective default hash algorithm due to
 invalid hash algorithm boot argument
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Boshi Wang <wangboshi@huawei.com>, linux-integrity@vger.kernel.org
Date: Thu, 19 Oct 2017 11:05:16 -0400
In-Reply-To: <20171018033801.220383-1-wangboshi@huawei.com>
References: <20171018033801.220383-1-wangboshi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508425516.3268.18.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2017-10-18 at 11:38 +0800, Boshi Wang wrote:
> The hash_setup function always sets hash_setup_done variable. If an
> invalid hash algorithm is passed, the default hash algorithm specified
> by CONFIG_IMA_DEFAULT_HASH could not be used.

The Subject line of this email is too long and needs to be clearer.
 Please refer to Documentation/process/submitting-patches.rst section
14 "The canonical patch format".  I would recommend shortening it to
something like "ima: fix hash algorithm initialization".

The patch description should start out with a concise explanation of
the current status, followed by the problem description and end with
the solution.  For example,

The hash_setup function always sets the hash_setup_done flag, even
when the hash algorithm is invalid.  This prevents the default hash
algorithm defined as CONFIG_IMA_DEFAULT_HASH from being used.

This patch sets hash_setup_done flag only for valid hash algorithms.

Mimi

> Signed-off-by: Boshi Wang <wangboshi@huawei.com>
> ---
>  security/integrity/ima/ima_main.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 2aebb79..ab70a39 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -51,6 +51,8 @@ static int __init hash_setup(char *str)
>  			ima_hash_algo = HASH_ALGO_SHA1;
>  		else if (strncmp(str, "md5", 3) == 0)
>  			ima_hash_algo = HASH_ALGO_MD5;
> +		else
> +			return 1;
>  		goto out;
>  	}
> 
> @@ -60,6 +62,8 @@ static int __init hash_setup(char *str)
>  			break;
>  		}
>  	}
> +	if (i == HASH_ALGO__LAST)
> +		return 1;
>  out:
>  	hash_setup_done = 1;
>  	return 1;
