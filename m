Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44600 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751104AbdLASGj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Dec 2017 13:06:39 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB1I440m129225
        for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2017 13:06:39 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ek8p8kcvt-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2017 13:06:38 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 1 Dec 2017 18:06:36 -0000
Subject: Re: [RFC][PATCH v2 3/9] ima: preserve iint flags if security.ima
 update is successful
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Roberto Sassu <roberto.sassu@huawei.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, silviu.vlasceanu@huawei.com,
        "Safford, David (GE Global Research, US)" <david.safford@ge.com>
Date: Fri, 01 Dec 2017 13:06:31 -0500
In-Reply-To: <20171130105610.15761-4-roberto.sassu@huawei.com>
References: <20171130105610.15761-1-roberto.sassu@huawei.com>
         <20171130105610.15761-4-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1512151591.17800.60.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-11-30 at 11:56 +0100, Roberto Sassu wrote:
> During the last file close, IMA clears the flags in the IMA_DONE_MASK, to
> ensure that files are measured and audited after they have been modified.
> However, if security.ima is correctly updated, it wouldn't be necessary to
> clear also the appraisal flags, because in this case the appraisal status
> is valid.
> 
> This patch modifies ima_update_xattr() to return the result of the
> security.ima update. If the operation is done successfully,
> ima_check_last_writer() preserves the IMA_APPRAISED and
> IMA_APPRAISED_SUBMASK iint flags.

Yes, I know I've discussed this before.  This is a performance
improvement, but I'm not sure if we really want this.  There's been
discussion about re-evaluating the integrity of files periodically,
especially for systems that are infrequently rebooted.  There's also
the need to reset the cache flags when keys are black listed.  Then
there's the discussion of not trusting the cached integrity results
and re-evaluating the file's integrity each and every time.  This
would be based on a new policy option (eg. nocache).

Before changing this, I'd like hear what other people think.

thanks,

Mimi


> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima.h          |  6 +++---
>  security/integrity/ima/ima_appraise.c | 10 +++++-----
>  security/integrity/ima/ima_main.c     | 11 +++++++++--
>  3 files changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 0703a96072b5..2bdf10417125 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -241,7 +241,7 @@ int ima_appraise_measurement(enum ima_hooks func,
>  			     struct evm_ima_xattr_data *xattr_value,
>  			     int xattr_len, int opened);
>  int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func);
> -void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
> +int ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
>  enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
>  					   enum ima_hooks func);
>  enum hash_algo ima_get_hash_algo(struct evm_ima_xattr_data *xattr_value,
> @@ -266,8 +266,8 @@ static inline int ima_must_appraise(struct inode *inode, int mask,
>  	return 0;
>  }
> 
> -static inline void ima_update_xattr(struct integrity_iint_cache *iint,
> -				    struct file *file)
> +static inline int ima_update_xattr(struct integrity_iint_cache *iint,
> +				   struct file *file)
>  {
>  }
> 
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
> index a54ad18affb1..23e025e86aed 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -319,23 +319,23 @@ int ima_appraise_measurement(enum ima_hooks func,
>  /*
>   * ima_update_xattr - update 'security.ima' hash value
>   */
> -void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
> +int ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
>  {
>  	struct dentry *dentry = file_dentry(file);
>  	int rc = 0;
> 
>  	/* do not collect and update hash for digital signatures */
>  	if (iint->flags & IMA_DIGSIG)
> -		return;
> +		return -EPERM;
> 
>  	if (iint->ima_file_status != INTEGRITY_PASS)
> -		return;
> +		return -EPERM;
> 
>  	rc = ima_collect_measurement(iint, file, NULL, 0, ima_hash_algo);
>  	if (rc < 0)
> -		return;
> +		return rc;
> 
> -	ima_fix_xattr(dentry, iint);
> +	return ima_fix_xattr(dentry, iint);
>  }
> 
>  /**
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 5a7321bc325c..fb144177a783 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -121,6 +121,8 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
>  				  struct inode *inode, struct file *file)
>  {
>  	fmode_t mode = file->f_mode;
> +	u64 appraise_flags;
> +	int rc;
> 
>  	if (!(mode & FMODE_WRITE))
>  		return;
> @@ -129,10 +131,15 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
>  	if (atomic_read(&inode->i_writecount) == 1) {
>  		if ((iint->version != inode->i_version) ||
>  		    (iint->flags & IMA_NEW_FILE)) {
> +			appraise_flags = iint->flags & (IMA_APPRAISED |
> +							IMA_APPRAISED_SUBMASK);
>  			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
>  			iint->measured_pcrs = 0;
> -			if (iint->flags & IMA_APPRAISE)
> -				ima_update_xattr(iint, file);
> +			if (iint->flags & IMA_APPRAISE) {
> +				rc = ima_update_xattr(iint, file);
> +				if (!rc)
> +					iint->flags |= appraise_flags;
> +			}
>  		}
>  	}
>  	inode_unlock(inode);
