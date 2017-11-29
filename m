Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:58565 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934976AbdK2R5q (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Nov 2017 12:57:46 -0500
Date: Wed, 29 Nov 2017 19:57:38 +0200
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
Message-ID: <20171129175738.pim7is5zc3wmult6@linux.intel.com>
References: <20171129110846.31892-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171129110846.31892-1-javierm@redhat.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Nov 29, 2017 at 12:08:46PM +0100, Javier Martinez Canillas wrote:
> +#define TPM2_RC_LAYER_SHIFT	16
> +#define TPM2_RESMGRTPM_RC_LAYER (11 << TPM2_RC_LAYER_SHIFT)

I got this spec from Philip [1].

Couple of remarks:

* What is the difference between TSS2_RESMGR_RC_LAYER and
  TSS2_RESMGR_TPM_RC_LAYER?
* Should the driver code use TSS2 or TPM2 prefix?

[1] https://trustedcomputinggroup.org/wp-content/uploads/TCG-TSS-2.0-Overview-and-Common-Structures-Specification-Version-0.90-Revision-02.pdf

/Jarkko
