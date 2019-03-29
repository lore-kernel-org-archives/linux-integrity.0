Return-Path: <SRS0=7fxW=SA=vger.kernel.org=linux-integrity-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A037C10F05
	for <linux-integrity@archiver.kernel.org>; Fri, 29 Mar 2019 10:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6221D2183F
	for <linux-integrity@archiver.kernel.org>; Fri, 29 Mar 2019 10:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfC2KuH (ORCPT
        <rfc822;linux-integrity@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:50:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51740 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729090AbfC2KuG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 29 Mar 2019 06:50:06 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2TAmaF5089756
        for <linux-integrity@vger.kernel.org>; Fri, 29 Mar 2019 06:50:05 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2rhg7recex-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 29 Mar 2019 06:50:04 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 29 Mar 2019 10:50:02 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 29 Mar 2019 10:50:00 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x2TAnxXP46465078
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Mar 2019 10:49:59 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2598E4C040;
        Fri, 29 Mar 2019 10:49:59 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 010C14C044;
        Fri, 29 Mar 2019 10:49:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.109.148])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 29 Mar 2019 10:49:57 +0000 (GMT)
Subject: Re: [PATCH 3/3] ima: Add overlay test
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>, Fabian Vogt <FVogt@suse.com>,
        Weihua Du <WHDu@suse.com>, linux-integrity@vger.kernel.org
Date:   Fri, 29 Mar 2019 06:49:47 -0400
In-Reply-To: <20190327161638.7407-4-pvorel@suse.cz>
References: <20190327161638.7407-1-pvorel@suse.cz>
         <20190327161638.7407-4-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19032910-0016-0000-0000-00000268CC8A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19032910-0017-0000-0000-000032C415A9
Message-Id: <1553856587.9420.44.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1903290079
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Wed, 2019-03-27 at 17:16 +0100, Petr Vorel wrote:

> +setup()
> +{
> +	lower="$TST_MNTPOINT/lower"
> +	upper="$TST_MNTPOINT/upper"
> +	work="$TST_MNTPOINT/work"
> +	merged="$TST_MNTPOINT/merged"
> +	mkdir -p $lower $upper $work $merged
> +
> +	device_backup="$TST_DEVICE"
> +	TST_DEVICE="overlay"
> +
> +	fs_type_backup="$TST_FS_TYPE"
> +	TST_FS_TYPE="overlay"
> +
> +	mntpoint_backup="$TST_MNTPOINT"
> +	TST_MNTPOINT="$merged"
> +
> +	params_backup="$TST_MNT_PARAMS"
> +	TST_MNT_PARAMS="-o lowerdir=$lower,upperdir=$upper,workdir=$work"
> +
> +	grep -q ima_appraise_tcb /proc/cmdline || \
> +		tst_brk TCONF "Test requires ima_appraise_tcb kernel parameter"

Instead of specifying individual policies separately, the newer method
of specifying builtin IMA policies on the boot command line is
"ima_policy=", with a list of policies.  The builtin appraise policy
would be specified as "ima_policy=appraise_tcb".  Refer to
Documentation/admin-guide/kernel-parameters.txt for the list of
builtin policies.

> +}
> +
> +do_test()
> +{
> +	local file="foo.txt"
> +	local f
> +
> +	tst_mount
> +	mounted=1
> +
> +	ROD echo lower \> $lower/$file

For some reason "mntpoint/lower" isn't loopback mounted.  With the
builtin appraise policy, because it is a tmpfs filesystem,
security.ima does not exist.  Writing to the merged directory then
fails.

+ df -T mntpoint/lower
Filesystem     Type  1K-blocks   Used Available Use% Mounted on
tmpfs          tmpfs   4020348 262316   3758032   7% /tmp


+ getfattr -m '^security' --dump mntpoint/lower/foo.txt
# file: mntpoint/lower/foo.txt
security.evm=0sAq8niNi4X7cYntKSAki1Woc+Y5Yq
security.selinux="unconfined_u:object_r:user_tmp_t:s0"

Mimi

> +	if ! echo overlay > $merged/$file 2>/dev/null; then
> +		tst_res TFAIL "Cannot write to merged layer"
> +		return
> +	fi
> +
> +	for f in $(find $TST_MNTPOINT -type f); do
> +		EXPECT_PASS cat $f \> /dev/null 2\> /dev/null
> +	done
> +}

