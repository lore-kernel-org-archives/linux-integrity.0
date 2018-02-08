Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43334 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752126AbeBHQxP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Feb 2018 11:53:15 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w18GooFF043921
        for <linux-integrity@vger.kernel.org>; Thu, 8 Feb 2018 11:53:15 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2g0rhv6d81-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Feb 2018 11:53:15 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Thu, 8 Feb 2018 11:53:14 -0500
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w18GrBcX43647020
        for <linux-integrity@vger.kernel.org>; Thu, 8 Feb 2018 16:53:11 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D95D124049
        for <linux-integrity@vger.kernel.org>; Thu,  8 Feb 2018 11:49:57 -0500 (EST)
Received: from [9.2.202.41] (unknown [9.2.202.41])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP id 3BB02124047
        for <linux-integrity@vger.kernel.org>; Thu,  8 Feb 2018 11:49:57 -0500 (EST)
Subject: Re: TPM selftest failure in 4.15 (Dell XPS 13, Nuvoton 6xx)
To: linux-integrity@vger.kernel.org
References: <1517487371.3251.9.camel@HansenPartnership.com>
 <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
 <1517488970.3251.26.camel@HansenPartnership.com>
 <1517498648.3145.4.camel@HansenPartnership.com>
 <4384419e-b2c6-7c51-e905-281ddfe68442@molgen.mpg.de>
 <d9c63b11-363a-2007-d7d5-a0112e58cb46@molgen.mpg.de>
 <d95f60f2e375446db3987f7d082d5cdd@ausx13mpc120.AMER.DELL.COM>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Thu, 8 Feb 2018 11:53:29 -0500
MIME-Version: 1.0
In-Reply-To: <d95f60f2e375446db3987f7d082d5cdd@ausx13mpc120.AMER.DELL.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d4d933ae-53e7-be08-7f04-4b0036f21dde@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 2/1/2018 3:12 PM, Mario.Limonciello@dell.com wrote:
> 
> I was told that TPMs that are FIPS validated (such as that in the XPS 13) may
> take longer for the self tests to run.

I don't understand why the SeftTest command should take longer.

I understand that a FIPS TPM must do all the self tests before it 
returns any results, while a non-FIPS must only test the algorithms 
required to return the result.  So, some other command will take longer.

~~

 From the TPM spec:

FIPS 140-2 requires that all power-on self-tests be complete before the 
TPM returns any value that depends on the results of a testable 
function. If compliance with FIPS 140-2 is required, any command that 
requires use of an untested function causes the TPM to operate as if 
TPM2_SelfTest(fullTest = NO) was received. The TPM returns 
TPM_RC_TESTING and continues to return TPM_RC_TESTING until all tests 
are complete. Alternatively, it may complete all tests and then complete 
the command. It may also return TPM_RC_NEEDS_TEST.
