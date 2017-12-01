Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751162AbdLARiM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Dec 2017 12:38:12 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB1HZrgV097044
        for <linux-integrity@vger.kernel.org>; Fri, 1 Dec 2017 12:38:12 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ek86kuwh1-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 01 Dec 2017 12:38:11 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Fri, 1 Dec 2017 17:38:09 -0000
Subject: Re: [RFC][PATCH v2 1/9] ima: pass filename to
 ima_rdwr_violation_check()
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Roberto Sassu <roberto.sassu@huawei.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, silviu.vlasceanu@huawei.com
Date: Fri, 01 Dec 2017 12:38:05 -0500
In-Reply-To: <20171130105610.15761-2-roberto.sassu@huawei.com>
References: <20171130105610.15761-1-roberto.sassu@huawei.com>
         <20171130105610.15761-2-roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1512149885.17800.44.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2017-11-30 at 11:56 +0100, Roberto Sassu wrote:
> ima_rdwr_violation_check() retrieves the full path of a measured file by
> calling ima_d_path(). If process_measurement() calls this function, it
> reuses the pointer and passes it to the functions to measure/appraise/audit
> an accessed file.
> 
> After commit bc15ed663e7e ("ima: fix ima_d_path() possible race with
> rename"), ima_d_path() first tries to retrieve the full path by calling
> d_absolute_path() and, if there is an error, copies the dentry name to the
> buffer passed as argument.
> 
> However, ima_rdwr_violation_check() passes to ima_d_path() the pointer of a
> local variable. process_measurement() might be reusing the pointer to an
> area in the stack which may have been already overwritten after
> ima_rdwr_violation_check() returned.
> 
> Correct this issue by passing to ima_rdwr_violation_check() the pointer of
> a buffer declared in process_measurement().
> 
> Fixes: bc15ed663e7e ("ima: fix ima_d_path() possible race with rename")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks!

> ---
>  security/integrity/ima/ima_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 294b2fe69334..5a7321bc325c 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -84,10 +84,10 @@ static void ima_rdwr_violation_check(struct file *file,
>  				     struct integrity_iint_cache *iint,
>  				     int must_measure,
>  				     char **pathbuf,
> -				     const char **pathname)
> +				     const char **pathname,
> +				     char *filename)
>  {
>  	struct inode *inode = file_inode(file);
> -	char filename[NAME_MAX];
>  	fmode_t mode = file->f_mode;
>  	bool send_tomtou = false, send_writers = false;
> 
> @@ -205,7 +205,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
> 
>  	if (violation_check) {
>  		ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
> -					 &pathbuf, &pathname);
> +					 &pathbuf, &pathname, filename);
>  		if (!action) {
>  			rc = 0;
>  			goto out_free;
