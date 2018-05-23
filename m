Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60296 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933199AbeEWOmu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 May 2018 10:42:50 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4NEdDI4031529
        for <linux-integrity@vger.kernel.org>; Wed, 23 May 2018 10:42:50 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j58rvdnae-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 23 May 2018 10:42:49 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 23 May 2018 15:42:47 +0100
Subject: Re: [PATCH 25/33] ima: use match_string() helper
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Yisheng Xie <xieyisheng1@huawei.com>, linux-kernel@vger.kernel.org
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Date: Wed, 23 May 2018 10:42:43 -0400
In-Reply-To: <1526903890-35761-26-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
         <1526903890-35761-26-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527086563.4168.0.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Mon, 2018-05-21 at 19:58 +0800, Yisheng Xie wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.
> 
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>

Reviewed-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

> ---
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
