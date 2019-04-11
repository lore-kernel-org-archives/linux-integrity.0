Return-Path: <SRS0=mby7=SN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06362C10F13
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Apr 2019 13:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F312133D
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Apr 2019 13:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfDKNDY (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 11 Apr 2019 09:03:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45724 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbfDKNDY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Apr 2019 09:03:24 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3BCtM7v140262
        for <linux-integrity@vger.kernel.org>; Thu, 11 Apr 2019 09:03:23 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rt5s6hdh6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 11 Apr 2019 09:03:22 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 11 Apr 2019 14:03:19 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 14:03:16 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3BD3FVF52887780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 13:03:15 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A11AE11C050;
        Thu, 11 Apr 2019 13:03:15 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DDE411C05C;
        Thu, 11 Apr 2019 13:03:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.94.197])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Apr 2019 13:03:14 +0000 (GMT)
Subject: Re: [PATCH] integrity: make 'sync' update the inode integrity state
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Janne Karhunen <janne.karhunen@gmail.com>,
        linux-integrity@vger.kernel.org
Date:   Thu, 11 Apr 2019 09:03:04 -0400
In-Reply-To: <20190410145659.26347-1-janne.karhunen@gmail.com>
References: <20190410145659.26347-1-janne.karhunen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041113-0008-0000-0000-000002D8BF42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041113-0009-0000-0000-00002244E72F
Message-Id: <1554987784.7843.40.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-11_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904110090
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Janne,

I need to finish up a couple of other things before vacation.  Below
are just a few comments/questions for you to think about.

On Wed, 2019-04-10 at 17:56 +0300, Janne Karhunen wrote:

> +/**
> + * ima_file_update - called from sync to update xattrs
> + * @file: pointer to file structure being updated
> + */
> +void ima_file_update(struct file *file)
> +{
> +	struct inode *inode = file_inode(file);
> +	struct integrity_iint_cache *iint;
> +
> +	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
> +		return;
> +
> +	iint = integrity_iint_find(inode);
> +	if (!iint)
> +		return;
> +
> +	mutex_lock(&iint->mutex);
> +	if (atomic_read(&inode->i_writecount) == 1) {

This test limits the number of opened writers.  Only if there is a
single writer opened, will the xattr be updated.  Is this what you
intended?

Your testing should open the same file for write multiple times.

> +		clear_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
> +		if (!IS_I_VERSION(inode) ||
> +		    !inode_eq_iversion(inode, iint->version)) {
> +			iint->flags &= ~IMA_COLLECTED;
> +			ima_update_xattr(iint, file);

Relatively recently there were some changes to iversion so that it
isn't being updated as frequently.  Can we use i_version here?

> +		}
> +	}
> +	mutex_unlock(&iint->mutex);
> +}
> +EXPORT_SYMBOL_GPL(ima_file_update);
> +
>  /**
>   * ima_path_check - based on policy, collect/store measurement.
>   * @file: pointer to the file to be measured
> diff --git a/security/security.c b/security/security.c
> index 23cbb1a295a3..6a0980a1df22 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1451,6 +1451,11 @@ int security_file_open(struct file *file)
>  	return fsnotify_perm(file, MAY_OPEN);
>  }
>  
> +void security_file_sync(struct file *file)
> +{
> +	ima_file_update(file);
> +}
> +

Either this is an LSM hook or it isn't.  If it's an LSM hook it needs
to be similar to the existing hooks.  If it's an IMA hook, like
ima_file_check() or ima_file_free(), then call it directly.

Normally the function name is related to the LSM hook name.  For
example, I would name it ima_file_sync.

Mimi

>  int security_task_alloc(struct task_struct *task, unsigned long clone_flags)
>  {
>  	int rc = lsm_task_alloc(task);

