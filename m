Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp.twobit.us ([38.83.192.235]:53721 "EHLO smtp.twobit.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752449AbdK3COD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Nov 2017 21:14:03 -0500
To: Javier Martinez Canillas <javierm@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
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
From: Philip Tricca <flihp@twobit.us>
Message-ID: <32786a39-931d-e7bc-c752-c580eb3c66b2@twobit.us>
Date: Wed, 29 Nov 2017 18:13:51 -0800
MIME-Version: 1.0
In-Reply-To: <e7e154f8-d26f-a12a-96b9-603508ae0e21@redhat.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v2] tpm: return a TPM_RC_COMMAND_CODE response if a
 command isn't implemented
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/29/2017 10:24 AM, Javier Martinez Canillas wrote:
> Hello Jarkko,
> 
> On 11/29/2017 06:57 PM, Jarkko Sakkinen wrote:
>> On Wed, Nov 29, 2017 at 12:08:46PM +0100, Javier Martinez Canillas
>> wrote:
>>> +#define TPM2_RC_LAYER_SHIFT	16 +#define TPM2_RESMGRTPM_RC_LAYER
>>> (11 << TPM2_RC_LAYER_SHIFT)
>>
>> I got this spec from Philip [1].
>>
>> Couple of remarks:
>>
>> * What is the difference between TSS2_RESMGR_RC_LAYER and 
>> TSS2_RESMGR_TPM_RC_LAYER?
> 
> The difference is the type of error returned in each case. TSS2_RESMGR_RC_LAYER
> means that's an error internal to the TAB/RM and so the response code is one of
> the TSS2_BASE_RC_* error values.
> 
> But TSS2_RESMGR_TPM_RC_LAYER means that the resource manager is taking over some
> TPM functionality (i.e: validation) and so the response code is a TSS2_RC_* error
> value, liket is the case for this patch (TPM_RC_COMMAND_CODE).

This distinction predates my participation in the spec. Personally I
don't think users will really care so long as it's evident which 'layer'
produced the error. Using the TSS2_RESMGR_TPM_RC_LAYER is the right
thing to do though according to the spec.

>> * Should the driver code use TSS2 or TPM2 prefix?
>>
> 
> That's a very good question. I used TPM2 as prefix instead of TSS2 to keep it
> consistent with the rest of the driver, but probably TSS2 should be used instead
> so people can search more easy the constant in the specification doc.

+1

Philip

>> [1]
>> https://trustedcomputinggroup.org/wp-content/uploads/TCG-TSS-2.0-Overview-and-Common-Structures-Specification-Version-0.90-Revision-02.pdf
>>
>>  /Jarkko
>>
> 
> Best regards,
> 
