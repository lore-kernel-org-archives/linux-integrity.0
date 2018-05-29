Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933565AbeE2Mas (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 May 2018 08:30:48 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4TCTwHr043466
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 08:30:48 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j94swwyb7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 08:30:47 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 29 May 2018 13:30:43 +0100
Subject: Re: [PATCH] EVM: Fix null dereference on xattr when xattr fails to
 allocate
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Colin King <colin.king@canonical.com>,
        Matthew Garrett <mjg59@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 May 2018 08:30:27 -0400
In-Reply-To: <20180527225510.25612-1-colin.king@canonical.com>
References: <20180527225510.25612-1-colin.king@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527597027.10176.16.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Colin,

On Sun, 2018-05-27 at 23:55 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where the allocation of xattr fails and xattr is NULL, the
> error exit return path via label 'out' will dereference xattr when
> kfree'ing xattr-name.  Fix this by only kfree'ing xattr->name and xattr
> when xattr is non-null.
> 
> Detected by CoverityScan, CID#1469366 ("Dereference after null check")
> 
> Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verified xattrs")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  security/integrity/evm/evm_secfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/evm_secfs.c
> index fb8bc950aceb..cf5cd303d7c0 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -253,8 +253,10 @@ static ssize_t evm_write_xattrs(struct file *file, const char __user *buf,
>  out:
>  	audit_log_format(ab, " res=%d", err);
>  	audit_log_end(ab);
> -	kfree(xattr->name);
> -	kfree(xattr);
> +	if (xattr) {
> +		kfree(xattr->name);
> +		kfree(xattr);
> +	}
>  	return err;
>  }
> 

Thanks!  To fix this problem, I think more is needed.

Without the xattr, there is nothing to audit except the attempt to
extend the xattr list.  Failure to allocate the xattr or xattr->name
should either result in a different audit message or return
immediately without any audit message.

Mimi
