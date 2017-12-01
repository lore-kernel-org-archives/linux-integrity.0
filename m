Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48804 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751541AbdLAQbM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Dec 2017 11:31:12 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB1GV5Om070336
        for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2017 11:31:12 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2eka4mhukg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2017 11:31:11 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 1 Dec 2017 16:31:09 -0000
Subject: Re: [RFC][PATCH v2 2/9] ima: preserve flags in
 ima_inode_post_setattr() if file must be appraised
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Roberto Sassu <roberto.sassu@huawei.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, silviu.vlasceanu@huawei.com
Date: Fri, 01 Dec 2017 11:31:04 -0500
In-Reply-To: <20171130105610.15761-3-roberto.sassu@huawei.com>
References: <20171130105610.15761-1-roberto.sassu@huawei.com>
         <20171130105610.15761-3-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1512145864.17800.43.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-11-30 at 11:56 +0100, Roberto Sassu wrote:
> Before commit d79d72e02485 ("ima: per hook cache integrity appraisal
> status"), ima_inode_post_setattr() clears the iint flags only if the file
> does not match policy rules after attributes changed. After the commit
> above, it clears the flags in any case. This patch restores the original
> behavior.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Prior to this commit, the file was either in/out of policy for all
hooks.  This commit introduced the concept of different hooks
requiring different types of integrity appraisal (eg. hash,
signature).  An attribute change (eg. fowner) could require a
different type of integrity appraisal.  With this patch, knowing just
that a file is in/out of policy isn't fine grained enough.

Mimi

> ---
>  security/integrity/ima/ima_appraise.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index 1b56ee949315..a54ad18affb1 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -360,11 +360,13 @@ void ima_inode_post_setattr(struct dentry *dentry)
>  	must_appraise = ima_must_appraise(inode, MAY_ACCESS, POST_SETATTR);
>  	iint = integrity_iint_find(inode);
>  	if (iint) {
> -		iint->flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
> -				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
> -				 IMA_ACTION_RULE_FLAGS);
>  		if (must_appraise)
>  			iint->flags |= IMA_APPRAISE;
> +		else
> +			iint->flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
> +					 IMA_APPRAISE_SUBMASK |
> +					 IMA_APPRAISED_SUBMASK |
> +					 IMA_ACTION_RULE_FLAGS);
>  	}
>  	if (!must_appraise)
>  		__vfs_removexattr(dentry, XATTR_NAME_IMA);
