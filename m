Return-Path: <SRS0=hfSo=7Y=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6457C433DF
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Jun 2020 14:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B66C120848
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Jun 2020 14:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="c+j19m82"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgFKOLq (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Thu, 11 Jun 2020 10:11:46 -0400
Received: from linux.microsoft.com ([13.77.154.182]:42732 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726905AbgFKOLq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jun 2020 10:11:46 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5F4E220B4778;
        Thu, 11 Jun 2020 07:11:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F4E220B4778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1591884705;
        bh=tFg7+PQWet+jeOWbFZlNUp3UpCdozWSTl7SoKYhodpI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=c+j19m82+ookhEBumbsDCgRzHEjVfsTJ6mu2qUgguNW9cIjPtSq80aH8kruY+s3E+
         QuIQA5NB7kuOXUnejTeDWTZYREY2otaR5OD/SVgQqT40joCciTp3JQ3RK8tQlFrsjL
         PMLUOJIYNN8bVysrFfSnC5RVmB+RK9UKvwr/rwfE=
Subject: Re: [PATCH] ima: fix mprotect checking
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <1591874363-28939-1-git-send-email-zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <b9b75002-8c46-16c2-ba09-d7ff6b3d9889@linux.microsoft.com>
Date:   Thu, 11 Jun 2020 07:11:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591874363-28939-1-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/11/20 4:19 AM, Mimi Zohar wrote:

> Make sure IMA is enabled before checking mprotect change.  Addresses
> report of a 3.7% regression of boot-time.dhcp.
> 
> Fixes: 8eb613c0b8f1 ("ima: verify mprotect change is consistent with mmap policy")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>   security/integrity/ima/ima_main.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index 800fb3bba418..c1583d98c5e5 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -419,7 +419,8 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
>   	int pcr;
>   
>   	/* Is mprotect making an mmap'ed file executable? */
> -	if (!vma->vm_file || !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
> +	if (!(ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
> +	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
>   		return 0;
>   
>   	security_task_getsecid(current, &secid);
> 

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
