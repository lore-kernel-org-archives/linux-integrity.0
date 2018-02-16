Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:42348 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751146AbeBPSag (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Feb 2018 13:30:36 -0500
Subject: Re: TPM selftest failure in 4.15
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
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
 <1518707632.5667.118.camel@linux.vnet.ibm.com>
From: Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <a85f5b00-8291-b394-ca76-a2044b347d64@infineon.com>
Date: Fri, 16 Feb 2018 19:30:34 +0100
MIME-Version: 1.0
In-Reply-To: <1518707632.5667.118.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 15.02.2018 16:13, Mimi Zohar wrote:
> On Thu, 2018-02-15 at 14:12 +0200, Jarkko Sakkinen wrote:
>> On Fri, Feb 09, 2018 at 12:47:10PM +0100, Alexander Steffen wrote:
>>> On 09.02.2018 11:02, Jarkko Sakkinen wrote:
>>>> On Thu, Feb 08, 2018 at 09:02:00AM -0800, James Bottomley wrote:
>>>>> There is an identified regression: the TPM driver will now periodically
>>>>> fail to attach.  However, there's no point reviewing until we agree
>>>>> what the fix is.  I was just waiting to verify this fixed my problem
>>>>> (which means seeing the messages it spits out proving the TPM has
>>>>> remained in self test).  I have now seen this and the driver still
>>>>> works, so I can submit a formal patch.
>>>>
>>>> For the self-test the duration falls down to 2 seconds as the specs do
>>>> not contain any well-defined duration for it, or at least I haven't
>>>> found it.
>>>>
>>>> I see three alternative ways the fix the self-test:
>>>>
>>>> 1. Execute self-test with fullTest = YES.
>>>
>>> I had proposed some fixes in this direction last year:
>>> https://patchwork.kernel.org/patch/10105483/
>>> https://patchwork.kernel.org/patch/10130535/
>>>
>>> Those combine the fast test execution with fullTest = NO for spec-compliant
>>> TPMs with a fallback to fullTest = YES.
>>
>> The first was accepted.
>>
>> The 2nd wasn't accpeted mainly for reasons that for me only acceptable
>> dependency is:
>>
>> 1. Patch that is part of the same patch set.
>> 2. A merged commit.
>>
>> I didn't event look at the code for the second one at that point because
>> it was formally done wrong.
>>
>> What it is doing would be acceptable for me. I still think that TPM
>> should be fully tested before letting IMA for example to use it.
> 
> Why?  The short selftest has worked fine up to now.  The full selftest
> delays the TPM way too long and causes IMA to go into TPM-bypass mode.
>   The faster the TPM is available, the better for IMA.

I assume that IMA can deal with the TPM not returning RC_SUCCESS for a 
command, right? Then, if speed is the goal, not explicitly triggering 
any selftests and instead letting the TPM handle them internally still 
seems like the best solution. If the user needs a fully tested TPM for 
some reason, he can trigger the selftests himself. But the kernel cannot 
at the same time guarantee that all selftests pass (especially on 
broken/slow devices that take forever to complete them) and make the TPM 
available as early as possible.

I think we had a similar example elsewhere already: The kernel does not 
check all SMART results before accessing the hard disk, why should it do 
that for the TPM?

> It seems all commands, except selftest, the code sleeps in a loop and
> checks for the command to finish, but doesn't resend the command.
>   Only for selftest is the command resent, instead of just waiting for
> it to complete.  Is there any reason for this?

The selftest command is special in that the vendor can choose to have it 
execute its actions synchronously (like all other commands) or 
asynchronously (that is, return immediately and schedule the actions in 
the background). Only in the asynchronous case is the command repeated, 
as a simple way of querying the result. Since we call the command with 
fullTest=NO, only missing selftests are scheduled and with each 
iteration there should be fewer and fewer tests left to be executed, 
similar to how RC_YIELDED works.

Alexander
