Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42754 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727146AbeI0AR7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Sep 2018 20:17:59 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8QHsDNs011532
        for <linux-integrity@vger.kernel.org>; Wed, 26 Sep 2018 14:03:52 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2mre5dtqeu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 26 Sep 2018 14:03:52 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 26 Sep 2018 19:03:49 +0100
Subject: Re: [PATCH v2, RESEND 0/3] tpm: retrieve digest size of unknown
 algorithms from TPM
From: Mimi Zohar <zohar@linux.ibm.com>
To: jarkko.sakkinen@linux.intel.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Safford <david.safford@ge.com>
Date: Wed, 26 Sep 2018 14:03:34 -0400
In-Reply-To: <1537972840.3459.6.camel@linux.ibm.com>
References: <20180917093820.20500-1-roberto.sassu@huawei.com>
         <1537972840.3459.6.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1537985014.3459.24.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, 2018-09-26 at 10:40 -0400, Mimi Zohar wrote:
> On Mon, 2018-09-17 at 11:38 +0200, Roberto Sassu wrote:
> > Resending to maintainer with correct mailing lists in CC.
> > 
> > The TPM driver currently relies on the crypto subsystem to determine the
> > digest size of supported TPM algorithms. In the future, TPM vendors might
> > implement new algorithms in their chips, and those algorithms might not
> > be supported by the crypto subsystem.
> > 
> > Usually, vendors provide patches for the new hardware, and likely
> > the crypto subsystem will be updated before the new algorithm is
> > introduced. However, old kernels might be updated later, after patches
> > are included in the mainline kernel. This would leave the opportunity
> > for attackers to misuse PCRs, as PCR banks with an unknown algorithm
> > are not extended.
> > 
> > This patch set provides a long term solution for this issue. If a TPM
> > algorithm is not known by the crypto subsystem, the TPM driver retrieves
> > the digest size from the TPM with a PCR read. All the PCR banks are
> > extended, even if the algorithm is not yet supported by the crypto
> > subsystem.
> 
> Other than checking the digest size before copying the pcrread buffer,
> the patches look good.  Please add my Ack on all 3 patches.
> 
> (New address) Acked-by: Mimi Zohar <zohar@linux.ibm.com>

I've reviewed, and am currently running with these patches.

Even if the IMA changes were in a separate patch, we wouldn't be able
to break up the patch set anyway.  Jarkko, I'd appreciate your
carrying the entire patch set.

Roberto, a similar change needs to be made for tpm_pcr_extend.  Are
you planning on posting those changes as well?

Mimi
