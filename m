Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48730 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750757AbeCPRMG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Mar 2018 13:12:06 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2GH9Wdb015878
        for <linux-integrity@vger.kernel.org>; Fri, 16 Mar 2018 13:12:05 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2grhf6hn9d-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 16 Mar 2018 13:12:05 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 16 Mar 2018 17:12:03 -0000
Subject: Re: [PATCH] evm: check for remount ro in progress before writing
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Sascha Hauer <s.hauer@pengutronix.de>,
        linux-integrity@vger.kernel.org
Date: Fri, 16 Mar 2018 13:12:00 -0400
In-Reply-To: <20180301123845.26189-1-s.hauer@pengutronix.de>
References: <20180301123845.26189-1-s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1521220320.3503.57.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-03-01 at 13:38 +0100, Sascha Hauer wrote:
> EVM might update the evm xattr while the VFS performs a remount to
> readonly mode. This is not properly checked for, additionally check
> the s_readonly_remount superblock flag before writing.
> The bug can for example be observed with UBIFS. UBIFS checks the free
> space on the device before and after a remount. With EVM enabled the
> free space sometimes differs between both checks.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

I've modified the patch to use d_backing_inode() and fixed the
checkpatch over 80 character warning.  It's now applied.

thanks!

Mimi

> ---
>  security/integrity/evm/evm_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
> index a8d502827270..4a147a998aa7 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -185,6 +185,7 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
>  					iint->flags |= EVM_IMMUTABLE_DIGSIG;
>  				evm_status = INTEGRITY_PASS_IMMUTABLE;
>  			} else if (!IS_RDONLY(d_backing_inode(dentry)) &&
> +				   !(dentry->d_inode->i_sb->s_readonly_remount) &&
>  				   !IS_IMMUTABLE(d_backing_inode(dentry))) {
>  				evm_update_evmxattr(dentry, xattr_name,
>  						    xattr_value,
