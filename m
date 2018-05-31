Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63880 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755163AbeEaPC5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 May 2018 11:02:57 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4VExmJ0012792
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 11:02:57 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jaj6w3ed8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 11:02:56 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 31 May 2018 16:02:55 +0100
Subject: Re: [PATCH v2 13/21] ima: use match_string() helper
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Yisheng Xie <xieyisheng1@huawei.com>, linux-kernel@vger.kernel.org
Cc: andy.shevchenko@gmail.com,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Thu, 31 May 2018 11:02:38 -0400
In-Reply-To: <1527765086-19873-14-git-send-email-xieyisheng1@huawei.com>
References: <1527765086-19873-1-git-send-email-xieyisheng1@huawei.com>
         <1527765086-19873-14-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527778958.3427.16.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-05-31 at 19:11 +0800, Yisheng Xie wrote:
> match_string() returns the index of an array for a matching string,
> which can be used instead of open coded variant.
> 
> Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>

In the future, the patch's author Signed-off-by is always first.

Thanks, this patch is now queued in the next-integrity branch.

Mimi

> ---
> v2:
>  - add Reviewed-by tag.
> 
>  security/integrity/ima/ima_main.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 74d0bd7..f807093 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -61,14 +61,11 @@ static int __init hash_setup(char *str)
>  		goto out;
>  	}
> 
> -	for (i = 0; i < HASH_ALGO__LAST; i++) {
> -		if (strcmp(str, hash_algo_name[i]) == 0) {
> -			ima_hash_algo = i;
> -			break;
> -		}
> -	}
> -	if (i == HASH_ALGO__LAST)
> +	i = match_string(hash_algo_name, HASH_ALGO__LAST, str);
> +	if (i < 0)
>  		return 1;
> +
> +	ima_hash_algo = i;
>  out:
>  	hash_setup_done = 1;
>  	return 1;
