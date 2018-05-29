Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32870 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S933697AbeE2Mbw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 May 2018 08:31:52 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4TCU0b7106400
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 08:31:52 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2j95nxkxam-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 29 May 2018 08:31:51 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Tue, 29 May 2018 13:31:50 +0100
Subject: Re: [PATCH] EVM: Fix null dereference on xattr when xattr fails to
 allocate
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Colin King <colin.king@canonical.com>
Cc: Matthew Garrett <mjg59@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 29 May 2018 08:31:32 -0400
In-Reply-To: <20180529090504.6dpdadjyjxo45nu2@mwanda>
References: <20180527225510.25612-1-colin.king@canonical.com>
         <20180529090504.6dpdadjyjxo45nu2@mwanda>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1527597092.10176.17.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Dan,

On Tue, 2018-05-29 at 12:05 +0300, Dan Carpenter wrote:
> Not really related to this patch except I was looking at the function:
> 
> security/integrity/evm/evm_secfs.c
>    191          ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_INTEGRITY_EVM_XATTR);
>    192          if (IS_ERR(ab))
>    193                  return PTR_ERR(ab);
>    194  
>    195          xattr = kmalloc(sizeof(struct xattr_list), GFP_KERNEL);
>    196          if (!xattr) {
>    197                  err = -ENOMEM;
>    198                  goto out;
>    199          }
>    200  
>    201          xattr->name = memdup_user_nul(buf, count);
>    202          if (IS_ERR(xattr->name)) {
>    203                  err = PTR_ERR(xattr->name);
>    204                  xattr->name = NULL;
>    205                  goto out;
>    206          }
>    207  
>    208          /* Remove any trailing newline */
>    209          len = strlen(xattr->name);
>    210          if (xattr->name[len-1] == '\n')
> 
> strlen() could be zero, leading to a read underflow here.

Thanks!  Could you modify the maximum xattr size check (before this
code snippet) to check for underflow?

Mimi


> 
>    211                  xattr->name[len-1] = '\0';
>    212  
>    213          if (strcmp(xattr->name, ".") == 0) {
>    214                  evm_xattrs_locked = 1;
>    215                  newattrs.ia_mode = S_IFREG | 0440;
>    216                  newattrs.ia_valid = ATTR_MODE;
>    217                  inode = evm_xattrs->d_inode;
>    218                  inode_lock(inode);
>    219                  err = simple_setattr(evm_xattrs, &newattrs);
>    220                  inode_unlock(inode);
>    221                  audit_log_format(ab, "locked");
>    222                  if (!err)
>    223                          err = count;
>    224                  goto out;
>    225          }
> 
> regards,
> dan carpenter
> 
