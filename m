Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47716 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756676AbeDZQSc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Apr 2018 12:18:32 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3QGHZ3Y086177
        for <linux-integrity@vger.kernel.org>; Thu, 26 Apr 2018 12:18:32 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2hkfdts73s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 26 Apr 2018 12:18:32 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 26 Apr 2018 17:18:29 +0100
Subject: Re: [RFC PATCH v3 00/10] Rewrite tests into new API + fixes
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Thu, 26 Apr 2018 12:18:24 -0400
In-Reply-To: <20180419195503.7194-1-pvorel@suse.cz>
References: <20180419195503.7194-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1524759504.3647.12.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-04-19 at 21:54 +0200, Petr Vorel wrote:
> Hi,
> 
> changes v2->v3:
> * Fixed some of errors caused by test order.
> 
> * ima_boot_aggregate
>   - max event size is now 1MB according to spec
> 
> * ima_mmap
>   - reduce sleep + log it
>   - rewritten into new API
> 
> * ima_measurements.sh
>   - don't require iversion for kernel >= 4.16
>   - avoid using tmpfs

This is working nicely!

> 
> * ima_policy.sh
>   - improved detection of policy writability
>   - merge test2 and test3
> 
> * ima_violations.sh
>   - avoid using tmpfs
>   - improved grepping logs (no sleep is needed)
> 
> * ima_tpm.sh
>   - Improve error messages
> 
> TODO:
> * fix problems with violations tests (see patch 02/10).
> * detect whether policy must be signed (currently tests assume the
> policy does not need to be signed):
> https://lists.linux.it/pipermail/ltp/2018-April/007702.html
> http://lists.linux.it/pipermail/ltp/2018-January/006970.html


test: cmdline="ima_policy.sh"
contacts=""
analysis=exit
<<<test_output>>>
ima_policy 1 TINFO: verify that invalid policy isn't loaded
ima_policy 1 TPASS: didn't load invalid policy
ima_policy 2 TINFO: verify that policy file is not opened concurrently
and able to loaded multiple times
ima_policy 2 TFAIL: problem with loading policy (policy should be able
to load multiple times)

For now, could we change "problem with loading policy (policy should
be able to load multiple times)" to say, "problem loading or extending
policy (may require policy to be signed)"?

I'm also seeing, 

test: ima_tpm
<<<test_output>>>
ima_tpm 1 TINFO: verify boot aggregate
ima_tpm 1 TPASS: bios aggregate matches IMA boot aggregate
ima_tpm 2 TINFO: verify PCR values
ima_tpm 2 TINFO: evmctl version: evmctl 1.0
ima_tpm 2 TINFO: new PCRS path, evmctl >= 1.1 required
ima_tpm 2 TINFO: verify PCR (Process Control Register)
ima_tpm 2 TFAIL: failed to get PCR-10
ima_tpm 2 TPASS: aggregate PCR value matches real PCR value

It's unclear how the script could fail to get PCR-10, but pass the
following test.

Mimi
