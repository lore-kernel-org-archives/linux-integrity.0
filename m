Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751271AbdJWUlE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Oct 2017 16:41:04 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9NKe6si057006
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2017 16:41:04 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dsq1yshqy-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2017 16:41:04 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Mon, 23 Oct 2017 21:41:01 +0100
Subject: Re: [RFC][PATCH 2/2] ima: don't measure files in the TCB if Biba
 strict policy is enforced
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Roberto Sassu <roberto.sassu@huawei.com>,
        linux-integrity@vger.kernel.org
Date: Mon, 23 Oct 2017 16:40:57 -0400
In-Reply-To: <20171020154138.23635-3-roberto.sassu@huawei.com>
References: <20171020154138.23635-1-roberto.sassu@huawei.com>
         <20171020154138.23635-3-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1508791257.3639.211.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2017-10-20 at 17:41 +0200, Roberto Sassu wrote:
> The Biba strict policy prevents processes outside the TCB from modifying
> appraised files. Then, since the integrity of those files is preserved,
> because only processes in the TCB can write appraised files, it is not
> necessary to measure them each time they are accessed by the TCB.

The builtin appraise_tcb appraises all files owned by root.  With this
patch you've redefined TCB to be any currently loaded IMA policy.

> This solves one of the main problems of binary attestation: when a
> modified file is accessed by the TCB, it was necessary to measure it
> because verifiers cannot determine from the measurement list if the
> writer belong or not to the TCB. Verifiers find an unknown digest
> and have to consider the whole system as compromised.
> 
> If the Biba strict policy has been selected, and appraisal is in enforce
> mode, IMA measures files at first access, if they have a digital signature.
> Then, for subsequent accesses, files are not measured again, unless the
> appraisal status changes.

Signed files aren't changing, so there should only be one file
measurement in the measurement list.  So this only affects mutable
files.  We're going through a lot of effort to re-measure mutable
files after they change.

> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima_main.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 6e85ea8e2373..16c2da0e32d9 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -200,10 +200,16 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>  			goto out;
>  	}
> 
> -	if (ima_integrity_policy)
> +	if (ima_integrity_policy) {
>  		policy_violation = ima_appraise_biba_check(file, iint,
>  						must_appraise, &pathbuf,
>  						&pathname, filename);
> +		/* do not measure mutable files, if they are appraised */
> +		if (ima_integrity_policy == BIBA_STRICT &&
> +		    (ima_appraise & IMA_APPRAISE_ENFORCE))
> +			if (iint && (iint->flags & IMA_APPRAISED))
> +				action &= ~IMA_MEASURE;
> +	}
>  	if (violation_check)
>  		ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
>  					 &pathbuf, &pathname);
> @@ -246,9 +252,16 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
>  	if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
>  		pathname = ima_d_path(&file->f_path, &pathbuf, filename);
> 
> -	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK))
> +	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
>  		rc = ima_appraise_measurement(func, iint, file, pathname,
>  					      xattr_value, xattr_len, opened);
> +		if (!rc && ima_integrity_policy == BIBA_STRICT &&
> +		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
> +			iint->flags &= ~IMA_MEASURE;
> +			if (!(iint->flags & IMA_DIGSIG))
> +				action &= ~IMA_MEASURE;
> +		}
> +	}
>  	if (action & IMA_MEASURE)
>  		ima_store_measurement(iint, file, pathname,
>  				      xattr_value, xattr_len, pcr);
