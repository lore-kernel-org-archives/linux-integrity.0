Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752380AbeBHR1G (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Feb 2018 12:27:06 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w18HP0bN019370
        for <linux-integrity@vger.kernel.org>; Thu, 8 Feb 2018 12:27:05 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2g0rhv7t2n-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 08 Feb 2018 12:27:05 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <kgold@linux.vnet.ibm.com>;
        Thu, 8 Feb 2018 12:27:04 -0500
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w18HR3kZ48103600
        for <linux-integrity@vger.kernel.org>; Thu, 8 Feb 2018 17:27:03 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA5C712404C
        for <linux-integrity@vger.kernel.org>; Thu,  8 Feb 2018 12:23:49 -0500 (EST)
Received: from [9.2.55.233] (unknown [9.2.55.233])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP id AA423124044
        for <linux-integrity@vger.kernel.org>; Thu,  8 Feb 2018 12:23:49 -0500 (EST)
Subject: Re: TPM selftest failure in 4.15
To: linux-integrity <linux-integrity@vger.kernel.org>
References: <1517487371.3251.9.camel@HansenPartnership.com>
 <db0a58b7-b021-9df3-aac1-bf3e23cacc0c@molgen.mpg.de>
 <1517488970.3251.26.camel@HansenPartnership.com>
 <1517498648.3145.4.camel@HansenPartnership.com>
 <20180201174053.GQ17053@ziepe.ca>
From: Ken Goldman <kgold@linux.vnet.ibm.com>
Date: Thu, 8 Feb 2018 12:27:21 -0500
MIME-Version: 1.0
In-Reply-To: <20180201174053.GQ17053@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f0a615cf-e8c3-abf3-3b17-dfae52e7b60e@linux.vnet.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 2/1/2018 12:40 PM, Jason Gunthorpe wrote:

> 
> But if a selftest returns TPM2_RC_TESTING I would expect the next
> command to also fail with a testing in progress code? At least by the
> spec..

It will return that code if the command requires an untested function.
For FIPS, the code is returned if there is any untested function.

Commands that don't require testable functions will succeed.

> The point of invoking selftest is to get to a state where future TPM
> commands will succeed, so returning immediately on RC_TESTING seems
> wrong?

Blocking vs. non-blocking is a TPM vendor implementation option.

Re., "seems wrong", the PC Client TPM changed the requirement, so that
a guaranteed non-blocking option is available.

~~
2.	On receipt of TPM2_SelfTest(fullTest == YES), the TPM SHALL perform a 
full self-test and return the result when all tests are complete.
~~

Of course, at some layer, the device drive is still polling, either for 
a success code (non-blocking) or a response (blocking).
