Return-Path: <SRS0=1iot=RN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2450FC43381
	for <linux-integrity@archiver.kernel.org>; Sun, 10 Mar 2019 17:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE38F20657
	for <linux-integrity@archiver.kernel.org>; Sun, 10 Mar 2019 17:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbfCJRsZ (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 10 Mar 2019 13:48:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726505AbfCJRsZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Mar 2019 13:48:25 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2AHhdCn039837
        for <linux-integrity@vger.kernel.org>; Sun, 10 Mar 2019 13:48:24 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2r4uthgp05-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 10 Mar 2019 13:48:23 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 10 Mar 2019 17:48:22 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 10 Mar 2019 17:48:19 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2AHmIqR32768066
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 Mar 2019 17:48:18 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0954A4054;
        Sun, 10 Mar 2019 17:48:18 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0C3DA405B;
        Sun, 10 Mar 2019 17:48:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.93.199])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 Mar 2019 17:48:17 +0000 (GMT)
Subject: Re: [PATCH] selftests/ima: Add missing '=y' to config options
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-kselftest@vger.kernel.org, shuah <shuah@kernel.org>
Date:   Sun, 10 Mar 2019 13:48:07 -0400
In-Reply-To: <20190228233030.10480-1-pvorel@suse.cz>
References: <20190228233030.10480-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19031017-4275-0000-0000-00000319586E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19031017-4276-0000-0000-00003827BA59
Message-Id: <1552240087.5062.9.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-10_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903100138
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-03-01 at 00:30 +0100, Petr Vorel wrote:
> so the file can be used as kernel config snippet.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Thanks!  The tests now read the kernel config.  Removing
"CONFIG_KEXEC_VERIFY_SIG" permits testing with/without it configured.

Mimi

> ---
>  tools/testing/selftests/ima/config | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/ima/config b/tools/testing/selftests/ima/config
> index 6bc86d4d9bb4..9b968cd55199 100644
> --- a/tools/testing/selftests/ima/config
> +++ b/tools/testing/selftests/ima/config
> @@ -1,4 +1,4 @@
> -CONFIG_IMA_APPRAISE
> -CONFIG_IMA_ARCH_POLICY
> -CONFIG_SECURITYFS
> -CONFIG_KEXEC_VERIFY_SIG
> +CONFIG_IMA_APPRAISE=y
> +CONFIG_IMA_ARCH_POLICY=y
> +CONFIG_SECURITYFS=y
> +CONFIG_KEXEC_VERIFY_SIG=y

