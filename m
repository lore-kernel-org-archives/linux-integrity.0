Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39570 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750996AbeCHUgV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Mar 2018 15:36:21 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w28KaKum141917
        for <linux-integrity@vger.kernel.org>; Thu, 8 Mar 2018 15:36:21 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gk8492yqx-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Mar 2018 15:36:20 -0500
Received: from localhost
        by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 8 Mar 2018 20:36:18 -0000
Subject: Re: [PATCH v2] ima: drop vla in ima_audit_measurement()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Tycho Andersen <tycho@tycho.ws>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Date: Thu, 08 Mar 2018 15:36:14 -0500
In-Reply-To: <20180308202347.31331-1-tycho@tycho.ws>
References: <20180308202347.31331-1-tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1520541374.3605.101.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-03-08 at 13:23 -0700, Tycho Andersen wrote:

>  /*
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 2cfb0c714967..356faae6f09c 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -288,8 +288,11 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>  					      xattr_value, xattr_len, opened);
>  		inode_unlock(inode);
>  	}
> -	if (action & IMA_AUDIT)
> -		ima_audit_measurement(iint, pathname);
> +	if (action & IMA_AUDIT) {
> +		rc = ima_audit_measurement(iint, pathname);
> +		if (rc < 0)
> +			goto out_locked;
> +	}
> 
>  	if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
>  		rc = 0;

Only when IMA-appraisal is enforcing file data integrity should
process_measurement() ever fail.  Other errors can be logged/audited.

Mimi
