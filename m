Return-Path: <SRS0=ry+W=PP=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D17C43387
	for <linux-integrity@archiver.kernel.org>; Mon,  7 Jan 2019 16:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B976C2087F
	for <linux-integrity@archiver.kernel.org>; Mon,  7 Jan 2019 16:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfAGQBw (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:01:52 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:46759 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727049AbfAGQBw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Jan 2019 11:01:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01451;MF=zhang.jia@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0THjoY3l_1546876762;
Received: from ali-6c96cfd98fb5.local(mailfrom:zhang.jia@linux.alibaba.com fp:SMTPD_---0THjoY3l_1546876762)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Jan 2019 23:59:23 +0800
Subject: Re: [PATCH 6/6] ima: Use ima tcb policy files for test
To:     zohar@linux.vnet.ibm.com, pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it
References: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1546827989-43569-7-git-send-email-zhang.jia@linux.alibaba.com>
From:   Jia Zhang <zhang.jia@linux.alibaba.com>
Message-ID: <af3c44cd-2296-97e2-573e-b80da216738d@linux.alibaba.com>
Date:   Mon, 7 Jan 2019 23:59:23 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1546827989-43569-7-git-send-email-zhang.jia@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2019/1/7 上午10:26, Jia Zhang wrote:
> In order to make all tests running smoothly, the policy files should
> keep up ith the default ima tcb policy. Especially ima_violations.sh
> expects to have a func=FILE_CHECK with mask=MAY_WRITE to trigger open

Oops ... This is not true. mask=MAY_READ is already working well for
open writer and ToMToU violations. So please drop this patch.

Jia

> writer and ToMtoU violations. Unfortunately, if ima_policy.sh
> which would change the system IMA policy ran before ima_violations.sh,
> ima_violations.sh would fail for sure because its prerequisite is broken.
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> ---
>  .../security/integrity/ima/datafiles/measure.policy     | 17 +++++++++++++++--
>  .../integrity/ima/datafiles/measure.policy-invalid      | 17 +++++++++++++++--
>  2 files changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/measure.policy b/testcases/kernel/security/integrity/ima/datafiles/measure.policy
> index 9976ddf..546267c 100644
> --- a/testcases/kernel/security/integrity/ima/datafiles/measure.policy
> +++ b/testcases/kernel/security/integrity/ima/datafiles/measure.policy
> @@ -11,6 +11,19 @@ dont_measure fsmagic=0x64626720
>  dont_measure fsmagic=0x01021994
>  # SECURITYFS_MAGIC
>  dont_measure fsmagic=0x73636673
> -measure func=FILE_MMAP mask=MAY_EXEC
> +# DEVPTS_SUPER_MAGIC
> +dont_measure fsmagic=0x1cd1
> +# BINFMTFS_MAGIC
> +dont_measure fsmagic=0x42494e4d
> +# SELINUX_MAGIC
> +dont_measure fsmagic=0xf97cff8c
> +# CGROUP_SUPER_MAGIC
> +dont_measure fsmagic=0x27e0eb
> +# NSFS_MAGIC
> +dont_measure fsmagic=0x6e736673
> +measure func=MMAP_CHECK mask=MAY_EXEC
>  measure func=BPRM_CHECK mask=MAY_EXEC
> -measure func=FILE_CHECK mask=MAY_READ uid=0
> +measure func=FILE_CHECK euid=0
> +measure func=FILE_CHECK uid=0
> +measure func=MODULE_CHECK
> +measure func=FIRMWARE_CHECK
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid b/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid
> index 04dff89..bc72d0c 100644
> --- a/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid
> +++ b/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid
> @@ -11,6 +11,19 @@ dont_measure fsmagic=0x64626720
>  dont_measure fsmagic=0x01021994
>  # SECURITYFS_MAGIC
>  dnt_measure fsmagic=0x73636673
> -measure func=FILE_MMAP mask=MAY_EXEC
> +# DEVPTS_SUPER_MAGIC
> +dont_measure fsmagic=0x1cd1
> +# BINFMTFS_MAGIC
> +dont_measure fsmagic=0x42494e4d
> +# SELINUX_MAGIC
> +dont_measure fsmagic=0xf97cff8c
> +# CGROUP_SUPER_MAGIC
> +dont_measure fsmagic=0x27e0eb
> +# NSFS_MAGIC
> +dont_measure fsmagic=0x6e736673
> +measure func=MMAP_CHECK mask=MAY_EXEC
>  measure func=BPRM_CHECK mask=MAY_EXEC
> -measure func=FILE_CHECK mask=MAY_READ uid=0
> +measure func=FILE_CHECK euid=0
> +measure func=FILE_CHECK uid=0
> +measure func=MODULE_CHECK
> +measure func=FIRMWARE_CHECK
> 
