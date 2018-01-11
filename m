Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp2.infineon.com ([217.10.52.18]:37159 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934655AbeAKR30 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jan 2018 12:29:26 -0500
Subject: Re: [GIT PULL] tpmdd updates for v4.16
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>
References: <20180108111834.azjo6hdbm62el4qj@linux.intel.com>
 <1b81847f-123f-ea9e-f2e5-48c73174c8b2@infineon.com>
 <20180110160823.4jco3foc4afxbtl2@linux.intel.com>
From: Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <0b10c696-529a-fc33-b0a3-5c7cb1838acb@infineon.com>
Date: Thu, 11 Jan 2018 18:29:16 +0100
MIME-Version: 1.0
In-Reply-To: <20180110160823.4jco3foc4afxbtl2@linux.intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 10.01.2018 17:08, Jarkko Sakkinen wrote:
> On Tue, Jan 09, 2018 at 10:59:07AM +0100, Alexander Steffen wrote:
>> On 08.01.2018 12:18, Jarkko Sakkinen wrote:
>>> Hi James,
>>>
>>> Sorry for a late PR.
>>>
>>> Summary of the content:
>>>
>>> * Reduced polling delays in tpm_tis.
>>> * Support for retrieving TPM 2.0 Event Log through EFI before
>>>     ExitBootServices.
>>> * Replaced tpm-rng.c with a hwrng device managed by the driver for each
>>>     TPM device.
>>> * TPM resource manager synthesizes TPM_RC_COMMAND_CODE response instead
>>>     of returning -EINVAL for unknown TPM commands. This makes user space
>>>     more sound.
>>> * CLKRUN fixes:
>>>     * Keep #CLKRUN disable through the entier TPM command/response flow.
>>>     * Check whether #CLKRUN is enabled before disabling and enabling it
>>>       again because enabling it breaks PS/2 devices on a system where it
>>>       is disabled.
>>
>> I just spent some time trying to run all that (tpmdd-next-20180108) through
>> my test system and hit a couple of non-TPM problems. In case you see similar
>> issues, this is what I found out:
>>
>> 1. rmmod for the TPM driver hangs indefinitely. The TPM driver now registers
>> itself as a hwrng, but in case it is the only hwrng in a system, the call to
>> hwrng_unregister never returns. Known bug, but still not fixed in 4.15-rc7
>> (see https://www.mail-archive.com/linux-crypto@vger.kernel.org/msg29884.html
>> for details).
>>
>> 2. Raspberry Pis (which I use to test tpm_tis_spi and
>> tpm_i2c_infineon) boot with that kernel, but have no USB or ethernet
>> support. Also a known problem
>> (http://lists.infradead.org/pipermail/linux-arm-kernel/2018-January/552280.html).
>>
>> 3. Device tree overlays with references to non-existent target-paths are
>> rejected now (whereas before the invalid parts were just ignored). I guess
>> this is an intentional change, but the error message does not really point
>> to the problem (applying the overlay just returns with EINVAL).
> 
> Do we have these?

No, otherwise I would have sent a fix :)

It is just something that I used for my tests: I had an overlay that I 
could use for both the mainline kernel and the RPi kernel. On the RPi 
kernel it would deactivate the spidev entry, so that tpm_tis_spi was 
able to use the device. On the mainline kernel, there is no spidev in 
the device tree, so this part is not necessary and I simply removed it 
now to fix the problem (I'm not using the RPi kernels anymore).

Alexander

>> With all that fixed in my environment, my tests now pass successfully.
>>
>> Alexander
> 
> Thank you for reporting these issues.
> 
> /Jarkko
