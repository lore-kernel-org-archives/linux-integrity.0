Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from h2.hallyn.com ([78.46.35.8]:47776 "EHLO h2.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751865AbdLUSAD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Dec 2017 13:00:03 -0500
Date: Thu, 21 Dec 2017 12:00:01 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Vasyl Gomonovych <gomonovych@gmail.com>
Cc: zohar@linux.vnet.ibm.com, dmitry.kasatkin@gmail.com,
        james.l.morris@oracle.com, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ima: Fix warn potential negative subtraction from max
Message-ID: <20171221180001.GC16008@mail.hallyn.com>
References: <1513871754-13943-1-git-send-email-gomonovych@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1513871754-13943-1-git-send-email-gomonovych@gmail.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Quoting Vasyl Gomonovych (gomonovych@gmail.com):
> Found by smatch:
> security/integrity/ima/ima_queue.c:122 ima_add_digest_entry() warn:
> potential negative subtraction from max '(~0)- size'
> 
> Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
> ---
>  security/integrity/ima/ima_queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index a02a86d51102..446018478b81 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -116,7 +116,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
>  	}
>  
>  	if (binary_runtime_size != ULONG_MAX) {
> -		int size;
> +		unsigned int size;

Hm, but get_binary_runtime_size() returns an int.

>  
>  		size = get_binary_runtime_size(entry);
>  		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
> -- 
> 1.9.1
