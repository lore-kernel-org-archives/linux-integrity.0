Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752184AbeBHSpX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Feb 2018 13:45:23 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w18IXv66035423
        for <linux-integrity@vger.kernel.org>; Thu, 8 Feb 2018 13:45:22 -0500
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2g0s8ngncm-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Feb 2018 13:45:21 -0500
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Thu, 8 Feb 2018 13:45:19 -0500
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w18IjGiX49610952
        for <linux-integrity@vger.kernel.org>; Thu, 8 Feb 2018 18:45:16 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 881CA12403D
        for <linux-integrity@vger.kernel.org>; Thu,  8 Feb 2018 13:42:02 -0500 (EST)
Received: from [9.2.202.41] (unknown [9.2.202.41])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP id 786D8124035
        for <linux-integrity@vger.kernel.org>; Thu,  8 Feb 2018 13:42:02 -0500 (EST)
Subject: Re: TPM selftest failure in 4.15
To: linux-integrity <linux-integrity@vger.kernel.org>
References: <1517487371.3251.9.camel@HansenPartnership.com>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Thu, 8 Feb 2018 13:45:34 -0500
MIME-Version: 1.0
In-Reply-To: <1517487371.3251.9.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <20b5692f-1faa-7d9c-759d-701caf72a6ff@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 2/1/2018 7:16 AM, James Bottomley wrote:
> 
> The error is TPM_RC_TESTING, which means it looks like we don't wait
> long enough for the selftests to complete.  I get this all the time
> booting with 4.15.  Fortunately I have a 4.13 backup kernel which is
> fine (otherwise I'd be a bit hosed since all my keys now require a
> TPM).

The current TCG PC Client Device Driver WG wisdom, if you don't want to 
poll the status bit, is to issue the TPM2_SelfTest with fullTest = yes.
'yes' forces the command to block (not return a response) until the 
command completes.

The TPM vendors suspect that a loop that re-issues the command in 
response to TPM_RC_TESTING can make matters worse.  If a crypto 
algorithm self test keeps getting aborted for the TPM to process the 
command, it has to restart.

My feeling is that, if you going to sleep/loop on something, it's better 
to loop on dataAvail than resending and looping on TPM_RC_TESTING.
