Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:63296 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeBPT0C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Feb 2018 14:26:02 -0500
Subject: Re: [PATCH] tpm: fix selftest failure regression
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: <linux-integrity@vger.kernel.org>
References: <1518122886.21828.20.camel@HansenPartnership.com>
 <20180216083406.ysbujdgwo4jg2e46@linux.intel.com>
 <1518805037.4640.27.camel@HansenPartnership.com>
 <1518807576.4475.3.camel@HansenPartnership.com>
From: Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <0f489217-b1f2-0265-d5d3-05f7b72d717e@infineon.com>
Date: Fri, 16 Feb 2018 20:26:00 +0100
MIME-Version: 1.0
In-Reply-To: <1518807576.4475.3.camel@HansenPartnership.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 16.02.2018 19:59, James Bottomley wrote:
> On Fri, 2018-02-16 at 10:17 -0800, James Bottomley wrote:
>> On Fri, 2018-02-16 at 10:34 +0200, Jarkko Sakkinen wrote:
>>>
>>> Hi
>>>
>>> See the comments below and please include this as a prequel patch
>>> for the next version:
>>>
>>> https://patchwork.kernel.org/patch/10208965/
>>
>> Actually, I've got another curious bit of behaviour from my Nuvoton:
>>   After an experiment with primary EK generation that sent it into
>> failure mode (connected with something else, nothing to do with
>> this), it's taken to returning 232 (TPM_RC_COMMAND_CODE) to a partial
>> self test periodically on boot.  According to the manual this is
>> impossible, so I think it's something to do with
>> tpm_validate_command.  I think, perhaps, we shouldn't call the
>> getcaps for the command codes until the self test is over, but I need
>> to do more debugging to track down what's going on.
>>
>> I've also got other reports of TPM_RC_COMMAND_CODE failures during
>> self test, so this isn't just my screwed up chip.
> 
> This isn't anything to do with us synthesizing TPM_RC_COMMAND_CODE, the
> status is definitely coming from the chip.  If I run a full self test
> immediately after this, everything works as normal.

Interesting. What you call full and partial self test, those are the 
same command (TPM2_SelfTest), just with fullTest=YES and fullTest=NO, 
right? Then it seems even stranger that whether you get RC_COMMAND_CODE 
does not depend on the command but on the parameter.

> Can anyone from the manufacturers shed any light on the
> TPM_RC_COMMAND_CODE return from a partial self test?

It's the first time I see this usage of that return code. The 
specification says that this code means "command code not supported", 
which to me sounds rather like "command not implemented", not "command 
temporarily not available". Maybe this is just a bug in this TPM 
implementation?

Alexander
