Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:47031 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752640AbdK3RVI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Nov 2017 12:21:08 -0500
Received: by mail-wm0-f44.google.com with SMTP id r78so14502102wme.5
        for <linux-integrity@vger.kernel.org>; Thu, 30 Nov 2017 09:21:07 -0800 (PST)
Subject: Re: [PATCH v2] tpm: return a TPM_RC_COMMAND_CODE response if a
 command isn't implemented
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Philip Tricca <philip.b.tricca@intel.com>,
        linux-integrity@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20171129110846.31892-1-javierm@redhat.com>
 <20171129175738.pim7is5zc3wmult6@linux.intel.com>
 <e7e154f8-d26f-a12a-96b9-603508ae0e21@redhat.com>
 <20171130163847.dmsmgms3wkbuptwa@linux.intel.com>
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <b840cbf6-1935-4223-93e6-32337e60fa09@redhat.com>
Date: Thu, 30 Nov 2017 18:21:04 +0100
MIME-Version: 1.0
In-Reply-To: <20171130163847.dmsmgms3wkbuptwa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/30/2017 05:38 PM, Jarkko Sakkinen wrote:
> On Wed, Nov 29, 2017 at 07:24:48PM +0100, Javier Martinez Canillas wrote:
>> Hello Jarkko,
>>
>> On 11/29/2017 06:57 PM, Jarkko Sakkinen wrote:
>>> On Wed, Nov 29, 2017 at 12:08:46PM +0100, Javier Martinez Canillas
>>> wrote:
>>>> +#define TPM2_RC_LAYER_SHIFT	16 +#define TPM2_RESMGRTPM_RC_LAYER
>>>> (11 << TPM2_RC_LAYER_SHIFT)
>>>
>>> I got this spec from Philip [1].
>>>
>>> Couple of remarks:
>>>
>>> * What is the difference between TSS2_RESMGR_RC_LAYER and 
>>> TSS2_RESMGR_TPM_RC_LAYER?
>>
>> The difference is the type of error returned in each case. TSS2_RESMGR_RC_LAYER
>> means that's an error internal to the TAB/RM and so the response code is one of
>> the TSS2_BASE_RC_* error values.
>>
>> But TSS2_RESMGR_TPM_RC_LAYER means that the resource manager is taking over some
>> TPM functionality (i.e: validation) and so the response code is a TSS2_RC_* error
>> value, liket is the case for this patch (TPM_RC_COMMAND_CODE).
>>
>>> * Should the driver code use TSS2 or TPM2 prefix?
>>>
>>
>> That's a very good question. I used TPM2 as prefix instead of TSS2 to keep it
>> consistent with the rest of the driver, but probably TSS2 should be used instead
>> so people can search more easy the constant in the specification doc.
> 
> OK, I'll change the prefix.
>

No need for you to do that since I posted a v3 today that changed the prefix:

https://lkml.org/lkml/2017/11/30/56

I also added Philip's Reviewed-by tag, since he said I could do as a response
to my v1:

https://lkml.org/lkml/2017/11/27/1297

To save you following the link:

 > Thanks for incorporating my feedback into your patch. Feel free to add
 > the appropriate tag to the commit message to document my review if it's
 > appropriate.
 > 
 > Philip
 > 
 
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>

Thanks!
 
> I'll postpone testing to next week as I try to get v7 of the SGX patch
> set done during this week.
>

Sure, no worries. Keep it mind though that in order to test you need to find
a TPM2 that doesn't implement a command or inject a command lookup failure.

I faced this issue on an Intel PTT fTPM2.0 (Thinkpad X1 Carbon 4th gen) with
the tpm2_encryptdecrypt tool from the tpm2-tools project. The tool first try
to use TPM2_EncryptDecrypt2 (which isn't supported by the fTPM2) and then it
fallbacks to TPM2_EncryptDecrypt.
 
> I'll add test case or two for this to my smoke test suite (contributions
> are of course welcome):
> 
> https://github.com/jsakkine-intel/tpm2-scripts
>

I can do that. Probably what you want is send_cmd() to also unpack the layer
RC bits and ProtocolError() to print from what layer the RC is coming from?

> /Jarkko
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
