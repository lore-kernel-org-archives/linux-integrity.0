Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59704 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390726AbeIVB1g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 21 Sep 2018 21:27:36 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8LJZFDT090321
        for <linux-integrity@vger.kernel.org>; Fri, 21 Sep 2018 15:37:16 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mn3ssypjx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 21 Sep 2018 15:37:15 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 21 Sep 2018 20:37:13 +0100
Subject: Re: [PATCH] ima: fix showing large 'violations' or
 'runtime_measurements_count'
From: Mimi Zohar <zohar@linux.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>,
        linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Fri, 21 Sep 2018 15:37:09 -0400
In-Reply-To: <20180907213324.242732-1-ebiggers@kernel.org>
References: <20180907213324.242732-1-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1537558629.3830.361.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-09-07 at 14:33 -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The 12 character temporary buffer is not necessarily long enough to hold
> a 'long' value.  Increase it

> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  security/integrity/ima/ima_fs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index fe0ede883557..9e239b1dea2f 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -42,14 +42,14 @@ static int __init default_canonical_fmt_setup(char *str)
>  __setup("ima_canonical_fmt", default_canonical_fmt_setup);
> 
>  static int valid_policy = 1;
> -#define TMPBUFLEN 12
> +
>  static ssize_t ima_show_htable_value(char __user *buf, size_t count,
>  				     loff_t *ppos, atomic_long_t *val)
>  {
> -	char tmpbuf[TMPBUFLEN];
> +	char tmpbuf[32];

The maximum string size needed to represent a long is not 32, even on
a 64 bit system.  32 bytes is fine, but please comment this.

>  	ssize_t len;
> 
> -	len = scnprintf(tmpbuf, TMPBUFLEN, "%li\n", atomic_long_read(val));
> +	len = scnprintf(tmpbuf, sizeof(tmpbuf), "%li\n", atomic_long_read(val));
>  	return simple_read_from_buffer(buf, count, ppos, tmpbuf, len);
>  }
> 
