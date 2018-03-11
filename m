Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932170AbeCKVwt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 11 Mar 2018 17:52:49 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2BLnDMj086806
        for <linux-integrity@vger.kernel.org>; Sun, 11 Mar 2018 17:52:49 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gmw6nws6y-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 11 Mar 2018 17:52:49 -0400
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 11 Mar 2018 21:52:47 -0000
Subject: Re: [PATCH] evm: check for remount ro in progress before writing
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Sascha Hauer <s.hauer@pengutronix.de>,
        linux-integrity@vger.kernel.org
Date: Sun, 11 Mar 2018 17:52:44 -0400
In-Reply-To: <20180301123845.26189-1-s.hauer@pengutronix.de>
References: <20180301123845.26189-1-s.hauer@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1520805164.3547.3.camel@linux.vnet.ibm.com>
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

The other 2 conditions are using d_back_inode().  Shouldn't this one
be too?

Mimi

>  				   !IS_IMMUTABLE(d_backing_inode(dentry))) {
>  				evm_update_evmxattr(dentry, xattr_name,
>  						    xattr_value,
