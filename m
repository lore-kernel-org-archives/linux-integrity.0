Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from userp2120.oracle.com ([156.151.31.85]:46842 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932288AbeE2JFL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 May 2018 05:05:11 -0400
Date: Tue, 29 May 2018 12:05:04 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Colin King <colin.king@canonical.com>
Cc: Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EVM: Fix null dereference on xattr when xattr fails to
 allocate
Message-ID: <20180529090504.6dpdadjyjxo45nu2@mwanda>
References: <20180527225510.25612-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180527225510.25612-1-colin.king@canonical.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Not really related to this patch except I was looking at the function:

security/integrity/evm/evm_secfs.c
   191          ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_EVM_XATTR);
   192          if (IS_ERR(ab))
   193                  return PTR_ERR(ab);
   194  
   195          xattr = kmalloc(sizeof(struct xattr_list), GFP_KERNEL);
   196          if (!xattr) {
   197                  err = -ENOMEM;
   198                  goto out;
   199          }
   200  
   201          xattr->name = memdup_user_nul(buf, count);
   202          if (IS_ERR(xattr->name)) {
   203                  err = PTR_ERR(xattr->name);
   204                  xattr->name = NULL;
   205                  goto out;
   206          }
   207  
   208          /* Remove any trailing newline */
   209          len = strlen(xattr->name);
   210          if (xattr->name[len-1] == '\n')

strlen() could be zero, leading to a read underflow here.

   211                  xattr->name[len-1] = '\0';
   212  
   213          if (strcmp(xattr->name, ".") == 0) {
   214                  evm_xattrs_locked = 1;
   215                  newattrs.ia_mode = S_IFREG | 0440;
   216                  newattrs.ia_valid = ATTR_MODE;
   217                  inode = evm_xattrs->d_inode;
   218                  inode_lock(inode);
   219                  err = simple_setattr(evm_xattrs, &newattrs);
   220                  inode_unlock(inode);
   221                  audit_log_format(ab, "locked");
   222                  if (!err)
   223                          err = count;
   224                  goto out;
   225          }

regards,
dan carpenter
