Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35990 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751859AbeEMQlq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 May 2018 12:41:46 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4DGd1On042633
        for <linux-integrity@vger.kernel.org>; Sun, 13 May 2018 12:41:46 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hxdnmaeeg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 13 May 2018 12:41:46 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Sun, 13 May 2018 17:41:43 +0100
Subject: Re: [PATCH V5 3/3] EVM: Allow runtime modification of the set of
 verified xattrs
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Matthew Garrett <mjg59@google.com>, linux-integrity@vger.kernel.org
Date: Sun, 13 May 2018 12:41:40 -0400
In-Reply-To: <20180511231236.5501-3-mjg59@google.com>
References: <20180511231236.5501-1-mjg59@google.com>
         <20180511231236.5501-3-mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1526229700.3898.26.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-05-11 at 16:12 -0700, Matthew Garrett wrote:
> Sites may wish to provide additional metadata alongside files in order
> to make more fine-grained security decisions[1]. The security of this is
> enhanced if this metadata is protected, something that EVM makes
> possible. However, the kernel cannot know about the set of extended
> attributes that local admins may wish to protect, and hardcoding this
> policy in the kernel makes it difficult to change over time and less
> convenient for distributions to enable.
> 
> This patch adds a new /sys/kernel/security/evm_xattrs node, which can be
> read to obtain the current set of EVM-protected extended attributes or
> written to in order to add new entries. Extending this list will not
> change the validity of any existing signatures provided that the file
> in question does not have any of the additional extended attributes -
> missing xattrs are skipped when calculating the EVM hash.

The new pathname introduced in the new patch needs to be propagated
 to the patch description, Documentation and Kconfig in this patch.
> 
> [1] For instance, a package manager could install information about the
> package uploader in an additional extended attribute. Local LSM policy
> could then be associated with that extended attribute in order to
> restrict the privileges available to packages from less trusted
> uploaders.
> 
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> ---
> 
> I think this covers the review comments.

Yes, it looks good.  The pathname changes introduced in the new patch,
need to be propagated to the patch description, above, Documentation,
and Kconfig.  The only other change is that with the introduction of
requiring the xattr names to be prefixed with "security", locking the
xattr names list fails.  After making these tw changes, there's no
need to re-post the entire patch set.  Please re-post just this one.

>  Documentation/ABI/testing/evm       |  13 +++
>  include/uapi/linux/audit.h          |   1 +
>  security/integrity/evm/Kconfig      |  11 ++
>  security/integrity/evm/evm_crypto.c |   2 +-
>  security/integrity/evm/evm_main.c   |   6 +-
>  security/integrity/evm/evm_secfs.c  | 173 ++++++++++++++++++++++++++++
>  6 files changed, 202 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/evm b/Documentation/ABI/testing/evm
> index d12cb2eae9ee..fa31df7fd30b 100644
> --- a/Documentation/ABI/testing/evm
> +++ b/Documentation/ABI/testing/evm
> @@ -57,3 +57,16 @@ Description:
>  		dracut (via 97masterkey and 98integrity) and systemd (via
>  		core/ima-setup) have support for loading keys at boot
>  		time.
> +
> +What:		security/evm_xattrs

Update

> +Date:		April 2018
> +Contact:	Matthew Garrett <mjg59@google.com>
> +Description:
> +		Shows the set of extended attributes used to calculate or
> +		validate the EVM signature, and allows additional attributes
> +		to be added at runtime. Any signatures generated after
> +		additional attributes are added (and on files posessing those
> +		additional attributes) will only be valid if the same
> +		additional attributes are configured on system boot. Writing
> +		a single period (.) will lock the xattr list from any further
> +		modification.

Writing '.', doesn't match the code.


> +config EVM_ADD_XATTRS
> +	bool "Add additional EVM extended attributes at runtime"
> +	depends on EVM
> +	default n
> +	help
> +	  Allow userland to provide additional xattrs for HMAC calculation.
> +
> +	  When this option is enabled, root can add additional xattrs to the
> +	  list used by EVM by writing them into
> +	  /sys/kernel/security/evm_xattrs.

Update


> +
> +	if (strcmp(xattr->name, ".") == 0) {
> +		evm_xattrs_locked = 1;
> +		inode = evm_xattrs->d_inode;
> +		inode_lock(inode);
> +		newattrs.ia_mode = S_IFREG | 0440;
> +		newattrs.ia_valid = ATTR_MODE;
> +		err = notify_change(evm_xattrs, &newattrs, NULL);
> +		inode_unlock(inode);
> +		audit_log_format(ab, "locked");
> +		if (!err)
> +			err = count;
> +		goto out;
> +	}
> +
> +	audit_log_format(ab, "xattr=");
> +	audit_log_untrustedstring(ab, xattr->name);
> +
> +	if (strncmp(xattr->name, XATTR_SECURITY_PREFIX,
> +		    XATTR_SECURITY_PREFIX_LEN) != 0) {
> +		err = -EINVAL;
> +		goto out;
> +	}

This test now prevents locking the xattr names list.  Making this an
else clause will fix it.

thanks,

Mimi
