Return-Path: <SRS0=mby7=SN=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA38AC10F11
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Apr 2019 00:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB43217D4
	for <linux-integrity@archiver.kernel.org>; Thu, 11 Apr 2019 00:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfDKA7y (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Wed, 10 Apr 2019 20:59:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58670 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726014AbfDKA7x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Apr 2019 20:59:53 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x3B0wQEi077973
        for <linux-integrity@vger.kernel.org>; Wed, 10 Apr 2019 20:59:52 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2rspus2kwg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 10 Apr 2019 20:59:52 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 11 Apr 2019 01:59:50 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Apr 2019 01:59:47 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x3B0xkhs55771214
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Apr 2019 00:59:46 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EBC6A4053;
        Thu, 11 Apr 2019 00:59:46 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3062CA404D;
        Thu, 11 Apr 2019 00:59:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.94.99])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Apr 2019 00:59:45 +0000 (GMT)
Subject: Re: [PATCH v2 1/3] ima: Call test's cleanup inside ima_setup.sh
 cleanup
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>, Fabian Vogt <FVogt@suse.com>,
        Marcus Meissner <meissner@suse.com>,
        linux-integrity@vger.kernel.org
Date:   Wed, 10 Apr 2019 20:59:34 -0400
In-Reply-To: <20190405165225.27216-2-pvorel@suse.cz>
References: <20190405165225.27216-1-pvorel@suse.cz>
         <20190405165225.27216-2-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19041100-0016-0000-0000-0000026D85FD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19041100-0017-0000-0000-000032C9B7EF
Message-Id: <1554944374.25614.25.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-11_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1904110005
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2019-04-05 at 18:52 +0200, Petr Vorel wrote:
> to work the same way as setup
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/security/integrity/ima/tests/ima_setup.sh  | 6 +++++-
>  .../kernel/security/integrity/ima/tests/ima_violations.sh   | 2 --
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 52551190a..cbded42c2 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -20,7 +20,8 @@
>  TST_TESTFUNC="test"
>  TST_SETUP_CALLER="$TST_SETUP"
>  TST_SETUP="ima_setup"
> -TST_CLEANUP="${TST_CLEANUP:-ima_cleanup}"
> +TST_CLEANUP_CALLER="$TST_CLEANUP"
> +TST_CLEANUP="ima_cleanup"

It seems to be working, but defining TST_SETUP and TST_CLEANUP after
defining the respective _CALLER looks strange.  The _CALLER's string
must be empty.

>  TST_NEEDS_TMPDIR=1
>  TST_NEEDS_ROOT=1
> 
> @@ -95,6 +96,9 @@ ima_setup()
>  ima_cleanup()
>  {
>  	local dir
> +
> +	[ -n "$TST_CLEANUP_CALLER" ] && $TST_CLEANUP_CALLER
> +

Is something else setting TST_CLEANUP_CALLER?

>  	for dir in $UMOUNT; do
>  		umount $dir
>  	done
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index 74223c221..a44bd1230 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -51,8 +51,6 @@ cleanup()
>  {
>  	[ "$PRINTK_RATE_LIMIT" != "0" ] && \
>  		sysctl -wq kernel.printk_ratelimit=$PRINTK_RATE_LIMIT
> -
> -	ima_cleanup
>  }
> 
>  open_file_read()

