Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38244 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755134AbeEaPAn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 May 2018 11:00:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4VEx6NI089443
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 11:00:42 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jajg8tgff-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 31 May 2018 11:00:42 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 31 May 2018 16:00:39 +0100
Subject: Re: [PATCH][next] EVM: fix memory leak of temporary buffer 'temp'
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Colin King <colin.king@canonical.com>,
        Matthew Garrett <mjg59@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 31 May 2018 11:00:22 -0400
In-Reply-To: <20180527221502.25073-1-colin.king@canonical.com>
References: <20180527221502.25073-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527778822.3427.13.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Sun, 2018-05-27 at 23:15 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The allocation of 'temp' is not kfree'd and hence there is a memory
> leak on each call of evm_read_xattrs.  Fix this by kfree'ing it
> after copying data from it back to the user space buffer 'buf'.
> 
> Detected by CoverityScan, CID#1469386 ("Resource Leak")
> 
> Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Thanks, this patch and "EVM: Fix null dereference on xattr when xattr
fails to allocate" are queued in the next-integrity branch.

Mimi

> ---
>  security/integrity/evm/evm_secfs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index a7a0a1acae99..fb8bc950aceb 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -158,6 +158,8 @@ static ssize_t evm_read_xattrs(struct file *filp, char __user *buf,
>  	mutex_unlock(&xattr_list_mutex);
>  	rc = simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
> 
> +	kfree(temp);
> +
>  	return rc;
>  }
> 
