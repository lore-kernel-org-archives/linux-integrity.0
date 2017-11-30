Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from smtp.twobit.us ([38.83.192.235]:53700 "EHLO smtp.twobit.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753580AbdK3BqE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Nov 2017 20:46:04 -0500
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Philip Tricca <philip.b.tricca@intel.com>,
        linux-integrity@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
References: <20171129110846.31892-1-javierm@redhat.com>
 <20171129175738.pim7is5zc3wmult6@linux.intel.com>
From: Philip Tricca <flihp@twobit.us>
Message-ID: <7df9ad8d-08b7-2be1-ebd8-874777aaed98@twobit.us>
Date: Wed, 29 Nov 2017 17:45:49 -0800
MIME-Version: 1.0
In-Reply-To: <20171129175738.pim7is5zc3wmult6@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH v2] tpm: return a TPM_RC_COMMAND_CODE response if a
 command isn't implemented
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On 11/29/2017 09:57 AM, Jarkko Sakkinen wrote:
> On Wed, Nov 29, 2017 at 12:08:46PM +0100, Javier Martinez Canillas wrote:
>> +#define TPM2_RC_LAYER_SHIFT	16
>> +#define TPM2_RESMGRTPM_RC_LAYER (11 << TPM2_RC_LAYER_SHIFT)
> 
> I got this spec from Philip [1].

As part of this I've been doing a pass back over the current draft spec
fixing up all of the places where the we were using 'ERROR_LEVEL',
'RESPONSE_LEVEL' etc interchangeably. Everything will be 'RC_LAYER' in
the next published draft. Apologies if this caused any confusion here
but it looks like Javier was able to work around this regardless Next
time around the spec should be more clear.

Philip

> Couple of remarks:
> 
> * What is the difference between TSS2_RESMGR_RC_LAYER and
>   TSS2_RESMGR_TPM_RC_LAYER?
> * Should the driver code use TSS2 or TPM2 prefix?
> 
> [1] https://trustedcomputinggroup.org/wp-content/uploads/TCG-TSS-2.0-Overview-and-Common-Structures-Specification-Version-0.90-Revision-02.pdf
> 
> /Jarkko
> 
