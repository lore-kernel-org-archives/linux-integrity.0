Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5574 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbeJQUUA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Oct 2018 16:20:00 -0400
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Nayna Jain <nayna@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
CC: Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 03/20] tpm: factor out tpm 1.x duration calculation
 to tpm1-cmd.c
Date: Wed, 17 Oct 2018 12:24:28 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9F4691@hasmsx109.ger.corp.intel.com>
References: <20181017064613.19746-1-tomas.winkler@intel.com>
 <20181017064613.19746-4-tomas.winkler@intel.com>
 <05fea3e6-91a3-b508-83c0-d8f06d6bbd5c@linux.ibm.com>
In-Reply-To: <05fea3e6-91a3-b508-83c0-d8f06d6bbd5c@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

> 
> 
> 
> On 10/17/2018 12:15 PM, Tomas Winkler wrote:
> > diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c
> > b/drivers/char/tpm/tpm_i2c_nuvoton.c
> > index caa86b19c76d..5d20e98b844f 100644
> > --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> > +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> > @@ -370,6 +370,7 @@ static int i2c_nuvoton_send(struct tpm_chip *chip,
> u8 *buf, size_t len)
> >   	struct i2c_client *client = to_i2c_client(dev);
> >   	u32 ordinal;
> >   	size_t count = 0;
> > +	unsigned long duration;
> >   	int burst_count, bytes2write, retries, rc = -EIO;
> >
> >   	for (retries = 0; retries < TPM_RETRY; retries++) { @@ -455,12
> > +456,11 @@ static int i2c_nuvoton_send(struct tpm_chip *chip, u8 *buf,
> size_t len)
> >   		return rc;
> >   	}
> >   	ordinal = be32_to_cpu(*((__be32 *) (buf + 6)));
> > -	rc = i2c_nuvoton_wait_for_data_avail(chip,
> > -					     tpm_calc_ordinal_duration(chip,
> > -								       ordinal),
> > -					     &priv->read_queue);
> > +	duration = tpm1_calc_ordinal_duration(chip, ordinal);
> 
> 
> This version of the patch didn't address my previous comment - "The original
> code in the nuvoton driver does not differentiate between TPM 1.2 and TPM
> 2.0 as it does in tpm_tis_core.c.
> Before making any changes, I would first fix it, so that it could easily be
> backported. Only then do the refactoring."

This patch doesn't change the original behavior, just change the name of the function,  so there is no regression.
I would suggest there is another bug in those drivers/devices that is orthogonal to this refactoring and should not block this from merging.
According to what you say  it can call just tpm_calc_oridnal_duration() instead of tpm1_calc_ordinal_duration(chip, ordinal),
but I prefer that someone that has those devices will do that change on top of this series as  I cannot test it.

Thanks
Tomas
