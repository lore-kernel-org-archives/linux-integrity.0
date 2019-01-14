Return-Path: <SRS0=QOPP=PW=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B2FC43387
	for <linux-integrity@archiver.kernel.org>; Mon, 14 Jan 2019 21:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9B2214AE
	for <linux-integrity@archiver.kernel.org>; Mon, 14 Jan 2019 21:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfANVJe (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:09:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32848 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726788AbfANVJd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Jan 2019 16:09:33 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x0EKxbBF028850
        for <linux-integrity@vger.kernel.org>; Mon, 14 Jan 2019 16:09:32 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2q0xh40kcu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 14 Jan 2019 16:09:32 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 14 Jan 2019 21:09:30 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 14 Jan 2019 21:09:27 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0EL9Q0R45023460
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Jan 2019 21:09:26 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C11FAAE04D;
        Mon, 14 Jan 2019 21:09:26 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A41CAE045;
        Mon, 14 Jan 2019 21:09:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.106.167])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jan 2019 21:09:25 +0000 (GMT)
Subject: Re: [PATCH 4/6] ima: Code cleanup
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>, zohar@linux.vnet.ibm.com,
        pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it
Date:   Mon, 14 Jan 2019 16:09:15 -0500
In-Reply-To: <1546827989-43569-5-git-send-email-zhang.jia@linux.alibaba.com>
References: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
         <1546827989-43569-5-git-send-email-zhang.jia@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19011421-0012-0000-0000-000002E7FD0D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19011421-0013-0000-0000-0000211F0EC2
Message-Id: <1547500155.4156.204.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-14_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901140162
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-01-07 at 10:26 +0800, Jia Zhang wrote:
> - Don't use the legacy policy function name in policy files.

The name change is from PATH_CHECK to FILE_CHECK, nothing to do with
"policy".

> - Use the variable IMA_POLICY instead of hard code path.
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>

After removing the word "policy" above,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  testcases/kernel/security/integrity/ima/policy/measure.policy         | 2 +-
>  testcases/kernel/security/integrity/ima/policy/measure.policy-invalid | 2 +-
>  testcases/kernel/security/integrity/ima/tests/ima_policy.sh           | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/policy/measure.policy b/testcases/kernel/security/integrity/ima/policy/measure.policy
> index c68e722..9976ddf 100644
> --- a/testcases/kernel/security/integrity/ima/policy/measure.policy
> +++ b/testcases/kernel/security/integrity/ima/policy/measure.policy
> @@ -13,4 +13,4 @@ dont_measure fsmagic=0x01021994
>  dont_measure fsmagic=0x73636673
>  measure func=FILE_MMAP mask=MAY_EXEC
>  measure func=BPRM_CHECK mask=MAY_EXEC
> -measure func=PATH_CHECK mask=MAY_READ uid=0
> +measure func=FILE_CHECK mask=MAY_READ uid=0
> diff --git a/testcases/kernel/security/integrity/ima/policy/measure.policy-invalid b/testcases/kernel/security/integrity/ima/policy/measure.policy-invalid
> index e406757..04dff89 100644
> --- a/testcases/kernel/security/integrity/ima/policy/measure.policy-invalid
> +++ b/testcases/kernel/security/integrity/ima/policy/measure.policy-invalid
> @@ -13,4 +13,4 @@ dont_measure fsmagic=0x01021994
>  dnt_measure fsmagic=0x73636673
>  measure func=FILE_MMAP mask=MAY_EXEC
>  measure func=BPRM_CHECK mask=MAY_EXEC
> -measure func=PATH_CHECK mask=MAY_READ uid=0
> +measure func=FILE_CHECK mask=MAY_READ uid=0
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> index 64aa8cb..a0c7869 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> @@ -28,7 +28,7 @@ check_policy_writable()
>  {
>  	local err="IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
> 
> -	[ -f /sys/kernel/security/ima/policy ] || tst_brk TCONF "$err"
> +	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
>  	# CONFIG_IMA_READ_POLICY
>  	echo "" 2> log > $IMA_POLICY
>  	grep -q "Device or resource busy" log && tst_brk TCONF "$err"

