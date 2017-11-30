Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:36395 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752177AbdK3QjL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Nov 2017 11:39:11 -0500
Date: Thu, 30 Nov 2017 18:38:47 +0200
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Philip Tricca <philip.b.tricca@intel.com>,
        linux-integrity@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH v2] tpm: return a TPM_RC_COMMAND_CODE response if a
 command isn't implemented
Message-ID: <20171130163847.dmsmgms3wkbuptwa@linux.intel.com>
References: <20171129110846.31892-1-javierm@redhat.com>
 <20171129175738.pim7is5zc3wmult6@linux.intel.com>
 <e7e154f8-d26f-a12a-96b9-603508ae0e21@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e7e154f8-d26f-a12a-96b9-603508ae0e21@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Nov 29, 2017 at 07:24:48PM +0100, Javier Martinez Canillas wrote:
> Hello Jarkko,
> 
> On 11/29/2017 06:57 PM, Jarkko Sakkinen wrote:
> > On Wed, Nov 29, 2017 at 12:08:46PM +0100, Javier Martinez Canillas
> > wrote:
> >> +#define TPM2_RC_LAYER_SHIFT	16 +#define TPM2_RESMGRTPM_RC_LAYER
> >> (11 << TPM2_RC_LAYER_SHIFT)
> > 
> > I got this spec from Philip [1].
> > 
> > Couple of remarks:
> > 
> > * What is the difference between TSS2_RESMGR_RC_LAYER and 
> > TSS2_RESMGR_TPM_RC_LAYER?
> 
> The difference is the type of error returned in each case. TSS2_RESMGR_RC_LAYER
> means that's an error internal to the TAB/RM and so the response code is one of
> the TSS2_BASE_RC_* error values.
> 
> But TSS2_RESMGR_TPM_RC_LAYER means that the resource manager is taking over some
> TPM functionality (i.e: validation) and so the response code is a TSS2_RC_* error
> value, liket is the case for this patch (TPM_RC_COMMAND_CODE).
> 
> > * Should the driver code use TSS2 or TPM2 prefix?
> >
> 
> That's a very good question. I used TPM2 as prefix instead of TSS2 to keep it
> consistent with the rest of the driver, but probably TSS2 should be used instead
> so people can search more easy the constant in the specification doc.

OK, I'll change the prefix.

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

I'll postpone testing to next week as I try to get v7 of the SGX patch
set done during this week.

I'll add test case or two for this to my smoke test suite (contributions
are of course welcome):

https://github.com/jsakkine-intel/tpm2-scripts

/Jarkko
