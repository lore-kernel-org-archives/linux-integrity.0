Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752832AbeEGVAa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 May 2018 17:00:30 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w47KxRZv063425
        for <linux-integrity@vger.kernel.org>; Mon, 7 May 2018 17:00:30 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2htsvcbqr8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 07 May 2018 17:00:29 -0400
Received: from localhost
        by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 7 May 2018 22:00:27 +0100
Subject: Re: [PATCH] ima: Reflect correct permissions for policy
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Date: Mon, 07 May 2018 17:00:24 -0400
In-Reply-To: <20180420132857.31332-1-pvorel@suse.cz>
References: <20180420132857.31332-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1525726824.3551.13.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-04-20 at 15:28 +0200, Petr Vorel wrote:
> Kernel configured as CONFIG_IMA_READ_POLICY=y && CONFIG_IMA_WRITE_POLICY=n
> keeps 0600 mode after loading policy. Remove write permission to state
> that policy file no longer be written.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Queued in the next-integrity branch.

thanks,

Mimi
> ---
>  security/integrity/ima/ima_fs.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
> index fa540c0469da..c1265127d1b6 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -434,6 +434,8 @@ static int ima_release_policy(struct inode *inode, struct file *file)
>  	ima_policy = NULL;
>  #elif defined(CONFIG_IMA_WRITE_POLICY)
>  	clear_bit(IMA_FS_BUSY, &ima_fs_flags);
> +#elif defined(CONFIG_IMA_READ_POLICY)
> +	inode->i_mode &= ~S_IWUSR;
>  #endif
>  	return 0;
>  }
