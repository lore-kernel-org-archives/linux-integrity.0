Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:42267 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbeBPS1i (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Feb 2018 13:27:38 -0500
Subject: Re: TPM selftest failure in 4.15
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        linux-integrity <linux-integrity@vger.kernel.org>
References: <1517488970.3251.26.camel@HansenPartnership.com>
 <1517498648.3145.4.camel@HansenPartnership.com>
 <20180201174053.GQ17053@ziepe.ca>
 <1517510764.3145.38.camel@HansenPartnership.com>
 <20180201185909.GW17053@ziepe.ca>
 <1517515204.3145.51.camel@HansenPartnership.com>
 <20180208131007.wedzl5itrlx2dawn@linux.intel.com>
 <1518109320.21828.2.camel@HansenPartnership.com>
 <20180209100204.likckglpdx427dnl@linux.intel.com>
 <6066758e-efe3-7432-0b8f-540a781cb3aa@infineon.com>
 <20180215121231.yc74vwg3fqz3ybop@linux.intel.com>
From: Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <399d15fd-0532-aa06-0b0e-0630eed7de09@infineon.com>
Date: Fri, 16 Feb 2018 19:27:22 +0100
MIME-Version: 1.0
In-Reply-To: <20180215121231.yc74vwg3fqz3ybop@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 15.02.2018 13:12, Jarkko Sakkinen wrote:
> On Fri, Feb 09, 2018 at 12:47:10PM +0100, Alexander Steffen wrote:
>> On 09.02.2018 11:02, Jarkko Sakkinen wrote:
>>> On Thu, Feb 08, 2018 at 09:02:00AM -0800, James Bottomley wrote:
>>>> There is an identified regression: the TPM driver will now periodically
>>>> fail to attach.  However, there's no point reviewing until we agree
>>>> what the fix is.  I was just waiting to verify this fixed my problem
>>>> (which means seeing the messages it spits out proving the TPM has
>>>> remained in self test).  I have now seen this and the driver still
>>>> works, so I can submit a formal patch.
>>>
>>> For the self-test the duration falls down to 2 seconds as the specs do
>>> not contain any well-defined duration for it, or at least I haven't
>>> found it.
>>>
>>> I see three alternative ways the fix the self-test:
>>>
>>> 1. Execute self-test with fullTest = YES.
>>
>> I had proposed some fixes in this direction last year:
>> https://patchwork.kernel.org/patch/10105483/
>> https://patchwork.kernel.org/patch/10130535/
>>
>> Those combine the fast test execution with fullTest = NO for spec-compliant
>> TPMs with a fallback to fullTest = YES.
> 
> The first was accepted.
> 
> The 2nd wasn't accpeted mainly for reasons that for me only acceptable
> dependency is:
> 
> 1. Patch that is part of the same patch set.
> 2. A merged commit.
> 
> I didn't event look at the code for the second one at that point because
> it was formally done wrong.

Ah, sorry, I thought this was the easiest solution, since it seemed 
likely that the first patch would be merged at some point.

If a similar situation arises, should I then include the first patch in 
a series together with the second, even if that means that there will be 
two identical copies of the first patch (one from when it was first 
published, one as part of the new series)? Or should I just avoid the 
dependency in the second patch, though that will lead to merge conflicts 
when you want accept both patches?

Alexander
