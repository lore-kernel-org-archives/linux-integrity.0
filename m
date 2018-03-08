Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58676 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751556AbeCHUGL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Mar 2018 15:06:11 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w28K4DTa128937
        for <linux-integrity@vger.kernel.org>; Thu, 8 Mar 2018 15:06:11 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2gk9986kyd-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Mar 2018 15:06:10 -0500
Received: from localhost
        by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
        Thu, 8 Mar 2018 20:06:07 -0000
Subject: Re: [PATCH] security: Fix IMA Kconfig for dependencies on ARM64
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jiandi An <anjiandi@codeaurora.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc: dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-ima-devel@lists.sourceforge.net,
        linux-ima-user@lists.sourceforge.net,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 08 Mar 2018 15:06:01 -0500
In-Reply-To: <191cfd49-0c66-a5ef-3d2b-b6c4132aa294@codeaurora.org>
References: <1520400386-17674-1-git-send-email-anjiandi@codeaurora.org>
         <20180307185132.GA30102@ziepe.ca>
         <1520448953.10396.565.camel@linux.vnet.ibm.com>
         <1520449719.5558.28.camel@HansenPartnership.com>
         <1520450495.10396.587.camel@linux.vnet.ibm.com>
         <1520451662.24314.5.camel@HansenPartnership.com>
         <1520461156.10396.654.camel@linux.vnet.ibm.com>
         <191cfd49-0c66-a5ef-3d2b-b6c4132aa294@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1520539561.3605.92.camel@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-03-08 at 12:42 -0600, Jiandi An wrote:

> So from the discussion, I hear James suggests to overhaul the current
> IMA driver to not do measurement (calling tpm_pcr_read(), etc) until
> after initrd phase so TPM drivers can be built as modules.
> 
> I hear Mimi insists TPM drivers should be built-in when IMA driver is
> enabled and set to Y in Kconfig.
> 
> Do we have a consensus on which way we should go?
> 
> I'm no expert on IMA and its driver.  James, will you be kind enough
> to look into overhauling the IMA driver to not measure until after 
> initrd phase if that's the consensus on resolving this?

IMA selecting the TPM forces the TPM to be builtin.  There's nothing
keeping you from directly configuring the TPM driver as builtin.

For remote attestation to validate the IMA measurement list against
the PCRs, the existing "ima_tcb" and "ima_policy=tcb" builtin policies
require the TPM to be builtin.

Not building the TPM into the kernel will also affect EVM.

I don't have a problem accepting your patch now; and if/when there is
a real use case for building the TPM driver as a kernel module for use
with IMA-measurement, accepting those changes then.

Mimi
