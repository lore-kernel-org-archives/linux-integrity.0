Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:16581 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752838AbeFURNL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Jun 2018 13:13:11 -0400
Date: Thu, 21 Jun 2018 20:13:08 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] tpm: Implement tpm_chip_find() and tpm_chip_put()
 for other subsystems
Message-ID: <20180621171308.GH11859@linux.intel.com>
References: <20180620204236.1572523-1-stefanb@linux.vnet.ibm.com>
 <20180620204236.1572523-2-stefanb@linux.vnet.ibm.com>
 <20180620205004.GG27445@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180620205004.GG27445@ziepe.ca>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Wed, Jun 20, 2018 at 02:50:04PM -0600, Jason Gunthorpe wrote:
> On Wed, Jun 20, 2018 at 04:42:33PM -0400, Stefan Berger wrote:
> > Implement tpm_chip_find() for other subsystems to find a TPM chip and
> > get a reference to that chip. Once done with using the chip, the reference
> > is released using tpm_chip_put().
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> >  drivers/char/tpm/tpm-chip.c | 37 +++++++++++++++++++++++++++++++++++++
> >  include/linux/tpm.h         |  9 +++++++++
> >  2 files changed, 46 insertions(+)
> > 
> > diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> > index 0a62c19937b6..eaaf41ce73d8 100644
> > +++ b/drivers/char/tpm/tpm-chip.c
> > @@ -81,6 +81,43 @@ void tpm_put_ops(struct tpm_chip *chip)
> >  EXPORT_SYMBOL_GPL(tpm_put_ops);
> >  
> >  /**
> > + * tpm_chip_put() - Release a ref to the tpm_chip
> > + * @chip: Chip to put
> > + */
> > +void tpm_chip_put(struct tpm_chip *chip)
> > +{
> > +	if (chip)
> > +		put_device(&chip->dev);
> 
> Rarely like to see those if's inside a put function.. Does it actually
> help anything?
> 
> Jason

The check only helps to hidden regressions here...

/Jarkko
