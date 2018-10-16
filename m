Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:49492 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbeJPOJ0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Oct 2018 10:09:26 -0400
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] tpm: tpm_try_transmit() ignore value of go_to_idle()
Date: Tue, 16 Oct 2018 06:20:29 +0000
Message-ID: <5B8DA87D05A7694D9FA63FD143655C1B9D9F2C7C@hasmsx109.ger.corp.intel.com>
References: <20181015111434.7777-1-tomas.winkler@intel.com>
 <20181016054155.GA18664@ziepe.ca>
In-Reply-To: <20181016054155.GA18664@ziepe.ca>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>



> 
> On Mon, Oct 15, 2018 at 02:14:34PM +0300, Tomas Winkler wrote:
> > Ignore the return value of go_to_idle() in tpm_try_transmit().
> > Once it may shadow the return value of actual tpm operation, second
> > the consequent command will fail as well and the error will be caought
> > anyway.
> > Last fix wrong goto, that jumped back instead of forward.
> >
> > Fixes: 627448e85c76 ("tpm: separate cmd_ready/go_idle from
> > runtime_pm")
> > Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> > drivers/char/tpm/tpm-interface.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm-interface.c
> > b/drivers/char/tpm/tpm-interface.c
> > index 129f640424b7..f69c711bf74a 100644
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -547,9 +547,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip
> *chip,
> >  		dev_err(&chip->dev, "tpm2_commit_space: error %d\n", rc);
> >
> >  out:
> > -	rc = tpm_go_idle(chip, flags);
> > -	if (rc)
> > -		goto out;
> > +	(void)tpm_go_idle(chip, flags);
> 
> We don't really use this style in the kernel, AFAIK.


Right, there are no many of those; just wanted to emphasize that return value is ignored. I can drop (void).

Thanks
Tomas
