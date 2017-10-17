Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935002AbdJQV6n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2017 17:58:43 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9HLs9XW020607
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2017 17:58:42 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dnsxu0nxq-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2017 17:58:42 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 17 Oct 2017 22:58:41 +0100
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id v9HLwbJV25100460
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2017 21:58:38 GMT
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
        by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id v9HLwa3f003037
        for <linux-integrity@vger.kernel.org>; Wed, 18 Oct 2017 08:58:36 +1100
Subject: Re: [Linux-ima-devel] [PATCH] ima: fix ineffective default hash
 algorithm due to invalid hash algorithm boot argument
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Boshi Wang <wangboshi@huawei.com>
Cc: linux-integrity <linux-integrity@vger.kernel.org>
Date: Tue, 17 Oct 2017 17:58:33 -0400
In-Reply-To: <3aaaf65f-d3b0-f770-f074-11e8f9796685@huawei.com>
References: <3aaaf65f-d3b0-f770-f074-11e8f9796685@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508277513.4513.63.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Boshi,

On Wed, 2017-10-11 at 15:46 +0800, Boshi Wang wrote:
> The hash_setup function always sets hash_setup_done variable. If an
> invalid hash algorithm is passed, the default hash algorithm specified
> by CONFIG_IMA_DEFAULT_HASH could not be used.
> 
> Signed-off-by: Wang Boshi <wangboshi@huawei.com>

This patch does not apply properly.  To see the problem, save the
patch as an mbox file and then apply it using git am <filename.mbox>.

Mimi

> ---
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 2aebb79..ab70a39 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -51,6 +51,8 @@ static int __init hash_setup(char *str)
>               ima_hash_algo = HASH_ALGO_SHA1;
>           else if (strncmp(str, "md5", 3) == 0)
>               ima_hash_algo = HASH_ALGO_MD5;
> +        else
> +            return 1;
>           goto out;
>       }
> 
> @@ -60,6 +62,8 @@ static int __init hash_setup(char *str)
>               break;
>           }
>       }
> +    if (i == HASH_ALGO__LAST)
> +        return 1;
>   out:
>       hash_setup_done = 1;
>       return 1;
> 
> 
> 
