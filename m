Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44330 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964840AbeAXRhG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jan 2018 12:37:06 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w0OHap7x134541
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jan 2018 12:37:06 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2fpw8p4sh9-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 24 Jan 2018 12:37:05 -0500
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Wed, 24 Jan 2018 17:37:02 -0000
Subject: Re: [RFC PATCH 0/2] IMA: Rewrite tests into new API + fixes
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: Dmitry Kasatkin <dmitry.kasatkin@huawei.com>,
        linux-integrity@vger.kernel.org,
        Roberto Sassu <roberto.sassu@polito.it>
Date: Wed, 24 Jan 2018 12:36:57 -0500
In-Reply-To: <20180111202821.31639-1-pvorel@suse.cz>
References: <20180111202821.31639-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1516815417.3686.55.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi Petr,

[Cc'ing Roberto]

On Thu, 2018-01-11 at 21:28 +0100, Petr Vorel wrote:
> Hi,
> 
> I rewrote IMA tests to use new API + add small fixes.
> I haven't tested ima_tpm.sh as I have no TPM :-(.
> 
> Comments are welcomed.

The LTP tests are quite dated, and need some major rework.  I really
appreciate your addressing some of the issues.  Below are some
additional ones.

Tests "ima02 ima_measurement.sh" and "ima04 ima_violations.sh" assume
files are created on a filesystem in policy.  The "measure.policy"
excludes tmpfs, yet TMPDIR defaults to a tmpfs filesystem.  There are
a couple of ways of resolving this problem (eg. removing tmpfs from
the "measure.policy", use a RAM block device instead of tmpfs, etc).
 Since the builtin "ima_policy=tcb" also excludes tmpfs, not using a
tmpfs filesystem would be preferable.

Originally IMA allowed a builtin policy to be replaced with a custom
policy, by simply cat'ing a file into the securityfs IMA policy file.
Currently, if new rules can be added to the custom policy (Kconfig
IMA_WRITE_POLICY enabled), the policy file must be signed.  Similarly,
if the builtin "secure-boot" policy is defined on the boot command
line, the custom policy must be signed.  Test "ima01 ima_policy.sh"
should first detect if the policy must be signed, before running the
tests.

ima_boot_aggregate.c defines the BIOS MAX_EVENT_SIZE BIOS size as 500,
but I'm currently seeing BIOS events larger than 4k.

Since these tests were first written, Roberto's IMA templates and
Dmitry's support for larger digests were upstreamed.  With the new
template format, the file hash is prefixed with the hash algorithm.
 Before comparing the calculated boot aggregate with the value in the
IMA measurement list, the hash algorithm needs to be removed.
 
For the new template format measurement lists, walking the measurement
list, re-calculating the PCRs and comparing them with the HW or vTPM
PCRs fail.  The ima-evm-utils package has a working version.  Invoke
"evmctl" with the "ima_mesaurement" option.

thanks,

Mimi
