Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38520 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751486AbdK2SYv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Nov 2017 13:24:51 -0500
Received: by mail-wm0-f47.google.com with SMTP id 64so7799611wme.3
        for <linux-integrity@vger.kernel.org>; Wed, 29 Nov 2017 10:24:51 -0800 (PST)
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
From: Javier Martinez Canillas <javierm@redhat.com>
Message-ID: <e7e154f8-d26f-a12a-96b9-603508ae0e21@redhat.com>
Date: Wed, 29 Nov 2017 19:24:48 +0100
MIME-Version: 1.0
In-Reply-To: <20171129175738.pim7is5zc3wmult6@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hello Jarkko,

On 11/29/2017 06:57 PM, Jarkko Sakkinen wrote:
> On Wed, Nov 29, 2017 at 12:08:46PM +0100, Javier Martinez Canillas
> wrote:
>> +#define TPM2_RC_LAYER_SHIFT	16 +#define TPM2_RESMGRTPM_RC_LAYER
>> (11 << TPM2_RC_LAYER_SHIFT)
> 
> I got this spec from Philip [1].
> 
> Couple of remarks:
> 
> * What is the difference between TSS2_RESMGR_RC_LAYER and 
> TSS2_RESMGR_TPM_RC_LAYER?

The difference is the type of error returned in each case. TSS2_RESMGR_RC_LAYER
means that's an error internal to the TAB/RM and so the response code is one of
the TSS2_BASE_RC_* error values.

But TSS2_RESMGR_TPM_RC_LAYER means that the resource manager is taking over some
TPM functionality (i.e: validation) and so the response code is a TSS2_RC_* error
value, liket is the case for this patch (TPM_RC_COMMAND_CODE).

> * Should the driver code use TSS2 or TPM2 prefix?
>

That's a very good question. I used TPM2 as prefix instead of TSS2 to keep it
consistent with the rest of the driver, but probably TSS2 should be used instead
so people can search more easy the constant in the specification doc.

> [1]
> https://trustedcomputinggroup.org/wp-content/uploads/TCG-TSS-2.0-Overview-and-Common-Structures-Specification-Version-0.90-Revision-02.pdf
>
>  /Jarkko
> 

Best regards,
-- 
Javier Martinez Canillas
Software Engineer - Desktop Hardware Enablement
Red Hat
