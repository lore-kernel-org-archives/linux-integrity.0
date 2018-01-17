Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp11.infineon.com ([217.10.52.105]:59353 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbeAQS6N (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jan 2018 13:58:13 -0500
Subject: Re: [RFC][PATCH 8/9] tpm_tis_spi: add delay between wait state
 retries
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        <jarkko.sakkinen@linux.intel.com>, <nayna@linux.vnet.ibm.com>,
        <kgold@linux.vnet.ibm.com>, <linux-integrity@vger.kernel.org>
References: <20171208184658.9588-1-Alexander.Steffen@infineon.com>
 <20171208184658.9588-9-Alexander.Steffen@infineon.com>
 <1515700018.3420.13.camel@linux.vnet.ibm.com>
 <db63c75f-464d-2fbc-3e97-ea3ef162cea5@infineon.com>
 <1516055450.6607.91.camel@linux.vnet.ibm.com>
 <1516209306.5820.19.camel@linux.vnet.ibm.com>
From: Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <d2a6a463-370f-5849-535d-17ad21b67a08@infineon.com>
Date: Wed, 17 Jan 2018 19:58:09 +0100
MIME-Version: 1.0
In-Reply-To: <1516209306.5820.19.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 17.01.2018 18:15, Mimi Zohar wrote:
> On Mon, 2018-01-15 at 17:30 -0500, Mimi Zohar wrote:
>>> What would be a better implementation? No delay and simply retry for
>>> five seconds?
>>>
>>> What TPMs are you using for your tests? At least for the TPMs that I
>>> have available for my tests (with a FIFO size of ~256 bytes) I would not
>>> expect any wait states for extend commands.
>>
>> The TPM burstcount is 32.  Unfortunately, with this patch set the
>> performance on the pi is worse than without it.  Without this patch
>> set we're seeing ~14 secs for a thousand measurements vs. either ~38s
>> or ~23s, depending on the wait sleep length introduced in patch 8/9.
> 
>  From my response, it might not have been clear that with all of the
> patches, except this one 8/9 calling tpm_msleep(), the performance is
> equivalent to without any of the patches.  With this patch set, but
> with or without the call to tpm_msleep(), it loops 2 or 3 times.

Thanks for your tests. I haven't yet done such extensive performance 
tests for those changes. But I've got some performance tests that I 
still want to run to see what performance impact I can measure with my TPMs.

It seems clear to me that for optimum performance there shouldn't be any 
sleeps, at least not for the first few retries. If I use a time limit 
instead of counting the number of retries, are sleeps necessary at all? 
The SPI bus is locked anyway, so nothing else can use it while we are 
sleeping. The SPI transfers should slow us down sufficiently, so that we 
are not consuming 100% of CPU time. And in the common cases (at least 
those that we know) the wait states seem to clear up pretty quickly.

If there are no objections, I'll rewrite the patch in such a way (time 
limit of several seconds, no sleeps). Maybe it is also worth trying to 
see what performance can be gained by removing more sleeps, in 
wait_for_tpm_stat and elsewhere. Perhaps the first millisecond(s) or so 
should always be busy waiting, and sleeps should only come afterwards.

Alexander
