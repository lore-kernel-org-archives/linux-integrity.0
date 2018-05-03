Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45344 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751874AbeECBnL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 May 2018 21:43:11 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w431gZfm060348
        for <linux-integrity@vger.kernel.org>; Wed, 2 May 2018 21:43:10 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hqr509q9c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 May 2018 21:43:10 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 3 May 2018 02:43:08 +0100
Subject: Re: [PATCH] evm: Don't update hmacs in user ns mounts
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        James Morris <james.l.morris@oracle.com>
Date: Wed, 02 May 2018 21:43:03 -0400
In-Reply-To: <87r2mtybhf.fsf@xmission.com>
References: <87r2mtybhf.fsf@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525311783.3238.19.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-05-02 at 16:49 -0500, Eric W. Biederman wrote:
> From: Seth Forshee <seth.forshee@canonical.com>
> Date: Fri, 22 Dec 2017 15:32:35 +0100
> 
> The kernel should not calculate new hmacs for mounts done by
> non-root users. Update evm_calc_hmac_or_hash() to refuse to
> calculate new hmacs for mounts for non-init user namespaces.
> 
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: James Morris <james.l.morris@oracle.com>
> Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> Signed-off-by: Dongsu Park <dongsu@kinvolk.io>
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> ---
> 
> Mimi this patch has been floating around for a while and it appears to
> be the only piece missing from the vfs to make unprivileged mounts safe
> (at least semantically).  Do you want to merge this through your integrity
> tree or should merge this through my userns tree?

Matthew's EVM patches don't conflict with this change, so either way
is fine.

Mimi

> 
>  security/integrity/evm/evm_crypto.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index a46fba322340..facf9cdd577d 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -200,7 +200,8 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
>  	int size;
>  	bool ima_present = false;
> 
> -	if (!(inode->i_opflags & IOP_XATTR))
> +	if (!(inode->i_opflags & IOP_XATTR) ||
> +	    inode->i_sb->s_user_ns != &init_user_ns)
>  		return -EOPNOTSUPP;
> 
>  	desc = init_desc(type);
