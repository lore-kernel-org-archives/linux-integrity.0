Return-Path: <SRS0=QOPP=PW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF60C43387
	for <linux-integrity@archiver.kernel.org>; Mon, 14 Jan 2019 19:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D21AB206B7
	for <linux-integrity@archiver.kernel.org>; Mon, 14 Jan 2019 19:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfANTcm (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 14 Jan 2019 14:32:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726728AbfANTcm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jan 2019 14:32:42 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0EJOOAs021166
        for <linux-integrity@vger.kernel.org>; Mon, 14 Jan 2019 14:32:41 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q0xjjw9uw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 14 Jan 2019 14:32:40 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 14 Jan 2019 19:32:38 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Jan 2019 19:32:35 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0EJWYmP60817656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 19:32:34 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 112E15204F;
        Mon, 14 Jan 2019 19:32:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.167])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 47F4E5204E;
        Mon, 14 Jan 2019 19:32:33 +0000 (GMT)
Subject: Re: [PATCH 6/6] ima: Use ima tcb policy files for test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>, zohar@linux.vnet.ibm.com,
        pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it
Date:   Mon, 14 Jan 2019 14:32:22 -0500
In-Reply-To: <1546827989-43569-7-git-send-email-zhang.jia@linux.alibaba.com>
References: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
         <1546827989-43569-7-git-send-email-zhang.jia@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19011419-0008-0000-0000-000002B0FB1A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011419-0009-0000-0000-0000221D0CCE
Message-Id: <1547494342.4156.188.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901140150
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-01-07 at 10:26 +0800, Jia Zhang wrote:
> In order to make all tests running smoothly, the policy files should
> keep up with the default ima tcb policy.

Keeping the policy rules in sync is a good idea, but some of the rules
might cause a regression with older kernels (eg. NSFS magic).  Not
including the rule, also poses a problem.

The kernel headers package includes magic.h.  One solution would be to check whether a magic name is included in magic.h.

> Especially ima_violations.sh
> expects to have a func=FILE_CHECK with mask=MAY_WRITE to trigger open
> writer and ToMtoU violations. Unfortunately, if ima_policy.sh
> which would change the system IMA policy ran before ima_violations.sh,
> ima_violations.sh would fail for sure because its prerequisite is broken.

We're not really interested in measuring files that are opened for
write.  They're changing.  The violation checking is independent of
having a measurement write rule.  Look at the
kernel ima_rdwr_violation_check().

Mimi

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

