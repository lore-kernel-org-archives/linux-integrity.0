Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752081AbeDHTMA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 8 Apr 2018 15:12:00 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w38J8YXt061384
        for <linux-integrity@vger.kernel.org>; Sun, 8 Apr 2018 15:12:00 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2h7mfa74je-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Sun, 08 Apr 2018 15:11:59 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Sun, 8 Apr 2018 15:11:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w38JBtEF51708134
        for <linux-integrity@vger.kernel.org>; Sun, 8 Apr 2018 19:11:55 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD7D3B2052
        for <linux-integrity@vger.kernel.org>; Sun,  8 Apr 2018 16:14:01 -0400 (EDT)
Received: from [9.49.209.157] (unknown [9.49.209.157])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP id 8DFB2B2050
        for <linux-integrity@vger.kernel.org>; Sun,  8 Apr 2018 16:14:01 -0400 (EDT)
Subject: Re: [PATCH] tpm: fix selftest failure regression
Cc: linux-integrity@vger.kernel.org
References: <1518122886.21828.20.camel@HansenPartnership.com>
 <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
 <1518805037.4640.27.camel@HansenPartnership.com>
 <1518807576.4475.3.camel@HansenPartnership.com>
 <0f489217-b1f2-0265-d5d3-05f7b72d717e@infineon.com>
 <1518810337.4475.16.camel@HansenPartnership.com>
 <1519136646.4113.13.camel@linux.intel.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Sun, 8 Apr 2018 15:11:54 -0400
MIME-Version: 1.0
In-Reply-To: <1519136646.4113.13.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <81f6be2b-8ea0-2655-3886-f197fc4b9bdd@linux.vnet.ibm.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 2/20/2018 9:24 AM, Jarkko Sakkinen wrote:
> On Fri, 2018-02-16 at 11:45 -0800, James Bottomley wrote:
>> tsscreateek -cp -alg ec -noflush
> 
> Can you describe in high-level what this command does? I will rather
> add a test to my smoke test suite than depend on TSS implementations
> for various reasons. This seems like a good test case to add as
> part of it.

It actually does a lot under the covers, but the end result is an ECC
Endorsement Key is created on the TPM.

1 - Reads the possible EK template and EK nonce from the TPM NV.  This 
involves:
	nvreadpublic to check for the existence and get the index size
	nvread to get the data, possibly in a loop
		which in turn needs a getcapability to determine
		the chunk size for the NV read
2 - Runs createprimary
3 - Similar to #1 to read the EK certificate from NV

It then validates the EK public key against the certificate (not using 
the TPM) to check that everything worked.
