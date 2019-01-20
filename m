Return-Path: <SRS0=Jbst=P4=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BB9C26641
	for <linux-integrity@archiver.kernel.org>; Sun, 20 Jan 2019 18:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66C32084F
	for <linux-integrity@archiver.kernel.org>; Sun, 20 Jan 2019 18:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfATSjN (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Sun, 20 Jan 2019 13:39:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53082 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726541AbfATSjN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Jan 2019 13:39:13 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0KIcaD6037075
        for <linux-integrity@vger.kernel.org>; Sun, 20 Jan 2019 13:39:12 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q4hqcc3cp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 20 Jan 2019 13:39:11 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 20 Jan 2019 18:39:09 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 20 Jan 2019 18:39:07 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0KId66S1901034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 20 Jan 2019 18:39:06 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 673905204F;
        Sun, 20 Jan 2019 18:39:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.91.65])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BF3B75204E;
        Sun, 20 Jan 2019 18:39:05 +0000 (GMT)
Subject: Re: [PATCH v3 6/6] ima/ima_violations: Temporarily remove the
 printk rate limit
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Jia Zhang <zhang.jia@linux.alibaba.com>, pvorel@suse.cz
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it
Date:   Sun, 20 Jan 2019 13:38:54 -0500
In-Reply-To: <1547607461-11233-7-git-send-email-zhang.jia@linux.alibaba.com>
References: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
         <1547607461-11233-7-git-send-email-zhang.jia@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19012018-4275-0000-0000-00000301B9E8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012018-4276-0000-0000-0000380FE4D5
Message-Id: <1548009534.3982.216.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-20_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901200152
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-01-16 at 10:57 +0800, Jia Zhang wrote:
> The output frequency of audit log is limited by printk_ratelimit()
> in kernel if auditd not used. Thus, the test cases heavily depending
> on searching certain keywords in log file may fail if the matching
> patterns are exactly suppressed by printk_ratelimit().
> 
> In order to fix such a sort of failure, just temporarily remove the
> printk rate limit, and restore its original setting when doing
> cleanup.
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>

Thanks, I wasn't aware of the sysctl.  If the message isn't in
/var/log/messages or /var/log/audit/audit.log, do we now need to also
check journalctl?

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  .../kernel/security/integrity/ima/tests/ima_setup.sh      |  2 +-
>  .../kernel/security/integrity/ima/tests/ima_violations.sh | 15 +++++++++++++++
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 6dfb4d2..fe60981 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -20,7 +20,7 @@
>  TST_TESTFUNC="test"
>  TST_SETUP_CALLER="$TST_SETUP"
>  TST_SETUP="ima_setup"
> -TST_CLEANUP="ima_cleanup"
> +TST_CLEANUP="${TST_CLEANUP:-ima_cleanup}"
>  TST_NEEDS_TMPDIR=1
>  TST_NEEDS_ROOT=1
>  
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> index f3f40d4..74223c2 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
> @@ -20,6 +20,7 @@
>  # Test whether ToMToU and open_writer violations invalidatethe PCR and are logged.
>  
>  TST_SETUP="setup"
> +TST_CLEANUP="cleanup"
>  TST_CNT=3
>  TST_NEEDS_DEVICE=1
>  
> @@ -31,15 +32,29 @@ setup()
>  	FILE="test.txt"
>  	IMA_VIOLATIONS="$SECURITYFS/ima/violations"
>  	LOG="/var/log/messages"
> +	PRINTK_RATE_LIMIT="0"
>  
>  	if status_daemon auditd; then
>  		LOG="/var/log/audit/audit.log"
> +	else
> +		tst_check_cmds sysctl
> +
> +		PRINTK_RATE_LIMIT=`sysctl -n kernel.printk_ratelimit`
> +		sysctl -wq kernel.printk_ratelimit=0
>  	fi
>  	[ -f "$LOG" ] || \
>  		tst_brk TBROK "log $LOG does not exist (bug in detection?)"
>  	tst_res TINFO "using log $LOG"
>  }
>  
> +cleanup()
> +{
> +	[ "$PRINTK_RATE_LIMIT" != "0" ] && \
> +		sysctl -wq kernel.printk_ratelimit=$PRINTK_RATE_LIMIT
> +
> +	ima_cleanup
> +}
> +
>  open_file_read()
>  {
>  	exec 3< $FILE || exit 1

