Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752136AbdLHUL0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 8 Dec 2017 15:11:26 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vB8K9QeW131244
        for <linux-integrity@vger.kernel.org>; Fri, 8 Dec 2017 15:11:26 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2er1cd0q3x-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 08 Dec 2017 15:11:25 -0500
Received: from localhost
        by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Fri, 8 Dec 2017 13:11:24 -0700
Subject: Re: [RFC PATCH] tpm: don't return -EINVAL if TPM command validation
 fails
To: Javier Martinez Canillas <javierm@redhat.com>,
        "Roberts, William C" <william.c.roberts@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
References: <20171117100724.19257-1-javierm@redhat.com>
 <20171120231512.6wpqgcggfta3am7m@linux.intel.com>
 <7c148cf0-2403-55cf-1633-ff326d5c6f7b@redhat.com>
 <20171121123006.esr7yxs5lvorlfjf@linux.intel.com>
 <476DC76E7D1DF2438D32BFADF679FC563F4BFC0B@ORSMSX115.amr.corp.intel.com>
 <600d6778-f155-ea51-64dc-e0041c6943d3@redhat.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Fri, 8 Dec 2017 15:11:22 -0500
MIME-Version: 1.0
In-Reply-To: <600d6778-f155-ea51-64dc-e0041c6943d3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <67662fe4-38f4-7b28-2806-3dbe94870f74@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/22/2017 4:26 AM, Javier Martinez Canillas wrote:
> 
> I still do believe that both interfaces (/dev/tpm and /dev/tpmrm) should be
> consistent if possible though. 

Agreed.  TPM code is hard enough to debug without inconsistencies 
between tpm, tpmrm, and the simulator.

> In other words, I don't see the value of not
> behaving as expected by the spec if this doesn't have security implications
> as is the case with the approach suggested by Jason. And the implementation
> for sending the synthesized response is also trivial.
> 
> The other option that's fixing this in user-space will be a workaround, since
> it would either be to check for TPM_RC_SUCCESS instead of TPM_RC_COMMAND_CODE
> or make the SAPI library infer that a -EINVAL error means that a command isn't
> supported and return a TPM_RC_COMMAND_CODE to the caller.

Remember also that SAPI is just one TSS design.  There are currently 
three others.  And SAPI is targeted more as a building block than an end 
user library.

Every TSS implementation would have to do this mapping.  How would they 
even know to do it if they didn't notice this thread?  It wouldn't be 
documented anywhere other than deep in kernel code.
